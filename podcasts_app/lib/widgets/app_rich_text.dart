import '../source.dart';

class AppRichText extends StatelessWidget {
  final AppText text;
  final bool useToggleExpansionButtons;
  const AppRichText(
      {required this.text, required this.useToggleExpansionButtons, key})
      : super(key: key);

  static final isExpandNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final painter = TextPainter(
          text: text.toTextSpan(),
          maxLines: text.maxLines,
          textDirection: TextDirection.ltr);

      painter.layout(maxWidth: constraints.maxWidth);

      final isLong = painter.didExceedMaxLines;
      final isRestricted = text.maxLines != null;

      return isLong && isRestricted && useToggleExpansionButtons
          ? _buildExpandableAppRichText()
          : text;
    });
  }

  _buildExpandableAppRichText() {
    return ValueListenableBuilder<bool>(
      valueListenable: isExpandNotifier,
      builder: (context, isExpanded, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isExpanded
                ? RichText(text: text.toTextSpan(), textAlign: text.alignment)
                : text,
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => isExpandNotifier.value = !isExpandNotifier.value,
                  child: AppText(isExpanded ? 'see less' : 'see more',
                      size: 16,
                      color: AppColors.secondary,
                      weight: FontWeight.w600),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
