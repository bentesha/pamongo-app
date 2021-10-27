import 'package:podcasts/source.dart';

class AppRichText extends StatelessWidget {
  final String richText;
  AppRichText(this.richText, {key}) : super(key: key);

  final isExpandNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    final isLong = richText.length > 200;
    return ValueListenableBuilder<bool>(
      valueListenable: isExpandNotifier,
      builder: (context, isExpanded, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AppText(
                isLong
                    ? isExpanded
                        ? richText
                        : richText.substring(0, 200) + ' ...'
                    : richText,
                size: 16.w,
                color: AppColors.onSecondary2),
            isLong
                ? GestureDetector(
                    onTap: () =>
                        isExpandNotifier.value = !isExpandNotifier.value,
                    child: AppText(isExpanded ? 'see less' : 'see more',
                        size: 14.w,
                        color: AppColors.secondary,
                        family: FontFamily.casual,
                        weight: 600),
                  )
                : Container()
          ],
        );
      },
    );
  }
}
