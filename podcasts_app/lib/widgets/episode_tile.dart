import 'package:podcasts/source.dart';
import 'episode_title.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile(
      {required this.episode,
      required this.page,
      required this.playCallback,
      required this.markAsDoneCallback,
      required this.savedEpisode,
      required this.savedEpisodeStatus,
      required this.shareCallback,
      required this.status,
      required this.duration,
      required this.descriptionMaxLines,
      this.useToggleExpansionButtons = false,
      key})
      : super(key: key);

  final Pages page;
  final Episode episode;
  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback, shareCallback;
  final String status, duration, savedEpisodeStatus;
  final int descriptionMaxLines;
  final bool useToggleExpansionButtons;
  final SavedEpisode savedEpisode;

  @override
  Widget build(BuildContext context) {
    final isHomepage = page == Pages.homepage;
    final bool isDescriptionFirst = isHomepage;
    final text = AppText(
      episode.description,
      size: 15.w,
      color: AppColors.textColor2,
      maxLines: descriptionMaxLines,
      alignment: TextAlign.start,
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
        isDescriptionFirst
            ? Container()
            : _buildActions(playCallback, shareCallback),
        Padding(
          padding: EdgeInsets.only(right: 8.dw),
          child: isHomepage
              ? text
              : AppRichText(
                  text: text,
                  useToggleExpansionButtons: useToggleExpansionButtons),
        ),
        isDescriptionFirst
            ? _buildActions(playCallback, shareCallback)
            : Container(),
      ],
    );
  }

  _buildActions(
      VoidCallback playCallback, void Function(String) shareCallback) {
    return EpisodeActionButtons(
      playCallback: playCallback,
      markAsDoneCallback: markAsDoneCallback,
      shareCallback: shareCallback,
      status: status,
      id: episode.id,
      duration: duration,
      savedEpisode: savedEpisode,
      savedEpisodeStatus: savedEpisodeStatus,
    );
  }
}
