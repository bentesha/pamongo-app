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
              image: widget.series.image,
              width: 50.w,
              height: 50.w,
              radius: 10),
          SizedBox(width: 10.dw),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(widget.series.name,
                  size: 16.w, family: FontFamily.louis, weight: 600),
              SizedBox(height: 3.dh),
              AppText('Episodes : 24',
                  size: 16.w,
                  family: FontFamily.louis,
                  weight: 400,
                  color: AppColors.onSecondary)
            ],
          ),
        ],
      ),
      SizedBox(height: 10.dh),
      AppText(widget.series.description,
          size: 15.w, color: AppColors.onSecondary2),
      _buildVisitSeriesButton(widget.series)
    ]);
  }

  _buildVisitSeriesButton(Series series) {
    return Container(
      height: 30.dh,
      margin: EdgeInsets.only(top: 10.dh, bottom: 5.dh),
      child: TextButton(
          onPressed: () => SeriesPage.navigateTo(context, series),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.dw),
            maximumSize: Size.fromWidth(120.dw),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.inactive, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(15.dw))),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(Icons.podcasts, color: AppColors.secondary, size: 18.dw),
              AppText('Visit Series', size: 15.w),
            ],
          )),
    );
  }
}
