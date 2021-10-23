import 'package:lottie/lottie.dart';
import 'package:podcasts/source.dart';

class EpisodeActionButtons extends StatelessWidget {
  const EpisodeActionButtons(this.page,
      {required this.playCallback,
      required this.actionPadding,
      required this.status,
      required this.duration,
      key})
      : super(key: key);

  final Pages page;
  final EdgeInsetsGeometry actionPadding;
  final VoidCallback playCallback;
  final String status;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final isOnHomepage = page == Pages.homepage;
    final isOnChannelPage = page == Pages.channelPage;
    final isPlaying = status == 'Playing';
    final isLoading = status == 'Loading';
    final isPaused = status == 'Paused';

    return Padding(
      padding: actionPadding,
      child: Row(children: [
        GestureDetector(
          onTap: playCallback,
          child: Container(
              height: 32,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: isPaused || isPlaying
                      ? AppColors.primary
                      : Colors.transparent,
                  border: isPaused || isPlaying
                      ? Border.all(width: 1.5, color: AppColors.primary)
                      : Border.all(width: 1, color: Colors.grey)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    isPlaying
                        ? Lottie.asset('assets/icons/playing.json',
                            fit: BoxFit.contain, height: 30)
                        : isLoading
                            ? Lottie.asset('assets/icons/loading.json',
                                fit: BoxFit.contain, height: 10)
                            : isPaused
                                ? const Icon(AppIcons.play,
                                    color: AppColors.onPrimary2, size: 18)
                                : const Icon(AppIcons.playCircled,
                                    color: AppColors.secondary),
                    AppText(
                        isOnHomepage
                            ? '  ' + status
                            : isOnChannelPage
                                ? isPlaying || isLoading
                                    ? '  ' + status
                                    : isPaused
                                        ? '  Paused'
                                        : '  $duration'
                                : isPlaying || isLoading || isPaused
                                    ? '  ' + status
                                    : '  $duration',
                        weight: 400,
                        family: FontFamily.workSans,
                        color: isPaused || isPlaying
                            ? AppColors.onPrimary
                            : AppColors.onSecondary,
                        size: 14),
                  ])),
        ),
        IconButton(
            onPressed: () {},
            icon:
                const Icon(AppIcons.addToPlayList, color: AppColors.secondary)),
        IconButton(
            onPressed: () {},
            icon: const Icon(AppIcons.download, color: AppColors.secondary))
      ]),
    );
  }
}
