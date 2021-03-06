import 'package:podcasts/models/series.dart';
import 'package:podcasts/pages/series_page.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/series_action_buttons.dart';

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
              image: widget.series.image, width: 50, height: 50, radius: 10),
          const SizedBox(width: 10),
          SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppText(
                  widget.series.name,
                  size: 14,
                  weight: FontWeight.w600,
                  maxLines: 2,
                ),
                AppText('Episodes : ${widget.series.totalNumberOfEpisodes}',
                    size: 14)
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      AppText(widget.series.description,
          size: 15, color: AppColors.textColor2, maxLines: 3),
      SeriesActionButtons(
        shareCallback: widget.shareCallback,
        visitSeriesCallback: () =>
            SeriesPage.navigateTo(context, widget.series.id),
      )
    ]);
  }
}
