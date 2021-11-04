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
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildInitial(content),
              _buildContent(content),
            ],
          ),
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
      _buildActions(content)
    ]);
  }

  _buildTitle(Episode episode) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
      child: Column(children: [
        _buildSeriesImage(episode.image),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText(episode.title,
                      color: AppColors.onPrimary,
                      size: 18,
                      weight: FontWeight.w600,
                      maxLines: 2,
                      height: 1.4,
                      alignment: TextAlign.start),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(EvaIcons.heartOutline,
                      size: 25, color: AppColors.onPrimary2),
                )
              ],
            ),
            const SizedBox(height: 5),
            AppText('Ep. ${episode.episodeNumber} from - ' + episode.seriesName,
                color: AppColors.onPrimary2,
                size: 16,
                alignment: TextAlign.start),
          ],
        ),
      ]),
    );
  }

  _buildSeriesImage(String image) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 5),
      child: Column(
        children: [
          Container(
              height: 4,
              width: 25,
              decoration: const BoxDecoration(
                  color: AppColors.separator,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.only(bottom: 30)),
          SizedBox(
            height: 350,
            child: AppImage(
              radius: 10,
              image: image,
              height: 350,
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
      padding: const EdgeInsets.fromLTRB(26, 15, 26, 15),
      child: Column(
        children: [
          SliderTheme(
            data: const SliderThemeData(
                trackHeight: 3,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6)),
            child: Slider(
                activeColor: AppColors.secondary,
                inactiveColor: AppColors.onPrimary2,
                value: isCurrentBigger ? duration : currentPosition,
                min: 0.0,
                max: content.episodeList[content.currentIndex].duration
                    .toDouble(),
                onChanged: bloc.changePosition),
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
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(currentPosition,
                size: 14, weight: FontWeight.w400, color: AppColors.onPrimary2),
            isLoading || hasFailedToBuffer
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: AppText(
                              isLoading ? 'buffering ... ' : 'couldn\'t play',
                              color: AppColors.onPrimary2,
                              size: 14)),
                    ],
                  )
                : Container(),
            AppText(duration,
                size: 14, weight: FontWeight.w400, color: AppColors.onPrimary2)
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

    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isPlayingSeries
              ? _buildIconButton(
                  iconColor:
                      isLoading ? AppColors.inactive : AppColors.onPrimary2,
                  icon: EvaIcons.skipBackOutline,
                  callback: bloc.skipToPrev)
              : Container(),
          _buildIconButton(
              iconColor: isLoading ? AppColors.inactive : AppColors.onPrimary2,
              icon: Icons.replay_10_outlined,
              callback: () => bloc.changePosition(10000,
                  positionRequiresUpdate: true, isForwarding: false)),
          _buildIconButton(
              icon: isPlaying ? Icons.pause : Ionicons.play,
              backgroundColor: AppColors.secondary,
              iconColor: isLoading ? AppColors.inactive : AppColors.onSecondary,
              callback: isLoading ? () {} : bloc.togglePlayerStatus,
              iconSize: 25),
          _buildIconButton(
              icon: Icons.forward_30_outlined,
              iconColor: isInactive ? AppColors.inactive : AppColors.onPrimary2,
              callback: () =>
                  bloc.changePosition(30000, positionRequiresUpdate: true)),
          isPlayingSeries
              ? _buildIconButton(
                  iconColor:
                      isLoading ? AppColors.inactive : AppColors.onPrimary2,
                  icon: EvaIcons.skipForwardOutline,
                  callback: bloc.skipToNext)
              : Container()
        ]);
  }

  _buildIconButton(
      {Color iconColor = AppColors.onPrimary2,
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
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: AppImage(
                    image: episode.image,
                    radius: 7,
                    height: 50,
                    width: 50,
                    withBorders: true),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(episode.title,
                        color: AppColors.onPrimary,
                        size: 15,
                        weight: FontWeight.w600,
                        alignment: TextAlign.start),
                    const SizedBox(height: 3),
                    AppText(
                        'Ep. ${episode.episodeNumber} from - ${episode.seriesName}',
                        alignment: TextAlign.start,
                        color: AppColors.onPrimary2,
                        size: 15),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: isLoading
                    ? Lottie.asset('assets/icons/loading.json',
                        fit: BoxFit.contain, height: 25)
                    : IconButton(
                        onPressed: bloc.togglePlayerStatus,
                        icon: Icon(isPlaying ? Icons.pause : Ionicons.play,
                            color: AppColors.onPrimary2, size: 25)),
              ),
            ],
          ),
        ),
        Container(
            height: 4,
            color: AppColors.secondary,
            width: content.currentPosition == 0 ? 0 : loadingWidth)
      ],
    );
  }
}
