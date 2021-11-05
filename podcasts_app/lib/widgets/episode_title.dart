import 'package:podcasts/pages/series_page.dart';
import 'package:podcasts/source.dart';

class EpisodeTitle extends StatefulWidget {
  const EpisodeTitle(
      {required this.title,
      required this.seriesName,
      required this.date,
      required this.image,
      required this.page,
      required this.seriesId,
      key})
      : super(key: key);

  final String title, image, seriesName, seriesId;
  final DateTime date;
  final Pages page;

  @override
  State<EpisodeTitle> createState() => _EpisodeTitleState();
}

class _EpisodeTitleState extends State<EpisodeTitle> {
  @override
  Widget build(BuildContext context) {
    final formatted = Utils.formatDateBy(widget.date, 'MMMd');

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 10),
      Row(children: [
        AppImage(image: widget.image, height: 36.w, width: 36.w, radius: 7.dw),
        const SizedBox(width: 10),
        SizedBox(
          height: 45.dh,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _handleOnTap,
                  child: AppText(widget.seriesName,
                      weight: FontWeight.w400,
                      size: 13.w,
                      color: widget.page == Pages.homepage
                          ? AppColors.onSecondary2
                          : AppColors.primary),
                ),
                AppText(
                  formatted,
                  weight: FontWeight.w400,
                  color: AppColors.onSecondary2,
                  size: 13.w,
                )
              ]),
        )
      ]),
      SizedBox(height: 5.dh),
      AppText(widget.title,
          weight: FontWeight.w600,
          size: 16.w,
          maxLines: 2,
          color: AppColors.onSecondary3),
      SizedBox(height: 5.dh),
    ]);
  }

  _handleOnTap() {
    SeriesPage.navigateTo(context, widget.seriesId);
  }
}
