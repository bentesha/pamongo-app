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
      _buildFollowButton(),
      _buildShareButton()
    ]);
  }

  _buildFollowButton() {
    return isOnSeriesPage
        ? AppTextButton(callback: () {}, text: 'Follow', radius: 5.dw)
        : _iconButton(AppIcons.follow);
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share);
  }

  _buildVisitSeriesButton() {
    final radius = isOnSeriesPage ? 5.dw : 15.dw;
    return AppTextButton(
        callback: visitSeriesCallback,
        text: 'Visit Series',
        radius: radius,
        fontWeight: FontWeight.w400);
  }

  _iconButton(IconData icon) {
    return IconButton(
        onPressed: () {},
        padding: EdgeInsets.only(right: 15.dw),
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: AppColors.secondary, size: 22.dw));
  }
}
