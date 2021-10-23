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
        AppImage(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            image: image,
            height: 36.w,
            width: 36.w),
        const SizedBox(width: 10),
        SizedBox(
          height: 45.dh,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(seriesName,
                    weight: 400,
                    size: 14.w,
                    family: FontFamily.louis,
                    color: AppColors.onSecondary2),
                AppText(
                  date,
                  weight: 400,
                  color: AppColors.onSecondary2,
                  family: FontFamily.louis,
                  size: 14.w,
                )
              ]),
        )
      ]),
      SizedBox(height: 10.dh),
      AppText(
        title,
        weight: 600,
        size: 16.w,
        family: FontFamily.louis,
      ),
      SizedBox(height: 5.dh),
    ]);
  }
}
