import '../source.dart';

enum FontFamily { workSans, casual, redhat, louis }

class AppText extends StatefulWidget {
  const AppText(this.data,
      {this.weight = 400,
      this.size = 16,
      this.family = FontFamily.redhat,
      this.color = AppColors.onSecondary,
      this.alignment = TextAlign.justify,
      key})
      : super(key: key);

  final int size, weight;
  final String data;
  final FontFamily family;
  final Color color;
  final TextAlign alignment;

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  late final FontWeight fontWeight;
  String fontFamily = 'Redhat';

  @override
  void initState() {
    final weight = widget.weight;
    final family = widget.family;
    if (family == FontFamily.workSans) fontFamily = 'WorkSans';
    if (family == FontFamily.casual) fontFamily = 'Casual';
    if (family == FontFamily.louis) fontFamily = 'Louis';

    switch (weight) {
      case 300:
        fontWeight = FontWeight.w300;
        break;
      case 400:
        fontWeight = FontWeight.w400;
        break;
      case 600:
        fontWeight = FontWeight.w600;
        break;
      case 700:
        fontWeight = FontWeight.w700;
        break;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.data,
        textAlign: widget.alignment,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: widget.size.dw,
          color: widget.color,
          fontFamily: fontFamily,
          //overflow: TextOverflow.ellipsis
        ));
  }
}
