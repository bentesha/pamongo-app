import 'package:podcasts/source.dart';

class EpisodeTitle extends StatelessWidget {
  const EpisodeTitle(
      {required this.title,
      required this.seriesName,
      required this.date,
      required this.image,
      key})
      : super(key: key);

  final String title, image, seriesName;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formatted = Utils.formatDateBy(date, 'MMMd');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      Row(children: [
        AppImage(image: image, height: 36.w, width: 36.w, radius: 7.dw),
        const SizedBox(width: 10),
        SizedBox(
          height: 45.dh,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(seriesName,
                    weight: FontWeight.w400,
                    size: 13.w,
                    color: AppColors.onSecondary2),
                AppText(
                  formatted,
                  weight: FontWeight.w400,
                  color: AppColors.onSecondary2,
                  size: 13.w,
                )
              ]),
        )
      ]),
      SizedBox(height: 5.dh),
      AppText(title, weight: FontWeight.w600, size: 16.w, maxLines: 2),
      SizedBox(height: 5.dh),
    ]);
  }
}
