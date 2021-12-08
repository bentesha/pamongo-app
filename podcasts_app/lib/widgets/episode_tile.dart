import 'package:podcasts/source.dart';
import 'episode_title.dart';

class EpisodeTile extends StatelessWidget {
  const EpisodeTile(
      {required this.episode,
      required this.page,
      required this.playCallback,
      required this.markAsDoneCallback,
      required this.shareCallback,
      required this.activeId,
      required this.playerState,
      key})
      : super(key: key);

  final Pages page;
  final Episode episode;
  final VoidCallback playCallback;
  final void Function(String) markAsDoneCallback, shareCallback;
  final String activeId;
  final IndicatorPlayerState playerState;

  @override
  Widget build(BuildContext context) {
    final isOnHomepage = page == Pages.homepage;
    final bool isDescriptionFirst = isOnHomepage;

    final text = AppText(
      episode.description,
      size: 15.w,
      color: AppColors.textColor2,
      maxLines: isOnHomepage ? 3 : 10,
      alignment: TextAlign.start,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(
          18.dw, 0, isOnHomepage ? 20.dw : 15.dw, !isOnHomepage ? 20 : 0.dh),
      child: Column(
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
            child: isOnHomepage
                ? text
                : AppRichText(
                    text: text, useToggleExpansionButtons: !isOnHomepage),
          ),
          isDescriptionFirst
              ? _buildActions(playCallback, shareCallback)
              : Container(),
        ],
      ),
    );
  }

  _buildActions(
      VoidCallback playCallback, void Function(String) shareCallback) {
    return EpisodeActionButtons(
      playCallback: playCallback,
      markAsDoneCallback: markAsDoneCallback,
      shareCallback: shareCallback,
      episode: episode,
      playerState: playerState,
      activeId: activeId,
    );
  }
}
