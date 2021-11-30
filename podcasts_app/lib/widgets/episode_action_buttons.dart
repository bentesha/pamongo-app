import 'package:lottie/lottie.dart';
import 'package:podcasts/models/saved_episodes.dart';
import 'package:podcasts/source.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'dart:math';

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
  void dispose() {
    print('hellowwwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
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

  _buildStatusButton() {
    return GestureDetector(
      onTap: widget.playCallback,
      child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.only(right: 15),
          decoration: _decoration(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _statusIcon(),
            _statusText(),
          ])),
    );
  }

  _decoration() {
    final isPlaying = widget.status == 'Playing';
    final isPaused = widget.status == 'Paused';
    final shouldShowDecoration = isPlaying | isPaused;

    return BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.transparent,
        border: Border.all(
          width: 1,
          color: shouldShowDecoration
              ? AppColors.borderColor
              : AppColors.disabledColor,
        ));
  }

  _statusIcon() {
    final isPlaying = widget.status == 'Playing';
    final isLoading = widget.status == 'Loading';
    final isPaused = widget.status == 'Paused';
    final isCompleted = widget.status == 'Completed';
    final isSaved = widget.savedEpisode.position != 0;

    return isPlaying
        ? Lottie.asset('assets/icons/playing.json',
            fit: BoxFit.contain, height: 30)
        : isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Lottie.asset('assets/icons/loading_2.json',
                    fit: BoxFit.contain, height: 15),
              )
            : isCompleted
                ? const Icon(AppIcons.playCircled,
                    size: 20, color: AppColors.primaryColor)
                : isPaused || isSaved
                    ? _circularIndicator()
                    : const Icon(AppIcons.playCircled,
                        size: 20, color: AppColors.primaryColor);
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
        size: 14);
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
              key: key, color: AppColors.secondaryColor, size: 20),
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
      width: 20,
      height: 20,
      selectedStepSize: 2,
      unselectedStepSize: 1,
      roundedCap: (_, __) => true,
    );
  }

  _iconButton(IconData icon, {required VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: IconButton(
          onPressed: callback,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(icon, color: AppColors.primaryColor, size: 20)),
    );
  }

  OverlayEntry _popUpMenuOverlayEntry() {
    return OverlayEntry(
        builder: (_) => GestureDetector(
              onTap: () => overlayEntry.remove(),
              child: Container(
                  color: Colors.white.withOpacity(0.0),
                  width: 100,
                  child: Stack(
                    children: [
                      ValueListenableBuilder<Offset>(
                          valueListenable: tappedPositionNotifier,
                          builder: (context, tappedPosition, snapshot) {
                            return Positioned(
                              top: tappedPosition.dy,
                              left: tappedPosition.dx - 145,
                              child: MaterialButton(
                                color: AppColors.secondaryColor,
                                highlightColor: Colors.white,
                                onPressed: () {
                                  widget.markAsDoneCallback(widget.id);
                                  overlayEntry.remove();
                                },
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Row(
                                  children: const [
                                    Icon(EvaIcons.checkmark,
                                        size: 18, color: AppColors.accentColor),
                                    SizedBox(width: 10),
                                    AppText('Mark As Done',
                                        size: 16, color: AppColors.onPrimary),
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
