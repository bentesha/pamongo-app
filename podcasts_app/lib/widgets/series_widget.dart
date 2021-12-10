import 'package:podcasts/source.dart';

class SeriesWidget extends StatefulWidget {
  final Series series;
  final VoidCallback shareCallback;
  const SeriesWidget(this.series, {required this.shareCallback, key})
      : super(key: key);

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
              imageUrl: widget.series.image,
              width: 50.dw,
              height: 50.dw,
              radius: 10),
          SizedBox(width: 10.dw),
          SizedBox(
            width: 300.dw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText(
                  widget.series.name,
                  size: 14.w,
                  weight: FontWeight.w600,
                  maxLines: 2,
                ),
                AppText('Episodes : ${widget.series.totalNumberOfEpisodes}',
                    size: 14.w)
              ],
            ),
          ),
        ],
      ),
      SizedBox(height: 10.dh),
      AppText(widget.series.description,
          size: 15.w, color: AppColors.textColor2, maxLines: 3),
      SeriesActionButtons(
        shareCallback: widget.shareCallback,
        visitSeriesCallback: () =>
            SeriesPage.navigateTo(context, widget.series.id),
      )
    ]);
  }
}
