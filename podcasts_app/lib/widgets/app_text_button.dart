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
      height: 30,
      margin: const EdgeInsets.only(top: 10, bottom: 10, right: 15),
      child: TextButton(
          onPressed: callback,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(radius))),
          ),
          child: AppText(text,
              size: 14, color: Colors.black87, weight: FontWeight.w700)),
    );
  }
}
