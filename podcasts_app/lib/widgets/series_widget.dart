import 'package:podcasts/models/series.dart';
import 'package:podcasts/source.dart';

class SeriesWidget extends StatelessWidget {
  final Series series;
  const SeriesWidget(this.series, {key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: AppImage(image: series.image, height: 96.w, width: 96.w),
      ),
      SizedBox(height: 9.dh),
      AppText(series.name,
          family: FontFamily.workSans,
          alignment: TextAlign.start,
          size: 14.w,
          weight: 400),
      const SizedBox(height: 5),
      AppText(series.channel,
          size: 12.w,
          family: FontFamily.workSans,
          alignment: TextAlign.start,
          weight: 400,
          color: AppColors.onSecondary2)
    ]);
  }
}
