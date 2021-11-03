import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:podcasts/blocs/progress_indicator_bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/progress_indicator_state.dart';
import '../source.dart';

class AppProgressIndicator extends StatefulWidget {
  final bool isShowInitial;

  const AppProgressIndicator(this.isShowInitial, {key}) : super(key: key);

  @override
  State<AppProgressIndicator> createState() => _AppProgressIndicatorState();
}

class _AppProgressIndicatorState extends State<AppProgressIndicator> {
  late final AudioPlayerService service;
  late final ProgressIndicatorBloc bloc;
  Widget title = Container();

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = ProgressIndicatorBloc(service);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProgressIndicatorBloc, ProgressIndicatorState>(
        bloc: bloc,
        listener: (context, state) {
          final error =
              state.maybeWhen(failed: (_, e) => e, orElse: () => null);

          if (error != null) _showError(error);
        },
        builder: (context, state) {
          return state.when(
              active: _buildActive,
              inactive: _buildInactive,
              failed: _buildFailed,
              loading: _buildLoading);
        });
  }

  Widget _buildActive(ProgressIndicatorContent content) {
    return Container(
      color: AppColors.primary,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _buildInitial(content),
          _buildContent(content),
        ],
      ),
    );
  }

  Widget _buildInactive(ProgressIndicatorContent content) {
    return Container();
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

  Widget _buildFailed(ProgressIndicatorContent content, AudioError error) {
    return _buildActive(content);
  }

  Widget _buildLoading(ProgressIndicatorContent content) {
    return _buildActive(content);
  }

  _buildInitial(ProgressIndicatorContent content) {
    return widget.isShowInitial ? _initialWidget(content) : Container();
  }

  _buildContent(ProgressIndicatorContent content) {
    final episode = content.episodeList[content.currentIndex];

    return Column(children: [
      _buildTitle(episode),
      _buildSlider(content),
      _buildActions(content),
    ]);
  }

  _buildTitle(Episode episode) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30.dw, 15.dh, 30.dw, 0),
      child: Column(children: [
        _buildSeriesImage(episode.image),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.dh),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText(episode.title,
                      color: AppColors.onPrimary,
                      size: 18.w,
                      weight: FontWeight.w600,
                      maxLines: 2,
                      height: 1.4,
                      alignment: TextAlign.start),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.dw),
                  child: Icon(EvaIcons.heartOutline,
                      size: 25.dw, color: AppColors.onPrimary2),
                )
              ],
            ),
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

  _buildSeriesImage(String image) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 5.dh),
      child: Column(
        children: [
          Container(
              height: 4.dh,
              width: 25.dw,
              decoration: BoxDecoration(
                  color: AppColors.separator,
                  borderRadius: BorderRadius.all(Radius.circular(10.dw))),
              margin: EdgeInsets.only(bottom: 30.dh)),
          SizedBox(
            height: 350.dh,
            child: AppImage(
              radius: 10.dw,
              image: image,
              height: 350.h,
              fullWidth: true,
              withBorders: true,
            ),
          ),
        ],
      ),
    );
  }

  _buildSlider(ProgressIndicatorContent content) {
    final currentPosition = content.currentPosition.toDouble();
    final episode = content.episodeList[content.currentIndex];
    final duration = episode.duration.toDouble();
    final isCurrentBigger = currentPosition >= duration;

    return Padding(
      padding: EdgeInsets.fromLTRB(26.dw, 15.dh, 26.dw, 15.dh),
      child: Column(
        children: [
          Container(
            height: 30.dh,
            margin: EdgeInsets.fromLTRB(0, 20.dh, 0, 10.dh),
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

  _buildActions(ProgressIndicatorContent content) {
    final playerState = content.playerState;
    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isComplete = playerState == completedState;
    final isInactive = isLoading || isComplete;
    final isPlayingSeries = content.episodeList.length > 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(16.dw, 0.dh, 16.dw, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isPlayingSeries
                ? _buildIconButton(
                    iconSize: 35.dw,
                    iconColor:
                        isLoading ? AppColors.inactive : AppColors.onPrimary2,
                    icon: EvaIcons.skipBackOutline,
                    callback: bloc.skipToPrev)
                : Container(),
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
            isPlayingSeries
                ? _buildIconButton(
                    iconSize: 35.dw,
                    iconColor:
                        isLoading ? AppColors.inactive : AppColors.onPrimary2,
                    icon: EvaIcons.skipForwardOutline,
                    callback: bloc.skipToNext)
                : Container()
          ]),
    );
  }

  _buildIconButton(
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

  Widget _initialWidget(ProgressIndicatorContent content) {
    final episode = content.episodeList[content.currentIndex];
    final fullWidth = MediaQuery.of(context).size.width;
    final loadingWidth = content.currentPosition * fullWidth / episode.duration;
    final isPlaying = content.playerState == playingState;
    final isLoading = content.playerState == loadingState;

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          color: AppColors.primary,
          height: 70.dh,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.dw),
                    child: episode.image == ''
                        ? Container(
                            height: 50.dh,
                            width: 50.dh,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.podcasts,
                              size: 25.dw,
                              color: AppColors.onSecondary2,
                            ))
                        : AppImage(
                            image: episode.image,
                            radius: 7.dw,
                            height: 50.h,
                            width: 50.h,
                            withBorders: true),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          episode.title.length > 38
                              ? episode.title.substring(0, 38) + ' ...'
                              : episode.title,
                          color: AppColors.onPrimary,
                          size: 15.w,
                          weight: FontWeight.w600,
                          alignment: TextAlign.start),
                      SizedBox(height: 3.dh),
                      AppText(
                          'Ep. ${episode.episodeNumber} from - ${episode.seriesName}',
                          alignment: TextAlign.start,
                          color: AppColors.onPrimary2,
                          size: 15.w),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: isLoading
                      ? Padding(
                          padding: EdgeInsets.only(right: 20.dw),
                          child: Lottie.asset('assets/icons/loading.json',
                              fit: BoxFit.contain, height: 25.dh),
                        )
                      : IconButton(
                          onPressed: bloc.togglePlayerStatus,
                          icon: Icon(isPlaying ? Icons.pause : Ionicons.play,
                              color: AppColors.onPrimary2, size: 25.dw),
                          padding: EdgeInsets.symmetric(horizontal: 20.dw),
                        ),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 4.dh,
            color: AppColors.secondary,
            width: content.currentPosition == 0 ? 0 : loadingWidth)
      ],
    );
  }
}
