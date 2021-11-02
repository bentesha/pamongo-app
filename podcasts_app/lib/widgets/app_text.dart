import '../source.dart';

class AppText extends StatefulWidget {
  const AppText(this.data,
      {this.weight = FontWeight.w400,
      required this.size,
      this.family = 'Louis',
      this.color = AppColors.onSecondary,
      this.alignment = TextAlign.justify,
      this.maxLines,
      this.height,
      key})
      : super(key: key);

  final int size;
  final int? maxLines;
  final FontWeight weight;
  final String data;
  final String family;
  final Color color;
  final TextAlign alignment;
  final double? height;

  TextStyle _style() {
    return TextStyle(
        fontWeight: weight,
        fontSize: size.toDouble(),
        color: color,
        fontFamily: family,
        height: height,
        overflow: TextOverflow.ellipsis);
  }

  TextSpan toTextSpan() {
    return TextSpan(text: data, style: _style());
  }

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.data,
        textAlign: widget.alignment,
        maxLines: widget.maxLines,
        style: widget._style());
  }
}
