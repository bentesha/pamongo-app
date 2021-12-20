import 'package:podcasts/source.dart';

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
            onPressed: shareCallback,
            borderRadius: 5.dw,
            text: 'Share',
            withIcon: true,
            isBolded: true,
            borderColor: AppColors.disabledColor,
            padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dh),
            margin: EdgeInsets.only(right: 15.dw),
          )
        : _iconButton(AppIcons.share, shareCallback);
  }

  _buildVisitSeriesButton() {
    final radius = isOnSeriesPage ? 5.dw : 15.dw;
    return AppTextButton(
      onPressed: visitSeriesCallback,
      text: 'Visit Series',
      textColor: AppColors.textColor,
      borderRadius: radius,
      isBolded: true,
      borderColor: AppColors.disabledColor,
      padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 5.dh),
      margin: EdgeInsets.only(right: 15.dw),
    );
  }

  _iconButton(IconData icon, VoidCallback callback) {
    return AppIconButton(
      onPressed: callback,
      margin: EdgeInsets.only(right: 15.dw),
      icon: icon,
      iconColor: AppColors.primaryColor,
      iconSize: 18.dw,
    );
  }
}
