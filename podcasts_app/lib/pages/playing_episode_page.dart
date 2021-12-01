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
      padding: const EdgeInsets.only(top: 40, left: 10),
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
      padding: const EdgeInsets.fromLTRB(31, 35, 31, 0),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(33, 10, 26, 15),
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
        sliderWidth: 348,
        onValueChanged: bloc.changePosition);
  }

  _buildLabels(ProgressIndicatorContent content) {
    final currentPosition = Utils.convertFrom(content.currentPosition);
    final episode = content.episodeList[content.currentIndex];
    final duration = Utils.convertFrom(episode.duration);
    final isLoading = content.playerState == loadingState;
    final hasFailedToBuffer = content.playerState == errorState;

    return Row(
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
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
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
        ]);
  }

  _buildAudioControlActions(ProgressIndicatorContent content) {
    final playerState = content.playerState;
    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isComplete = playerState == completedState;
    final isInactive = isLoading || isComplete;
    final isPlayingSeries = content.episodeList.length > 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(
                iconSize: 35,
                isInactive: isLoading || !isPlayingSeries,
                iconColor: AppColors.secondaryColor,
                icon: EvaIcons.skipBackOutline,
                callback: isPlayingSeries ? bloc.skipToPrev : () {}),
            _buildIconButton(
                iconSize: 35,
                isInactive: isLoading,
                iconColor: AppColors.secondaryColor,
                icon: Icons.replay_10_outlined,
                callback: () => bloc.changePosition(10000,
                    positionRequiresUpdate: true, isForwarding: false)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: _buildIconButton(
                  icon: isPlaying ? Icons.pause : Ionicons.play,
                  backgroundColor: AppColors.primaryColor,
                  isInactive: isLoading,
                  iconColor: AppColors.onPrimary,
                  callback: isLoading ? () {} : bloc.togglePlayerStatus,
                  iconSize: 30),
            ),
            _buildIconButton(
                iconSize: 35,
                icon: Icons.forward_30_outlined,
                isInactive: isInactive,
                iconColor: AppColors.secondaryColor,
                callback: () =>
                    bloc.changePosition(30000, positionRequiresUpdate: true)),
            _buildIconButton(
                iconSize: 35,
                isInactive: isLoading || !isPlayingSeries,
                iconColor: AppColors.secondaryColor,
                icon: EvaIcons.skipForwardOutline,
                callback: isPlayingSeries ? bloc.skipToNext : () {})
          ]),
    );
  }

  _buildProgressIndicatorActions(String id) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 15),
      child: Row(
        children: [
          AppTextButton(
            callback: () => bloc.share(id),
            text: 'Share',
            radius: 10,
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
      bool isInactive = false,
      IconData icon = Icons.home,
      required double iconSize}) {
    return TextButton(
        child: Icon(icon,
            color: isInactive ? AppColors.disabledColor : iconColor,
            size: iconSize),
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
