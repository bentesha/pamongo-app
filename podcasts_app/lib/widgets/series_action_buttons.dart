import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text_button.dart';

class SeriesActionButtons extends StatelessWidget {
  const SeriesActionButtons(
      {required this.visitSeriesCallback, this.isOnSeriesPage = false, key})
      : super(key: key);

  final VoidCallback visitSeriesCallback;
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
            callback: () {},
            radius: 5.dw,
            text: 'Share',
            withIcon: true,
          )
        : _iconButton(AppIcons.share);
  }

  _buildVisitSeriesButton() {
    final radius = isOnSeriesPage ? 5.dw : 15.dw;
    return AppTextButton(
      callback: visitSeriesCallback,
      text: 'Visit Series',
      textColor: AppColors.textColor2,
      radius: radius,
      fontWeight: FontWeight.w400,
    );
  }

  _iconButton(IconData icon) {
    return IconButton(
      onPressed: () {},
      padding: EdgeInsets.only(right: 15.dw),
      constraints: const BoxConstraints(),
      icon: Icon(icon, color: AppColors.secondaryColor, size: 18.dw),
    );
  }
}
