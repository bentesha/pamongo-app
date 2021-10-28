import 'package:podcasts/source.dart';

class EpisodeTitle extends StatelessWidget {
  const EpisodeTitle(
      {required this.title,
      required this.seriesName,
      required this.date,
      required this.image,
      key})
      : super(key: key);

  final String title, date, image, seriesName;

  @override
  Widget build(BuildContext context) {
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
                    weight: 400, size: 13, color: AppColors.onSecondary2),
                AppText(
                  date,
                  weight: 400,
                  color: AppColors.onSecondary2,
                  size: 13,
                )
              ]),
        )
      ]),
      const SizedBox(height: 5),
      AppText(
        title,
        weight: 600,
        size: 16,
        family: FontFamily.louis,
      ),
      const SizedBox(height: 5),
    ]);
  }
}
