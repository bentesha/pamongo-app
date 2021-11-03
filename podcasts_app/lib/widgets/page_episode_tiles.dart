import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/pages/episode_page.dart';
import '../source.dart';

class EpisodeTiles {
  static Widget homepage(
      {required void Function(Episode) playCallback,
      required Supplements supplements,
      required Episode episode}) {
    return HomepageEpisodeTile(episode, supplements, playCallback);
  }

  static Widget episodePage(
      {required VoidCallback playCallback,
      required Supplements supplements,
      required Episode episode}) {
    return EpisodePageEpisodeTile(episode, supplements, playCallback);
  }

  static Widget seriesPage(
      {required void Function(int) playCallback,
      required Supplements supplements,
      required int index,
      required Episode episode}) {
    return SeriesPageEpisodeTile(index, episode, supplements, playCallback);
  }

  static Widget introEpisode({
    required void Function(int) playCallback,
    required Supplements supplements,
    required String seriesName,
    required List episodeList,
  }) {
    return SeriesPageIntroEpisode(
        seriesName, episodeList, supplements, playCallback);
  }
}

class HomepageEpisodeTile extends StatefulWidget {
  const HomepageEpisodeTile(this.episode, this.supplements, this.playCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final void Function(Episode) playCallback;

  @override
  State<HomepageEpisodeTile> createState() => _HomepageEpisodeTileState();
}

class _HomepageEpisodeTileState extends State<HomepageEpisodeTile> {
  String status = '', duration = '';
  bool isInactive = false;
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final activeId = widget.supplements.activeId;
    final playerState = widget.supplements.playerState;

    final isLoading = playerState == loadingState;
    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;

    isInactive =
        (isLoading || isPlaying || isPaused) && activeId == widget.episode.id;

    status = Utils.getStatus(episode.id, activeId, playerState);
    duration = Utils.convertFrom(episode.duration, includeSeconds: false);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Column(
      children: [
        Container(height: 1, color: AppColors.separator),
        Padding(
            padding: EdgeInsets.only(left: 18.dw, right: 20.dw),
            child: GestureDetector(
                onTap: () => EpisodePage.navigateTo(context, widget.episode),
                child: EpisodeTile(
                  page: Pages.homepage,
                  episode: widget.episode,
                  status: status,
                  descriptionMaxLines: 3,
                  actionPadding: EdgeInsets.fromLTRB(0, 8.dh, 0, 8.dh),
                  playCallback:
                      isInactive ? () {} : () => widget.playCallback(episode),
                  duration: duration,
                ))),
      ],
    );
  }
}

class EpisodePageEpisodeTile extends StatefulWidget {
  const EpisodePageEpisodeTile(
      this.episode, this.supplements, this.playCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final VoidCallback playCallback;

  @override
  State<EpisodePageEpisodeTile> createState() => _EpisodePageEpisodeTileState();
}

class _EpisodePageEpisodeTileState extends State<EpisodePageEpisodeTile> {
  String status = '', duration = '';
  bool isInactive = false;
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final activeId = widget.supplements.activeId;
    final playerState = widget.supplements.playerState;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    final isLoading = playerState == loadingState;
    isInactive = (isPlaying || isLoading || isPaused) && activeId == episode.id;

    status = Utils.getStatus(episode.id, activeId, playerState);
    duration = Utils.convertFrom(episode.duration, includeSeconds: false);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Padding(
        padding: EdgeInsets.fromLTRB(18.dw, 0, 15.dw, 20.dh),
        child: EpisodeTile(
            page: Pages.episodePage,
            descriptionMaxLines: 10,
            useToggleExpansionButtons: true,
            status: status,
            episode: episode,
            duration: duration,
            playCallback: isInactive ? () {} : widget.playCallback,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 10.dw, 10.dh)));
  }
}

