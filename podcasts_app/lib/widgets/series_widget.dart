import 'package:podcasts/models/series.dart';
import 'package:podcasts/pages/series_page.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/series_action_buttons.dart';

class SeriesWidget extends StatefulWidget {
  final Series series;
  const SeriesWidget(this.series, {key}) : super(key: key);

  @override
  State<SeriesWidget> createState() => _SeriesWidgetState();
}

class _SeriesWidgetState extends State<SeriesWidget> {
  late final int numberOfEpisodes;
  @override
  void initState() {
    super.initState();
    numberOfEpisodes = widget.series.episodeList.length - 1;
  }

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
              AppText(
                widget.series.name,
                size: 16.w,
                weight: FontWeight.w600,
              ),
              SizedBox(height: 3.dh),
              AppText(
                  numberOfEpisodes == 0
                      ? 'Introduction episode only'
                      : 'Episodes : $numberOfEpisodes',
                  size: 14.w)
            ],
          ),
        ],
      ),
      SizedBox(height: 10.dh),
      AppText(widget.series.description,
          size: 15.w, color: AppColors.textColor2, maxLines: 3),
      SeriesActionButtons(
        visitSeriesCallback: () =>
            SeriesPage.navigateTo(context, widget.series.id),
      )
    ]);
  }
}
