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
        return Stack(
          alignment: isLong ? Alignment.bottomRight : Alignment.bottomLeft,
          children: [
            AppText(
                isLong
                    ? isExpanded
                        ? richText
                        : richText.substring(0, 200) + ' ...'
                    : richText,
                size: 16,
                color: AppColors.onSecondary2),
            isLong
                ? isExpanded
                    ? Container()
                    : GestureDetector(
                        onTap: () =>
                            isExpandNotifier.value = !isExpandNotifier.value,
                        child: Container(
                          width: 80,
                          height: 20,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(top: 10),
                          child: const AppText('see more',
                              size: 14,
                              color: AppColors.secondary,
                              family: FontFamily.casual,
                              weight: 600),
                        ),
                      )
                : Container()
          ],
        );
      },
    );
  }
}
