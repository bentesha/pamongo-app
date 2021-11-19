import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:podcasts/blocs/progress_indicator_bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/states/progress_indicator_state.dart';
import 'package:podcasts/widgets/app_text_button.dart';
import '../source.dart';

class PlayingEpisodePage extends StatefulWidget {
  const PlayingEpisodePage(this.bloc, {key}) : super(key: key);

  final ProgressIndicatorBloc bloc;

  @override
  State<PlayingEpisodePage> createState() => _PlayingEpisodePageState();
}

class _PlayingEpisodePageState extends State<PlayingEpisodePage> {
  late final ProgressIndicatorBloc bloc;
  final positionNotifier = ValueNotifier<double>(0);
  final useAudioPositionNotifier = ValueNotifier<bool>(true);

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
                return state.when(
                    active: _buildContent,
                    failed: _buildFailed,
                    initial: _buildInitial);
              }),
        ),
      ),
    );
  }

  Widget _buildFailed(
      ProgressIndicatorContent content, bool isHiding, AudioError error) {
    return _buildContent(content, isHiding);
  }

  Widget _buildInitial(ProgressIndicatorContent content, bool isHiding) {
    return Container();
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
      _buildProgressIndicatorActions(episode.id),
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
      padding: EdgeInsets.fromLTRB(30.dw, 35.dh, 30.dw, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppImage(
          radius: 10.dw,
          image: episode.image,
          height: 350.h,
          fullWidth: true,
        ),
        SizedBox(height: 25.dh),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.dh),
            AppText(episode.title,
                size: 18.w,
                weight: FontWeight.w600,
                maxLines: 2,
                height: 1.4,
                alignment: TextAlign.start),
            SizedBox(height: 5.dh),
            AppText('Ep. ${episode.episodeNumber} from - ' + episode.seriesName,
                size: 16.w, alignment: TextAlign.start),
          ],
        ),
      ]),
    );
  }

  _buildSlider(ProgressIndicatorContent content) {
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
              child: _buildSliderLine(content),
            ),
          ),
          _buildLabels(content),
        ],
      ),
    );
  }

  _buildSliderLine(ProgressIndicatorContent content) {
    final currentPosition = content.currentPosition.toDouble();
    final episode = content.episodeList[content.currentIndex];

    return ValueListenableBuilder<bool>(
        valueListenable: useAudioPositionNotifier,
        builder: (_, useAudioPosition, __) {
          return ValueListenableBuilder<double>(
              valueListenable: positionNotifier,
              builder: (_, position, __) {
                return Slider(
                  activeColor: AppColors.accentColor,
                  inactiveColor: AppColors.secondaryColor,
                  value: useAudioPosition ? currentPosition : position,
                  min: 0.0,
                  max: episode.duration.toDouble(),
                  onChanged: (value) {
                    useAudioPositionNotifier.value = false;
                    positionNotifier.value = value;
                  },
                  onChangeEnd: (value) {
                    bloc.changePosition(value);
                    useAudioPositionNotifier.value = true;
                  },
                );
              });
        });
  }

  _buildLabels(ProgressIndicatorContent content) {
    final currentPosition = Utils.convertFrom(content.currentPosition);
    final episode = content.episodeList[content.currentIndex];
    final duration = Utils.convertFrom(episode.duration);
    final isLoading = content.playerState == loadingState;
    final hasFailedToBuffer = content.playerState == errorState;

    return Padding(
      padding: EdgeInsets.only(left: 5.dw, right: 4.dw, bottom: 10.dh),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
              currentPosition,
              size: 14.w,
              weight: FontWeight.w400,
            ),
            isLoading || hasFailedToBuffer
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(15.dw, 0, 0, 0),
                          child: AppText(
                              isLoading ? 'buffering ... ' : 'couldn\'t play',
                              color: AppColors.textColor2,
                              size: 14.w)),
                    ],
                  )
                : Container(),
            AppText(
              duration,
              size: 14.w,
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
      padding: EdgeInsets.fromLTRB(16.dw, 10.dh, 16.dw, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                iconSize: 35.dw,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: EvaIcons.skipBackOutline,
                callback: isPlayingSeries ? bloc.skipToPrev : () {}),
            _buildIconButton(
                iconSize: 35.dw,
                iconColor: isLoading
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: Icons.replay_10_outlined,
                callback: () => bloc.changePosition(10000,
                    positionRequiresUpdate: true, isForwarding: false)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.dw),
              child: _buildIconButton(
                  icon: isPlaying ? Icons.pause : Ionicons.play,
                  backgroundColor: AppColors.accentColor,
                  iconColor: isLoading
                      ? AppColors.disabledColor
                      : AppColors.secondaryColor,
                  callback: isLoading ? () {} : bloc.togglePlayerStatus,
                  iconSize: 30.dw),
            ),
            _buildIconButton(
                iconSize: 35.dw,
                icon: Icons.forward_30_outlined,
                iconColor: isInactive
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                callback: () =>
                    bloc.changePosition(30000, positionRequiresUpdate: true)),
            _buildIconButton(
                iconSize: 35.dw,
                iconColor: isLoading || !isPlayingSeries
                    ? AppColors.disabledColor
                    : AppColors.secondaryColor,
                icon: EvaIcons.skipForwardOutline,
                callback: isPlayingSeries ? bloc.skipToNext : () {})
          ]),
    );
  }

  _buildProgressIndicatorActions(String id) {
    return Padding(
      padding: EdgeInsets.only(left: 30.dw, top: 15.dw),
      child: Row(
        children: [
          AppTextButton(
            callback: () => bloc.share(id),
            text: 'Share',
            radius: 10.dw,
            withIcon: true,
            borderColor: AppColors.disabledColor,
            fontWeight: FontWeight.w400,
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
      required double iconSize}) {
    return TextButton(
        child: Icon(icon, color: iconColor, size: iconSize),
        onPressed: callback,
        style: TextButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: backgroundColor,
            minimumSize: Size.fromRadius(30.dw)));
  }

  Future<bool> _handleWillPop() async {
    bloc.toggleVisibilityStatus();
    return true;
  }
}
