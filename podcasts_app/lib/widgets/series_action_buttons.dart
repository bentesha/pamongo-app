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
            padding: EdgeInsets.symmetric(horizontal: 15.dw));
  }

  _buildShareButton() {
    return _iconButton(AppIcons.share,
        padding: isOnSeriesPage
            ? EdgeInsets.fromLTRB(15.dw, 5.dh, 0, 0)
            : EdgeInsets.zero);
  }

  _buildVisitSeriesButton() {
    return _roundedButton('Visit Series');
  }

  _roundedButton(String text,
      {bool withIcon = false, IconData icon = AppIcons.follow}) {
    return Container(
      height: 30.dh,
      margin: EdgeInsets.only(top: 10.dh, bottom: 5.dh),
      child: TextButton(
          onPressed: visitSeriesCallback,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15.dw))),
          ),
          child: Row(
            children: [
              withIcon
                  ? Padding(
                      padding: EdgeInsets.only(right: 10.dw),
                      child:
                          Icon(icon, color: AppColors.secondary, size: 22.dw))
                  : Container(),
              AppText(text, size: 14.w),
            ],
          )),
    );
  }

  _iconButton(IconData icon, {EdgeInsetsGeometry padding = EdgeInsets.zero}) {
    return IconButton(
        onPressed: () {},
        padding: padding,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: AppColors.secondary, size: 22.dw));
  }
}
