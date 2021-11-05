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
    return Padding(
      padding: actionPadding,
      child: Row(children: [
        _buildStatusButton(),
        _buildPlaylistButton(),
        _buildDownloadButton()
      ]),
    );
  }

  _buildPlaylistButton() {
    return _iconButton(AppIcons.addToPlayList,
        padding: const EdgeInsets.symmetric(horizontal: 10));
  }

  _buildDownloadButton() {
    return _iconButton(AppIcons.download);
  }

  _buildStatusButton() {
    final isOnHomepage = page == Pages.homepage;
    final isOnChannelPage = page == Pages.channelPage;
    final isPlaying = status == 'Playing';
    final isLoading = status == 'Loading';
    final isPaused = status == 'Paused';

    return GestureDetector(
      onTap: playCallback,
      child: Container(
          height: 30,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: isPaused || isPlaying
                  ? AppColors.onSecondary3
                  : Colors.transparent,
              border: isPaused || isPlaying
                  ? Border.all(width: 1.5, color: AppColors.onSecondary3)
                  : Border.all(width: 1, color: Colors.grey)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            isPlaying
                ? Lottie.asset('assets/icons/playing.json',
                    fit: BoxFit.contain, height: 30)
                : isLoading
                    ? Lottie.asset('assets/icons/loading.json',
                        fit: BoxFit.contain, height: 10)
                    : isPaused
                        ? const Icon(AppIcons.play,
                            color: AppColors.onPrimary2, size: 20)
                        : const Icon(AppIcons.playCircled,
                            color: AppColors.secondary, size: 20),
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
                weight: FontWeight.w400,
                color: isPaused || isPlaying
                    ? AppColors.onPrimary
                    : AppColors.onSecondary,
                size: 14),
          ])),
    );
  }

  _iconButton(IconData icon, {EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return IconButton(
        onPressed: () {},
        padding: padding,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: AppColors.secondary, size: 22));
  }
}
