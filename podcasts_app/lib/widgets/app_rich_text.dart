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
          alignment:isLong ? Alignment.bottomRight : Alignment.bottomLeft,
          children: [
            AppText(
                isLong
                    ? isExpanded
                        ? richText
                        : richText.substring(0, 200) + ' ...'
                    : richText,
                family: FontFamily.workSans,
                size: 16,
                color: AppColors.onSecondary2),
            isLong
                ? isExpanded
                    ? Container()
                    : GestureDetector(
                        onTap: () =>
                            isExpandNotifier.value = !isExpandNotifier.value,
                        child: Container(
                          width: 70,
                          height: 20,
                          alignment: Alignment.center,
                          color: Colors.white,
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              AppText(
                                isExpanded ? 'Less' : 'More',
                                size: 16,
                                color: AppColors.secondary,
                                family: FontFamily.workSans,
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: AppColors.secondary)
                            ],
                          ),
                        ),
                      )
                : Container()
          ],
        );
      },
    );
  }
}
