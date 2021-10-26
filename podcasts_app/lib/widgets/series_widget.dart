import 'package:podcasts/models/series.dart';
import 'package:podcasts/pages/series_page.dart';
import 'package:podcasts/source.dart';

class SeriesWidget extends StatefulWidget {
  final Series series;
  const SeriesWidget(this.series, {key}) : super(key: key);

  @override
  State<SeriesWidget> createState() => _SeriesWidgetState();
}

class _SeriesWidgetState extends State<SeriesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          AppImage(
              image: widget.series.image, width: 50, height: 50, radius: 10),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(widget.series.name,
                  size: 16, family: FontFamily.louis, weight: 600),
              const SizedBox(height: 3),
              const AppText('Episodes : 24',
                  size: 16,
                  family: FontFamily.louis,
                  weight: 400,
                  color: AppColors.onSecondary)
            ],
          ),
        ],
      ),
      const SizedBox(height: 10),
      AppText(widget.series.description,
          size: 15, color: AppColors.onSecondary2),
      _buildVisitSeriesButton(widget.series)
    ]);
  }

  _buildVisitSeriesButton(Series series) {
    return Container(
      height: 30,
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      child: TextButton(
          onPressed: () => SeriesPage.navigateTo(context, series),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            maximumSize: const Size.fromWidth(120),
            shape: const RoundedRectangleBorder(
                side: BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.podcasts, color: AppColors.secondary, size: 18),
              AppText('Visit Series', size: 15),
            ],
          )),
    );
  }
}
