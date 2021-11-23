import '../source.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {required this.callback,
      required this.text,
      required this.radius,
      this.fontWeight = FontWeight.w700,
      this.textColor = AppColors.textColor,
      this.withIcon = false,
      this.icon = AppIcons.share,
      this.iconColor = AppColors.primaryColor,
      this.borderColor = AppColors.disabledColor,
      key})
      : super(key: key);

  final VoidCallback callback;
  final String text;
  final double radius;
  final FontWeight fontWeight;
  final Color textColor, iconColor, borderColor;
  final bool withIcon;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.dh,
      margin: EdgeInsets.only(top: 10.dh, bottom: 10.dh, right: 15.dw),
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            primary: AppColors.disabledColor,
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
          child: withIcon
              ? Row(children: [
                  Icon(icon, color: iconColor, size: 18.dw),
                  SizedBox(width: 15.dw),
                  AppText(text,
                      size: 15.w, weight: fontWeight, color: textColor)
                ])
              : AppText(text,
                  size: 15.w, weight: fontWeight, color: textColor)),
    );
  }
}
