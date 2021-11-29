import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text_button.dart';

class SeriesActionButtons extends StatelessWidget {
  const SeriesActionButtons(
      {required this.visitSeriesCallback,
      required this.shareCallback,
      this.isOnSeriesPage = false,
      key})
      : super(key: key);

  final VoidCallback visitSeriesCallback, shareCallback;
  final bool isOnSeriesPage;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      !isOnSeriesPage ? _buildVisitSeriesButton() : Container(),
      _buildShareButton()
    ]);
  }

  _buildShareButton() {
    return isOnSeriesPage
        ? AppTextButton(
            callback: shareCallback,
            radius: 5,
            text: 'Share',
            withIcon: true,
          )
        : _iconButton(AppIcons.share, shareCallback);
  }

  _buildVisitSeriesButton() {
    final radius = isOnSeriesPage ? 5 : 15;
    return AppTextButton(
      callback: visitSeriesCallback,
      text: 'Visit Series',
      textColor: AppColors.textColor,
      radius: radius.toDouble(),

      fontWeight: FontWeight.w400,
    );
  }

  _iconButton(IconData icon, VoidCallback callback) {
    return IconButton(
      onPressed: callback,
      padding: const EdgeInsets.only(right: 15),
      constraints: const BoxConstraints(),
      icon: Icon(icon, color: AppColors.primaryColor, size: 18),

    );
  }
}
