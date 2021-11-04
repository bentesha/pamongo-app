import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:podcasts/blocs/progress_indicator_bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/states/progress_indicator_state.dart';
import '../source.dart';

class PlayingEpisodePage extends StatefulWidget {
  const PlayingEpisodePage(this.bloc, {key}) : super(key: key);

  final ProgressIndicatorBloc bloc;

  @override
  State<PlayingEpisodePage> createState() => _PlayingEpisodePageState();
}

class _PlayingEpisodePageState extends State<PlayingEpisodePage> {
  late final ProgressIndicatorBloc bloc;

  @override
  void initState() {
    bloc = widget.bloc;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.active,
                  AppColors.active.withOpacity(.85),
                  AppColors.primary,
                ]),
          ),
          child: BlocConsumer<ProgressIndicatorBloc, ProgressIndicatorState>(
              bloc: bloc,
              listener: (context, state) {
                final error = state.maybeWhen(
                    failed: (_, __, e) => e, orElse: () => null);

                if (error != null) _showError(error);
              },
              builder: (context, state) {
                return state.when(active: _buildContent, failed: _buildFailed);
              }),
        ),
      ),
    );
  }

  Widget _buildFailed(
      ProgressIndicatorContent content, bool isHiding, AudioError error) {
    return _buildContent(content, isHiding);
  }

  _showError(AudioError error) async {
    Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.error,
        textColor: AppColors.onPrimary);
  }

  Widget _buildContent(ProgressIndicatorContent content, bool isHiding) {
    final episode = content.episodeList[content.currentIndex];

    return Column(children: [
      _buildDropButton(),
      _buildTitle(episode),
      _buildProgressIndicatorActions(),
      _buildSlider(content),
      _buildAudioControlActions(content),
    ]);
  }

  _buildDropButton() {
    return Container(
      padding: EdgeInsets.only(top: 40.dh, left: 18.dw),
      alignment: Alignment.centerLeft,
      child: _buildIconButton(
          callback: () {
            Navigator.pop(context);
            bloc.toggleVisibilityStatus();
          },
          icon: EvaIcons.arrowIosDownwardOutline,
          iconSize: 30),
    );
  }

  _buildTitle(Episode episode) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.dw, 50.dh, 30.dw, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppImage(
          radius: 10.dw,
          image: episode.image,
          height: 350.h,
          fullWidth: true,
          withBorders: true,
        ),
        SizedBox(height: 40.dh),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.dh),
            AppText(episode.title,
                color: AppColors.onPrimary,
                size: 18.w,
                weight: FontWeight.w600,
                maxLines: 2,
                height: 1.4,
                alignment: TextAlign.start),
            SizedBox(height: 5.dh),
            AppText('Ep. ${episode.episodeNumber} from - ' + episode.seriesName,
                color: AppColors.onPrimary2,
                size: 16.w,
                alignment: TextAlign.start),
          ],
        ),
      ]),
    );
  }

  _buildSlider(ProgressIndicatorContent content) {
    final currentPosition = content.currentPosition.toDouble();
    final episode = content.episodeList[content.currentIndex];
    final duration = episode.duration.toDouble();
    final isCurrentBigger = currentPosition >= duration;

    return Padding(
      padding: EdgeInsets.fromLTRB(26.dw, 0, 26.dw, 15.dh),
      child: Column(
        children: [
          Container(
            height: 30.dh,
            margin: EdgeInsets.fromLTRB(0, 15.dh, 0, 10.dh),
            child: SliderTheme(
              data: SliderThemeData(
                  trackHeight: 3.dh,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.dw),
                  overlayShape: SliderComponentShape.noThumb),
              child: Slider(
                  activeColor: AppColors.secondary,
                  inactiveColor: AppColors.onPrimary2,
                  value: isCurrentBigger ? duration : currentPosition,
                  min: 0.0,
                  max: content.episodeList[content.currentIndex].duration
                      .toDouble(),
                  onChanged: bloc.changePosition),
            ),
          ),
          _buildLabels(content),
        ],
      ),
    );
  }

  _buildLabels(ProgressIndicatorContent content) {
    final currentPosition = Utils.convertFrom(content.currentPosition);
    final episode = content.episodeList[content.currentIndex];
    final duration = Utils.convertFrom(episode.duration);
    final isLoading = content.playerState == loadingState;
    final hasFailedToBuffer = content.playerState == errorState;

    return Padding(
      padding: EdgeInsets.only(left: 6.dw, right: 4.dw, bottom: 10.dh),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(currentPosition,
                size: 14.w,
                weight: FontWeight.w400,
                color: AppColors.onPrimary2),
            isLoading || hasFailedToBuffer
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(15.dw, 0, 0, 0),
                          child: AppText(
                              isLoading ? 'buffering ... ' : 'couldn\'t play',
                              color: AppColors.onPrimary2,
                              size: 14.w)),
                    ],
                  )
                : Container(),
            AppText(duration,
                size: 14.w,
                weight: FontWeight.w400,
                color: AppColors.onPrimary2)
          ]),
    );
  }

  _buildAudioControlActions(ProgressIndicatorContent content) {
    final playerState = content.playerState;
    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isComplete = playerState == completedState;
    final isInactive = isLoading || isComplete;
    final isPlayingSeries = content.episodeList.length > 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.dw, 10.dh, 16.dw, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                iconSize: 35.dw,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.inactive
                    : AppColors.onPrimary2,
                icon: EvaIcons.skipBackOutline,
                callback: isPlayingSeries ? bloc.skipToPrev : () {}),
            _buildIconButton(
                iconSize: 35.dw,
                iconColor:
                    isLoading ? AppColors.inactive : AppColors.onPrimary2,
                icon: Icons.replay_10_outlined,
                callback: () => bloc.changePosition(10000,
                    positionRequiresUpdate: true, isForwarding: false)),
            _buildIconButton(
                icon: isPlaying ? Icons.pause : Ionicons.play,
                backgroundColor: AppColors.secondary,
                iconColor:
                    isLoading ? AppColors.inactive : AppColors.onSecondary,
                callback: isLoading ? () {} : bloc.togglePlayerStatus,
                iconSize: 25.dw),
            _buildIconButton(
                iconSize: 35.dw,
                icon: Icons.forward_30_outlined,
                iconColor:
                    isInactive ? AppColors.inactive : AppColors.onPrimary2,
                callback: () =>
                    bloc.changePosition(30000, positionRequiresUpdate: true)),
            _buildIconButton(
                iconSize: 35.dw,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.inactive
                    : AppColors.onPrimary2,
                icon: EvaIcons.skipForwardOutline,
                callback: isPlayingSeries ? bloc.skipToNext : () {})
          ]),
    );
  }

  _buildProgressIndicatorActions() {
    return Padding(
      padding: EdgeInsets.only(left: 18.dw, top: 15.dw),
      child: Row(
        children: [
          _buildIconButton(
              callback: () {},
              iconSize: 23.dw,
              icon: AppIcons.addToPlayList,
              iconColor: AppColors.onPrimary2),
          _buildIconButton(
              callback: () {},
              iconSize: 23.dw,
              icon: AppIcons.download,
              iconColor: AppColors.onPrimary2),
          _buildIconButton(
              callback: () {},
              iconSize: 23.dw,
              icon: AppIcons.bookmark,
              iconColor: AppColors.onPrimary2),
          _buildIconButton(
              callback: () {},
              iconSize: 23.dw,
              icon: AppIcons.share,
              iconColor: AppColors.onPrimary2),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      {Color iconColor = AppColors.onPrimary2,
      Color backgroundColor = Colors.transparent,
      required VoidCallback callback,
      IconData icon = Icons.home,
      required double iconSize}) {
    return TextButton(
        child: Icon(icon, color: iconColor, size: iconSize),
        onPressed: callback,
        style: TextButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: backgroundColor,
            minimumSize: Size.fromRadius(25.dw)));
  }

  Future<bool> _handleWillPop() async {
    bloc.toggleVisibilityStatus();
    return true;
  }
}
