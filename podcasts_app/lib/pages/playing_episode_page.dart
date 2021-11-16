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
                  AppColors.indicatorColor,
                  AppColors.indicatorColor.withOpacity(.85),
                  AppColors.indicatorColor.withOpacity(.75),
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
        backgroundColor: AppColors.primaryColor,
        textColor: AppColors.onPrimary);
  }

  Widget _buildContent(ProgressIndicatorContent content, bool isHiding) {
    final episode = content.episodeList[content.currentIndex];

    return ListView(padding: EdgeInsets.zero, children: [
      _buildDropButton(),
      _buildTitle(episode),
      _buildProgressIndicatorActions(content),
      _buildSlider(content),
      _buildAudioControlActions(content),
    ]);
  }

  _buildDropButton() {
    return Container(
      padding: const EdgeInsets.only(top: 40, left: 18),
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
      padding: const EdgeInsets.fromLTRB(30, 35, 30, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppImage(
          radius: 10,
          image: episode.image,
          height: 350,
          fullWidth: true,
        ),
        const SizedBox(height: 25),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            AppText(episode.title,
                size: 18,
                weight: FontWeight.w600,
                maxLines: 2,
                height: 1.4,
                alignment: TextAlign.start),
            const SizedBox(height: 5),
            AppText('Ep. ${episode.episodeNumber} from - ' + episode.seriesName,
                size: 16, alignment: TextAlign.start),
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
      padding: const EdgeInsets.fromLTRB(26, 15, 26, 15),
      child: Column(
        children: [
          Container(
            height: 30,
            margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
            child: SliderTheme(
              data: SliderThemeData(
                  trackHeight: 3,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape: SliderComponentShape.noThumb),
              child: Slider(
                  activeColor: AppColors.accentColor,
                  inactiveColor: AppColors.secondaryColor,
                  value: isCurrentBigger ? duration : currentPosition,
                  min: 0.0,
                  max: content.episodeList[content.currentIndex].duration
                      .toDouble(),
                  onChanged: bloc.changePosition),
            ),
          ),
          _buildLabels(content)
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
      padding: const EdgeInsets.only(left: 5, right: 4, bottom: 10),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              currentPosition,
              size: 14,
              weight: FontWeight.w400,
            ),
            isLoading || hasFailedToBuffer
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: AppText(
                              isLoading ? 'buffering ... ' : 'couldn\'t play',
                              color: AppColors.textColor2,
                              size: 14)),
                    ],
                  )
                : Container(),
            AppText(
              duration,
              size: 14,
              weight: FontWeight.w400,
            )
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
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                iconSize: 35,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: EvaIcons.skipBackOutline,
                callback: isPlayingSeries ? bloc.skipToPrev : () {}),
            _buildIconButton(
                iconSize: 35,
                iconColor: isLoading
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: Icons.replay_10_outlined,
                callback: () => bloc.changePosition(10000,
                    positionRequiresUpdate: true, isForwarding: false)),
            _buildIconButton(
                icon: isPlaying ? Icons.pause : Ionicons.play,
                backgroundColor: AppColors.accentColor,
                iconColor: isLoading
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                callback: isLoading ? () {} : bloc.togglePlayerStatus,
                iconSize: 30),
            _buildIconButton(
                iconSize: 35,
                icon: Icons.forward_30_outlined,
                iconColor: isInactive
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                callback: () =>
                    bloc.changePosition(30000, positionRequiresUpdate: true)),
            _buildIconButton(
                iconSize: 35,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: EvaIcons.skipForwardOutline,
                callback: isPlayingSeries ? bloc.skipToNext : () {})
          ]),
    );
  }

  _buildProgressIndicatorActions(ProgressIndicatorContent content) {
    final playerState = content.playerState;
    final isLoading = playerState == loadingState;
    final isPlayingSeries = content.episodeList.length > 1;
    return Padding(
      padding: const EdgeInsets.only(left: 18, top: 15),
      child: Row(
        children: [
          isPlayingSeries
              ? _buildIconButton(
                  iconColor: isLoading
                      ? AppColors.disabledColor
                      : AppColors.onPrimary2,
                  icon: EvaIcons.skipBackOutline,
                  callback: bloc.skipToPrev)
              : Container(),
          _buildIconButton(
            callback: () {},
            iconSize: 23,
            icon: AppIcons.addToPlayList,
          ),
          _buildIconButton(
            callback: () {},
            iconSize: 23,
            icon: AppIcons.download,
          ),
          _buildIconButton(
            callback: () {},
            iconSize: 23,
            icon: AppIcons.bookmark,
          ),
          _buildIconButton(
            callback: () {},
            iconSize: 23,
            icon: AppIcons.share,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      {Color iconColor = AppColors.primaryColor,
      Color backgroundColor = Colors.transparent,
      required VoidCallback callback,
      IconData icon = Icons.home,
      int iconSize = 35}) {
    return TextButton(
        child: Icon(icon, color: iconColor, size: iconSize.toDouble()),
        onPressed: callback,
        style: TextButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: backgroundColor,
            minimumSize: const Size.fromRadius(30)));
  }

  Future<bool> _handleWillPop() async {
    bloc.toggleVisibilityStatus();
    return true;
  }
}
