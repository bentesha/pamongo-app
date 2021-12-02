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
    final isOnHomepage = widget.page == Pages.homepage;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 5.dh),
      Row(children: [
        AppImage(image: widget.image, height: 36.w, width: 36.w, radius: 7.dw),
        SizedBox(width: 10.dw),
        SizedBox(
          width: 315.dw,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: _handleOnTap,
                  child: AppText(widget.seriesName,
                      weight: FontWeight.w400,
                      alignment: TextAlign.start,
                      size: 13.w,
                      color: isOnHomepage
                          ? AppColors.textColor
                          : AppColors.focusColor),
                ),
                AppText(
                  formatted,
                  weight: FontWeight.w400,
                  size: 13.w,
                )
              ]),
        )
      ]),
      Padding(
        padding: EdgeInsets.only(top: 7.dh, bottom: 3.dh, right: 8.dw),
        child: AppText(widget.title,
            weight: FontWeight.w600,
            size: 15.w,
            maxLines: 2,
            color: AppColors.textColor),
      ),
    ]);
  }

  _handleOnTap() {
    final isOnEpisodePage = widget.page == Pages.episodePage;
    if (isOnEpisodePage) SeriesPage.navigateTo(context, widget.seriesId);
  }
}
