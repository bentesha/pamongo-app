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
      _buildSeriesDescription(),
      SeriesActionButtons(
        visitSeriesCallback: () =>
            SeriesPage.navigateTo(context, widget.series),
      )
    ]);
  }

  _buildSeriesDescription() {
    String description = widget.series.description;
    final length = description.length;
    if (length > 160) description = description.substring(0, 160) + ' ...';
    return AppText(description, size: 15, color: AppColors.onSecondary2);
  }
}
