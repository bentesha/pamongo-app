import 'package:lottie/lottie.dart';
import 'package:podcasts/models/saved_episodes.dart';
import 'package:podcasts/source.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EpisodeActionButtons extends StatefulWidget {
  const EpisodeActionButtons(
      {required this.playCallback,
      required this.markAsDoneCallback,
      required this.status,
      required this.id,
      required this.duration,
      required this.savedEpisode,
      required this.savedEpisodeStatus,
      required this.shareCallback,
      key})
      : super(key: key);

  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback, shareCallback;
  final String status;
  final String duration, id, savedEpisodeStatus;
  final SavedEpisode savedEpisode;

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
    return Padding(
      padding: EdgeInsets.only(top: 8.dh, bottom: 6.dh),
      child: Row(children: [
        _buildStatusButton(),
        _buildShareButton(),
        _buildCheckmarkButton(),
      ]),
    );
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share,
        callback: () => widget.shareCallback(widget.id));
  }

/*  _buildStatusButton() {
    return GestureDetector(
      onTap: widget.playCallback,
      child: Container(
          height: 30.dh,
          padding: EdgeInsets.symmetric(horizontal: 10.dw),
          margin: EdgeInsets.only(right: 15.dw),
          decoration: _decoration(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _statusIcon(),
            _statusText(),
          ])),
    );
  }*/

  _buildStatusButton() {
    final isPlaying = widget.status == 'Playing';
    final isPaused = widget.status == 'Paused';

    return AppTextButton(
      onPressed: widget.playCallback,
      padding: EdgeInsets.symmetric(horizontal: 10.dw),
      margin: EdgeInsets.only(right: 15.dw),
      borderRadius: 15.dw,
      height: 30.dh,
      borderColor: isPlaying || isPaused
          ? AppColors.borderColor
          : AppColors.disabledColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _statusIcon(),
        _statusText(),
      ]),
    );
  }

  _statusIcon() {
    final isPlaying = widget.status == 'Playing';
    final isLoading = widget.status == 'Loading';
    final isPaused = widget.status == 'Paused';
    final isCompleted = widget.status == 'Completed';
    final isSaved = widget.savedEpisode.position != 0;

    return isPlaying
        ? Lottie.asset('assets/icons/playing.json',
            fit: BoxFit.contain, height: 30.dh)
        : isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.dw),
                child: Lottie.asset('assets/icons/loading_2.json',
                    fit: BoxFit.contain, height: 15.dh),
              )
            : isCompleted
                ? Icon(AppIcons.playCircled,
                    size: 20.dw, color: AppColors.primaryColor)
                : isPaused || isSaved
                    ? _circularIndicator()
                    : Icon(AppIcons.playCircled,
                        size: 20.dw, color: AppColors.primaryColor);
  }

  _statusText() {
    final isPlaying = widget.status == 'Playing';
    final isLoading = widget.status == 'Loading';
    final isPaused = widget.status == 'Paused';
    final isCompleted = widget.status == 'Completed';
    var savedStatus = widget.savedEpisodeStatus;

    if (widget.savedEpisodeStatus.contains('00 min')) savedStatus = '< 1 min ';

    return AppText(
        isPlaying || isLoading
            ? ' ${widget.status}'
            : isPaused
                ? '   ${savedStatus}left'
                : isCompleted
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
    final isPlaying = widget.status == "Playing";
    final isLoading = widget.status == "Loading";
    final isPaused = widget.status == 'Paused';

    if (!isSaved || isPlaying || isLoading || isPaused) return Container();
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            overlayState.insert(overlayEntry);
            final renderBox =
                key.currentContext!.findRenderObject() as RenderBox;
            final position = renderBox.localToGlobal(Offset.zero);
            tappedPositionNotifier.value = position;
          },
          child: Icon(EvaIcons.moreVerticalOutline,
              key: key, color: AppColors.secondaryColor, size: 20.dw),
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
    return Padding(
      padding: EdgeInsets.only(right: 15.dw),
      child: IconButton(
          onPressed: callback,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(icon, color: AppColors.primaryColor, size: 20.dw)),
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
                              top: tappedPosition.dy - 15.dh,
                              left: tappedPosition.dx - 145.dw,
                              child: MaterialButton(
                                color: AppColors.secondaryColor,
                                highlightColor: Colors.white,
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
                                        size: 16.w, color: AppColors.onPrimary),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  )),
            ));
  }
}
