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
      height: 30,
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            primary: AppColors.disabledColor,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: borderColor, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
          child: withIcon
              ? Row(children: [
                  Icon(icon, color: iconColor, size: 18),
                  const SizedBox(width: 15),
                  AppText(text, size: 15, weight: fontWeight, color: textColor)
                ])
              : AppText(text, size: 15, weight: fontWeight, color: textColor)),
    );
  }
}
