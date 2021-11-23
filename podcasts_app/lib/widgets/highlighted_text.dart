import 'package:podcasts/source.dart';

class HighlightedText extends StatelessWidget {
  const HighlightedText(this.appText, {this.keyword = '', key})
      : super(key: key);

  final AppText appText;
  final String keyword;

  @override
  Widget build(BuildContext context) {
    final text = appText.data.toLowerCase();
    final index = text.indexOf(keyword);
    final before = appText.data.substring(0, index);
    final after = appText.data.substring(index + keyword.length, text.length);
    final highlighted = appText.data.substring(index, index + keyword.length);

    return RichText(
        maxLines: appText.maxLines,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(text: before, style: appText.style(), children: [
          TextSpan(
              text: highlighted,
              style: const TextStyle(color: AppColors.accentColor)),
          TextSpan(text: after)
        ]));
  }
}
