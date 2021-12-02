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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        !isOnSeriesPage ? _buildVisitSeriesButton() : Container(),
        _buildShareButton()
      ]),
    );
  }

  _buildShareButton() {
    return isOnSeriesPage
        ? AppTextButton(
            onPressed: shareCallback,
            borderRadius: 5,
            text: 'Share',
            withIcon: true,
            isBolded: true,
            borderColor: AppColors.disabledColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: const EdgeInsets.only(right: 15),
          )
        : _iconButton(AppIcons.share, shareCallback);
  }

  _buildVisitSeriesButton() {
    final radius = isOnSeriesPage ? 5 : 15;
    return AppTextButton(
      onPressed: visitSeriesCallback,
      text: 'Visit Series',
      textColor: AppColors.textColor,
      borderRadius: radius.toDouble(),
      isBolded: true,
      borderColor: AppColors.disabledColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 15),
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
