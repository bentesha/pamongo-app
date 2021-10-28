import 'package:podcasts/source.dart';

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
        ? _roundedButton('Follow', withIcon: true)
        : _iconButton(AppIcons.follow,
            padding: const EdgeInsets.symmetric(horizontal: 15));
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share,
        padding: isOnSeriesPage
            ? const EdgeInsets.fromLTRB(15, 5, 0, 0)
            : EdgeInsets.zero);
  }

  _buildVisitSeriesButton() {
    return _roundedButton('Visit Series');
  }

  _roundedButton(String text,
      {bool withIcon = false, IconData icon = AppIcons.follow}) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: TextButton(
          onPressed: visitSeriesCallback,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          child: Row(
            children: [
              withIcon
                  ? Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(icon, color: AppColors.secondary, size: 22))
                  : Container(),
              AppText(text, size: 14),
            ],
          )),
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