class SeriesPageEpisodeTile extends StatefulWidget {
  const SeriesPageEpisodeTile(
      this.index, this.episode, this.supplements, this.playCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final int index;
  final Supplements supplements;
  final void Function(int) playCallback;

  @override
  State<SeriesPageEpisodeTile> createState() => _SeriesPageEpisodeTileState();
}

class _SeriesPageEpisodeTileState extends State<SeriesPageEpisodeTile> {
  bool shouldPaintTopBorder = false, isInactive = false;
  String status = '', duration = '', date = '';
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final index = widget.index;
    final supplements = widget.supplements;
    final playerState = widget.supplements.playerState;
    final activeId = widget.supplements.activeId;
    final isOldestFirstSorted = supplements.sortStyle == SortStyles.oldestFirst;

    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isPaused = playerState == pausedState;

    isInactive = (isPlaying || isLoading || isPaused) && activeId == episode.id;

    status = Utils.getStatus(episode.id, activeId, playerState);
    duration = Utils.convertFrom(episode.duration, includeSeconds: false);
    date = Utils.formatDateBy(episode.date, 'yMMMd');

    shouldPaintTopBorder = isOldestFirstSorted ? index != 1 : index != 0;
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Container(
      padding: EdgeInsets.only(left: 18.dw, right: 18.dw),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: shouldPaintTopBorder ? 1 : 0,
                  color: shouldPaintTopBorder
                      ? AppColors.separator
                      : Colors.transparent))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shouldPaintTopBorder
              ? SizedBox(height: 10.dh)
              : SizedBox(height: 1.dh),
          AppText(date, size: 14.w, color: AppColors.onSecondary2),
          SizedBox(height: 5.dh),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              weight: FontWeight.w600,
              size: 16.w,
              color: Colors.black87,
              alignment: TextAlign.start,
              maxLines: 2),
          EpisodeActionButtons(
            Pages.seriesPage,
            status: status,
            duration: duration,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 0, 8.dh),
            playCallback:
                isInactive ? () {} : () => widget.playCallback(widget.index),
          )
        ],
      ),
    );
  }
}

class SeriesPageIntroEpisode extends StatefulWidget {
  const SeriesPageIntroEpisode(
      this.seriesName, this.episodeList, this.supplements, this.playCallback,
      {key})
      : super(key: key);

  final String seriesName;
  final void Function(int) playCallback;
  final List episodeList;
  final Supplements supplements;

  @override
  State<SeriesPageIntroEpisode> createState() => _SeriesPageIntroEpisodeState();
}

class _SeriesPageIntroEpisodeState extends State<SeriesPageIntroEpisode> {
  String duration = '', status = '';
  int index = 0;

  void _buildState() {
    final playerState = widget.supplements.playerState;
    final activeId = widget.supplements.activeId;
    final sortStyle = widget.supplements.sortStyle;
    final isLatestFirstSorted = sortStyle == SortStyles.latestFirst;
    index = isLatestFirstSorted ? widget.episodeList.length - 1 : 0;

    final introEpisode = widget.episodeList[index];
    status = Utils.getStatus(introEpisode.id, activeId, playerState);
    duration = Utils.convertFrom(introEpisode.duration);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Container(
        margin: EdgeInsets.only(left: 18.dw, right: 24.dw, bottom: 10.dh),
        padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 8.dh),
        color: const Color(0xffEEEDE7),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.all(2.dw),
              margin: EdgeInsets.only(bottom: 3.dh),
              color: AppColors.onSecondary2,
              child: AppText('INTRO',
                  size: 12.w,
                  weight: FontWeight.w600,
                  color: AppColors.onPrimary2)),
          AppText('Introducing ${widget.seriesName}', size: 15.w, maxLines: 2),
          EpisodeActionButtons(Pages.seriesPage,
              status: status,
              duration: duration,
              playCallback: () => widget.playCallback(index),
              actionPadding: EdgeInsets.only(top: 5.dh))
        ]));
  }
}
