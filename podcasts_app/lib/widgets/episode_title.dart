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
        AppImage(radius: 7, image: image, height: 36, width: 36),
        const SizedBox(width: 10),
        SizedBox(
          height: 45,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(seriesName,
                    weight: FontWeight.w400,
                    size: 13,
                    color: AppColors.onSecondary2),
                AppText(
                  formatted,
                  weight: FontWeight.w400,
                  color: AppColors.onSecondary2,
                  size: 13,
                )
              ]),
        )
      ]),
      const SizedBox(height: 5),
      AppText(title,
          weight: FontWeight.w600,
          size: 16,
          maxLines: 2,
          color: AppColors.onSecondary3),
      const SizedBox(height: 5),
    ]);
  }
}
