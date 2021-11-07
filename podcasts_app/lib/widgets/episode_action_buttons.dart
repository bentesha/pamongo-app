import 'package:lottie/lottie.dart';
import 'package:podcasts/source.dart';

class EpisodeActionButtons extends StatelessWidget {
  const EpisodeActionButtons(this.page,
      {required this.playCallback,
      required this.actionPadding,
      required this.status,
      required this.duration,
      this.statusColor = AppColors.textColor,
      this.iconsColor = AppColors.primaryColor,
      key})
      : super(key: key);

  final Pages page;
  final EdgeInsetsGeometry actionPadding;
  final VoidCallback playCallback;
  final String status;
  final String duration;
  final Color statusColor, iconsColor;

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
        padding: EdgeInsets.symmetric(horizontal: 10.dw));
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
          height: 30.dh,
          padding: EdgeInsets.fromLTRB(10.dw, 0, 10.dw, 0),
          margin: EdgeInsets.fromLTRB(0, 0, 5.dw, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.dw)),
              color: isPaused || isPlaying
                  ? AppColors.primaryColor
                  : Colors.transparent,
              border: isPaused || isPlaying
                  ? Border.all(width: 1.5, color: AppColors.primaryColor)
                  : Border.all(width: 1, color: Colors.grey)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            isPlaying
                ? Lottie.asset('assets/icons/playing.json',
                    fit: BoxFit.contain, height: 30.dh)
                : isLoading
                    ? Lottie.asset('assets/icons/loading.json',
                        fit: BoxFit.contain, height: 10.dh)
                    : isPaused
                        ? Icon(AppIcons.play,
                            color: AppColors.onPrimary2, size: 20.dw)
                        : Icon(AppIcons.playCircled,
                            size: 20.dw, color: AppColors.accentColor),
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
                color:
                    isPaused || isPlaying ? AppColors.onPrimary : statusColor,
                size: 14.w),
          ])),
    );
  }

  _iconButton(IconData icon, {EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return IconButton(
        onPressed: () {},
        padding: padding,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: iconsColor, size: 22.dw));
  }
}
