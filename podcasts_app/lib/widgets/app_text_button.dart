import '../source.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {required this.callback, required this.text, required this.radius, key})
      : super(key: key);

  final VoidCallback callback;
  final String text;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.dh,
      margin: EdgeInsets.only(top: 10.dh, bottom: 10.dh, right: 15.dw),
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 15.dw),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
          child: AppText(text,
              size: 14.w, color: Colors.black87, weight: FontWeight.w700)),
    );
  }
}
