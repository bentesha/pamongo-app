import 'package:lottie/lottie.dart';
import 'package:podcasts/models/saved_episode.dart';
import 'package:podcasts/source.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EpisodeActionButtons extends StatefulWidget {
  const EpisodeActionButtons(
      {required this.playCallback,
      required this.markAsDoneCallback,
      required this.id,
      required this.duration,
      required this.savedEpisode,
      required this.savedEpisodeStatus,
      required this.shareCallback,
      required this.episodeState,
      key})
      : super(key: key);

  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback, shareCallback;
  final String duration, id, savedEpisodeStatus;
  final SavedEpisode savedEpisode;
  final IndicatorPlayerState episodeState;

  @override
  State<EpisodeActionButtons> createState() => _EpisodeActionButtonsState();
}

class _EpisodeActionButtonsState extends State<EpisodeActionButtons> {
  static final tappedPositionNotifier = ValueNotifier<Offset>(Offset.zero);
  late final OverlayState overlayState;
  late final OverlayEntry overlayEntry;
  late GlobalObjectKey key;

  @override
  void initState() {
    key = GlobalObjectKey(Utils.getRandomString());
    overlayState = Overlay.of(context)!;
    overlayEntry = _popUpMenuOverlayEntry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleOnWillPop,
      child: Padding(
        padding: EdgeInsets.only(top: 8.dh, bottom: 6.dh),
        child: Row(children: [
          _buildStatusButton(),
          _buildShareButton(),
          _buildCheckmarkButton(),
        ]),
      ),
    );
  }

  Future<bool> _handleOnWillPop() async {
    try {
      overlayEntry.remove();
      return false;
    } catch (_) {}
    return true;
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share,
        callback: () => widget.shareCallback(widget.id));
  }

  _buildStatusButton() {
    final episodeState = widget.episodeState;

    return AppTextButton(
      onPressed: widget.playCallback,
      padding: EdgeInsets.symmetric(horizontal: 10.dw),
      margin: EdgeInsets.only(right: 15.dw),
      borderRadius: 15.dw,
      height: 30.dh,
      borderColor: episodeState.isPlaying || episodeState.isPaused
          ? AppColors.borderColor
          : AppColors.disabledColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _statusIcon(),
        _statusText(),
      ]),
    );
  }

  _statusIcon() {
    final isSaved = widget.savedEpisode.position != 0;
    final episodeState = widget.episodeState;

    return episodeState.isPlaying
        ? Lottie.asset('assets/icons/playing.json',
            fit: BoxFit.contain, height: 30.dh)
        : episodeState.isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.dw),
                child: Lottie.asset('assets/icons/loading_2.json',
                    fit: BoxFit.contain, height: 15.dh),
              )
            : episodeState.isCompleted
                ? Icon(AppIcons.playCircled,
                    size: 20.dw, color: AppColors.primaryColor)
                : episodeState.isPaused || isSaved
                    ? _circularIndicator()
                    : Icon(AppIcons.playCircled,
                        size: 20.dw, color: AppColors.primaryColor);
  }

  _statusText() {
    var savedStatus = widget.savedEpisodeStatus;
    final episodeState = widget.episodeState;

    if (widget.savedEpisodeStatus.contains('00 min')) savedStatus = '< 1 min ';

    return AppText(
        episodeState.isPlaying
            ? 'Playing'
            : episodeState.isLoading
                ? 'Loading'
                : episodeState.isPaused
                    ? '   ${savedStatus}left'
                    : episodeState.isCompleted
                        ? '  ${widget.duration}'
                        : widget.savedEpisode.position != 0
                            ? '   ${savedStatus}left'
                            : '  ${widget.duration}',
        weight: FontWeight.w400,
        color: AppColors.textColor,
        size: 14.w);
  }

  _buildCheckmarkButton() {
    final isSaved = widget.savedEpisode.position != 0;
    final episodeState = widget.episodeState;

    if (!isSaved ||
        episodeState.isPlaying ||
        episodeState.isLoading ||
        episodeState.isPaused) {
      return Container();
    }

    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: AppIconButton(
          key: key,
          onPressed: () {
            overlayState.insert(overlayEntry);
            final renderBox =
                key.currentContext!.findRenderObject() as RenderBox;
            final position = renderBox.localToGlobal(Offset.zero);
            tappedPositionNotifier.value = position;
          },
          icon: EvaIcons.moreVerticalOutline,
          iconColor: AppColors.secondaryColor,
          iconSize: 20.dw,
        ),
      ),
    );
  }

  _circularIndicator() {
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: widget.savedEpisode.timeLeftInPercentage,
      stepSize: 1,
      selectedColor: AppColors.primaryColor,
      unselectedColor: AppColors.disabledColor,
      padding: 0,
      width: 20.dw,
      height: 20.dw,
      selectedStepSize: 2,
      unselectedStepSize: 1,
      roundedCap: (_, __) => true,
    );
  }

  _iconButton(IconData icon, {required VoidCallback callback}) {
    return AppIconButton(
      onPressed: callback,
      icon: icon,
      iconColor: AppColors.primaryColor,
      iconSize: 20.dw,
      margin: EdgeInsets.only(right: 15.dw),
    );
  }

  OverlayEntry _popUpMenuOverlayEntry() {
    return OverlayEntry(
        builder: (_) => GestureDetector(
              onTap: () => overlayEntry.remove(),
              child: Container(
                  color: Colors.white.withOpacity(0.0),
                  width: 100.dw,
                  child: Stack(
                    children: [
                      ValueListenableBuilder<Offset>(
                          valueListenable: tappedPositionNotifier,
                          builder: (context, tappedPosition, snapshot) {
                            return Positioned(
                              top: tappedPosition.dy - 10.dh,
                              left: tappedPosition.dx - 145.dw,
                              child: Material(
                                color: Colors.transparent,
                                child: AppTextButton(
                                  buttonColor: AppColors.secondaryColor,
                                  highlightColor: Colors.grey,
                                  onPressed: () {
                                    widget.markAsDoneCallback(widget.id);
                                    overlayEntry.remove();
                                  },
                                  height: 40,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.dw, vertical: 5.dw),
                                  child: Row(
                                    children: [
                                      Icon(EvaIcons.checkmark,
                                          size: 18.dw,
                                          color: AppColors.accentColor),
                                      SizedBox(width: 10.dw),
                                      AppText('Mark As Done',
                                          size: 16.w,
                                          color: AppColors.onPrimary),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  )),
            ));
  }
}
