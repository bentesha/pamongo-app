import 'package:fluttertoast/fluttertoast.dart';
import 'package:podcasts/widgets/app_slider.dart';
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
      padding: EdgeInsets.only(top: 40.dh, left: 24.dw),
      alignment: Alignment.centerLeft,
      child: _buildIconButton(
          callback: () {
            Navigator.pop(context);
            bloc.toggleVisibilityStatus();
          },
          icon: EvaIcons.arrowIosDownwardOutline),
    );
  }

  _buildTitle(Episode episode) {
    return Padding(
      padding: EdgeInsets.fromLTRB(31.dw, 65.dh, 31.dw, 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        AppImage(
          radius: 10.dw,
          imageUrl: episode.image,
          height: 350.dh,
          width: 400.dw,
        ),
        SizedBox(height: 25.dh),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.dh),
            AppText(episode.title,
                size: 16.w,
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
      padding: EdgeInsets.fromLTRB(32.dw, 40.dh, 26.dw, 15.dh),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSliderLine(content),
          _buildLabels(content),
        ],
      ),
    );
  }

  _buildSliderLine(ProgressIndicatorContent content) {
    final currentPosition = content.currentPosition;
    final bufferedPosition = content.bufferedPosition;
    final episode = content.episodeList[content.currentIndex];
    final duration = episode.duration;

    return AppSlider(
        currentValue: currentPosition,
        bufferedValue: bufferedPosition,
        duration: duration,
        sliderWidth: 350.dw,
        onValueChanged: bloc.changePosition);
  }

  _buildLabels(ProgressIndicatorContent content) {
    final currentPosition =
        Utils.convertFrom(content.currentPosition, isUsedOnAudioSlider: true);
    final episode = content.episodeList[content.currentIndex];
    final duration =
        Utils.convertFrom(episode.duration, isUsedOnAudioSlider: true);
    final isLoading = content.playerState == loadingState;
    final hasFailedToBuffer = content.playerState == errorState;

    return Row(
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
        ]);
  }

  _buildAudioControlActions(ProgressIndicatorContent content) {
    final playerState = content.playerState;
    final isPlayingSeries = content.episodeList.length > 1;

    return Padding(
      padding: EdgeInsets.fromLTRB(22.dw, 30.dh, 18.dw, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                callback: bloc.skipToPrev,
                isInactive: playerState.isLoading || !isPlayingSeries,
                icon: EvaIcons.skipBackOutline),
            _buildIconButton(
                callback: () => bloc.changePosition(30000,
                    positionRequiresUpdate: true, isForwarding: false),
                isInactive: playerState.isLoading,
                icon: Icons.replay_30_outlined),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.dw),
              child: TextButton(
                  child: Icon(
                      playerState.isPlaying ? Icons.pause : Ionicons.play,
                      color: AppColors.onPrimary,
                      size: 30.dw),
                  onPressed:
                      playerState.isLoading ? () {} : bloc.togglePlayerStatus,
                  style: TextButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: playerState.isLoading
                          ? AppColors.disabledColor
                          : AppColors.primaryColor,
                      minimumSize: Size.fromRadius(30.dw))),
            ),
            _buildIconButton(
                callback: () =>
                    bloc.changePosition(30000, positionRequiresUpdate: true),
                isInactive: playerState.isLoading || playerState.isCompleted,
                icon: Icons.forward_30_outlined),
            _buildIconButton(
                callback: bloc.skipToNext,
                isInactive: playerState.isLoading || !isPlayingSeries,
                icon: EvaIcons.skipForwardOutline),
          ]),
    );
  }

  _buildProgressIndicatorActions(String id) {
    return Padding(
      padding: EdgeInsets.only(left: 32.dw, top: 15.dw),
      child: Row(
        children: [
          AppTextButton(
            onPressed: () => bloc.share(id),
            text: 'Share',
            borderRadius: 5.dw,
            withIcon: true,
            borderColor: AppColors.disabledColor,
            padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dw),
            icon: EvaIcons.share,
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      {required VoidCallback callback,
      bool isInactive = false,
      required IconData icon}) {
    return AppIconButton(
        iconSize: 35.dw,
        spreadRadius: 30.dw,
        iconColor:
            isInactive ? AppColors.disabledColor : AppColors.secondaryColor,
        icon: icon,
        onPressed: isInactive ? () {} : callback);
  }

  Future<bool> _handleWillPop() async {
    bloc.toggleVisibilityStatus();
    return true;
  }
}
