import 'package:lottie/lottie.dart';
import 'package:podcasts/models/saved_episodes.dart';
import 'package:podcasts/source.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EpisodeActionButtons extends StatelessWidget {
  const EpisodeActionButtons(
      {required this.playCallback,
      required this.markAsDoneCallback,
      required this.actionPadding,
      required this.status,
      required this.id,
      required this.duration,
      required this.savedEpisode,
      required this.savedEpisodeStatus,
      required this.remainingTime,
      key})
      : super(key: key);

  final EdgeInsetsGeometry actionPadding;
  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback;
  final String status;
  final String duration, id, remainingTime, savedEpisodeStatus;
  final SavedEpisode savedEpisode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: actionPadding,
      child: Row(children: [
        _buildStatusButton(),
        _buildShareButton(),
        _buildCheckmarkButton(),
      ]),
    );
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share, padding: EdgeInsets.only(left: 10.dw));
  }

  _buildCheckmarkButton() {
    final isSaved = savedEpisode.position != 0;
    if (!isSaved) return Container();
    return Expanded(
      child: Container(
        height: 20.dw,
        alignment: Alignment.centerRight,
        child: PopupMenuButton(
          padding: EdgeInsets.only(left: 40.dw),
          iconSize: 20.dw,
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                height: 20.dw,
                onTap: () => markAsDoneCallback(id),
                child: Row(
                  children: [
                    AppText('Mark As Done', size: 16.w),
                    SizedBox(width: 10.dw),
                    Icon(Icons.done, size: 18.dw)
                  ],
                ),
              )
            ];
          },
        ),
      ),
    );
  }

  _buildStatusButton() {
    return GestureDetector(
      onTap: playCallback,
      child: Container(
          height: 30.dh,
          padding: EdgeInsets.fromLTRB(10.dw, 0, 10.dw, 0),
          margin: EdgeInsets.fromLTRB(0, 0, 5.dw, 0),
          decoration: _decoration(),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _statusIcon(),
            _statusText(),
          ])),
    );
  }

  _decoration() {
    final isPlaying = status == 'Playing';
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.dw)),
        color: isPlaying ? AppColors.primaryColor : Colors.transparent,
        border: isPlaying
            ? Border.all(
                width: 1.5,
                color: AppColors.primaryColor,
              )
            : Border.all(
                width: 1,
                color: AppColors.disabledColor,
              ));
  }

  _statusIcon() {
    final isPlaying = status == 'Playing';
    final isLoading = status == 'Loading';
    final isPaused = status == 'Paused';
    final isCompleted = status == 'Completed';

    final savedEpisode =
        Utils.getPlayedStatus(id) ?? SavedEpisode(position: 0, duration: 0);

    return isPlaying
        ? Lottie.asset('assets/icons/playing.json',
            fit: BoxFit.contain, height: 30.dh)
        : isLoading
            ? Lottie.asset('assets/icons/loading_2.json',
                fit: BoxFit.contain, height: 15.dh)
            : isPaused
                ? Icon(AppIcons.play,
                    size: 20.dw, color: AppColors.primaryColor)
                : isCompleted
                    ? Icon(AppIcons.playCircled,
                        size: 20.dw, color: AppColors.accentColor)
                    : savedEpisode.position != 0
                        ? _circularIndicator()
                        : Icon(AppIcons.playCircled,
                            size: 20.dw, color: AppColors.accentColor);
  }

  _statusText() {
    final isPlaying = status == 'Playing';
    final isLoading = status == 'Loading';
    final isPaused = status == 'Paused';
    final isCompleted = status == 'Completed';

    return AppText(
        isPlaying || isLoading
            ? '  ' + status
            : isPaused
                ? '   ${remainingTime}left'
                : isCompleted
                    ? '  $duration'
                    : savedEpisode.position != 0
                        ? '   ${savedEpisodeStatus}left'
                        : '  $duration',
        weight: FontWeight.w400,
        color: isPlaying ? AppColors.onPrimary : AppColors.textColor,
        size: 14.w);
  }

  _circularIndicator() {
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: savedEpisode.timeLeftInPercentage,
      stepSize: 1,
      selectedColor: AppColors.secondaryColor,
      unselectedColor: AppColors.disabledColor,
      padding: 0,
      width: 20.dw,
      height: 20.dw,
      selectedStepSize: 2,
      unselectedStepSize: 1,
      roundedCap: (_, __) => true,
    );
  }

  _iconButton(IconData icon, {EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return IconButton(
        onPressed: () {},
        alignment: Alignment.centerRight,
        padding: padding,
        constraints: const BoxConstraints(),
        icon: Icon(
          icon,
          color: AppColors.secondaryColor,
          size: 20.dw,
        ));
  }
}
