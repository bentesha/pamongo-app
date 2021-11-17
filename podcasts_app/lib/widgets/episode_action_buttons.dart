import 'package:lottie/lottie.dart';
import 'package:podcasts/models/saved_episodes.dart';
import 'package:podcasts/source.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class EpisodeActionButtons extends StatelessWidget {
  const EpisodeActionButtons(this.page,
      {required this.playCallback,
      required this.markAsDoneCallback,
      required this.actionPadding,
      required this.status,
      required this.id,
      required this.duration,
      required this.remainingTime,
      key})
      : super(key: key);

  final Pages page;
  final EdgeInsetsGeometry actionPadding;
  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback;
  final String status;
  final String duration, id, remainingTime;

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
    final isSaved = Utils.getPlayedStatus(id) != null;
    if (!isSaved) return Container();
    return Expanded(
      child: Container(
        height: 20.dw,
        alignment: Alignment.centerRight,
        child: PopupMenuButton(
          padding: EdgeInsets.zero,
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
                    const Icon(Icons.done)
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
                        ? _circularIndicator(
                            savedEpisode.position, savedEpisode.duration)
                        : Icon(AppIcons.playCircled,
                            size: 20.dw, color: AppColors.accentColor);
  }

  _statusText() {
    final isOnHomepage = page == Pages.homepage;
    final isOnChannelPage = page == Pages.channelPage;
    final isPlaying = status == 'Playing';
    final isLoading = status == 'Loading';
    final isPaused = status == 'Paused';
    final isCompleted = status == 'Completed';

    final savedEpisode =
        Utils.getPlayedStatus(id) ?? SavedEpisode(position: 0, duration: 0);
    final savedEpisodeStatus = '  ' +
        Utils.convertFrom(savedEpisode.duration - savedEpisode.position,
            includeSeconds: false) +
        'left';

    return AppText(
        isOnHomepage
            ? isPaused
                ? '   ${remainingTime}left'
                : isCompleted
                    ? '  $duration'
                    : savedEpisode.position != 0
                        ? savedEpisodeStatus
                        : '  $duration'
            : isOnChannelPage
                ? isPlaying || isLoading
                    ? '  ' + status
                    : isPaused
                        ? '   ${remainingTime}left'
                        : isCompleted
                            ? '  $duration'
                            : savedEpisode.position != 0
                                ? savedEpisodeStatus
                                : '  $duration'
                : isPaused
                    ? '   ${remainingTime}left'
                    : isPlaying || isLoading
                        ? '  ' + status
                        : isCompleted
                            ? '  $duration'
                            : savedEpisode.position != 0
                                ? savedEpisodeStatus
                                : '  $duration',
        weight: FontWeight.w400,
        color: isPlaying ? AppColors.onPrimary : AppColors.textColor,
        size: 14.w);
  }

  _circularIndicator(int position, int duration) {
    final currentStep = (position / duration * 100).toInt();
    return CircularStepProgressIndicator(
      totalSteps: 100,
      currentStep: currentStep,
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

  Widget _iconButton(IconData icon,
      {EdgeInsetsGeometry padding = EdgeInsets.zero}) {
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
