import 'package:podcasts/models/episode.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_rich_text.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile(
      {required this.actionPadding,
      required this.episode,
      required this.page,
      required this.playCallback,
      required this.status,
      required this.duration,
      required this.remainingTime,
      required this.descriptionMaxLines,
      this.useToggleExpansionButtons = false,
      key})
      : super(key: key);

  final Pages page;
  final EdgeInsetsGeometry actionPadding;
  final Episode episode;
  final VoidCallback playCallback;
  final String status, duration, remainingTime;
  final int descriptionMaxLines;
  final bool useToggleExpansionButtons;

  @override
  Widget build(BuildContext context) {
    final isHomepage = page == Pages.homepage;
    final bool isDescriptionFirst = isHomepage;
    final text = AppText(
      episode.description,
      size: 16,
      color: AppColors.textColor2,
      maxLines: descriptionMaxLines,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EpisodeTitle(
            title: episode.title,
            seriesName: episode.seriesName,
            date: episode.date,
            image: episode.image,
            seriesId: episode.seriesId,
            page: page),
        isDescriptionFirst ? Container() : _buildActions(playCallback),
        isHomepage
            ? text
            : AppRichText(
                text: text,
                useToggleExpansionButtons: useToggleExpansionButtons),
        isDescriptionFirst ? _buildActions(playCallback) : Container(),
      ],
    );
  }

  _buildActions(VoidCallback playCallback) {
    return EpisodeActionButtons(page,
        playCallback: playCallback,
        status: status,
        duration: duration,
        remainingTime: remainingTime,
        actionPadding: actionPadding);
  }
}
