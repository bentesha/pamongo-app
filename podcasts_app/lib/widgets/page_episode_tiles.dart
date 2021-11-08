import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/pages/episode_page.dart';
import '../source.dart';

class EpisodeTiles {
  static Widget homepage(
      {required void Function(Episode) playCallback,
      required VoidCallback resumeCallback,
      required Supplements supplements,
      required Episode episode}) {
    return HomepageEpisodeTile(
        episode, supplements, playCallback, resumeCallback);
  }

  static Widget episodePage(
      {required VoidCallback playCallback,
      required Supplements supplements,
      required VoidCallback resumeCallback,
      required Episode episode}) {
    return EpisodePageEpisodeTile(
        episode, supplements, playCallback, resumeCallback);
  }

  static Widget seriesPage(
      {required void Function(int) playCallback,
      required Supplements supplements,
      required int index,
      required VoidCallback resumeCallback,
      required Episode episode}) {
    return SeriesPageEpisodeTile(
        index, episode, supplements, playCallback, resumeCallback);
  }

  static Widget introEpisode({
    required void Function(int) playCallback,
    required Supplements supplements,
    required String seriesName,
    required VoidCallback resumeCallback,
    required List episodeList,
  }) {
    return SeriesPageIntroEpisode(
        seriesName, episodeList, supplements, playCallback, resumeCallback);
  }
}

class HomepageEpisodeTile extends StatefulWidget {
  const HomepageEpisodeTile(
      this.episode, this.supplements, this.playCallback, this.resumeCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final void Function(Episode) playCallback;
  final VoidCallback resumeCallback;

  @override
  State<HomepageEpisodeTile> createState() => _HomepageEpisodeTileState();
}

class _HomepageEpisodeTileState extends State<HomepageEpisodeTile> {
  String status = '', duration = '';
  bool isLoading = false, isActive = false;
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final activeId = widget.supplements.activeId;
    final playerState = widget.supplements.playerState;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;

    isLoading = playerState == loadingState && activeId == episode.id;

    isActive = (isPlaying || isPaused) && activeId == episode.id;

    status = Utils.getStatus(episode.id, activeId, playerState);
    duration = Utils.convertFrom(episode.duration, includeSeconds: false);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Column(
      children: [
        Container(height: 1, color: AppColors.dividerColor),
        Padding(
            padding: EdgeInsets.only(left: 18.dw, right: 20.dw),
            child: GestureDetector(
                onTap: () => EpisodePage.navigateTo(context, widget.episode),
                child: EpisodeTile(
                  page: Pages.homepage,
                  episode: widget.episode,
                  status: status,
                  remainingTime: widget.supplements.activeEpisodeRemainingTime,
                  remainingFraction:
                      widget.supplements.activeEpisodeRemainingFraction,
                  descriptionMaxLines: 3,
                  actionPadding: EdgeInsets.fromLTRB(0, 8.dh, 0, 8.dh),
                  playCallback: isActive
                      ? widget.resumeCallback
                      : isLoading
                          ? () {}
                          : () => widget.playCallback(episode),
                  duration: duration,
                ))),
      ],
    );
  }
}

class EpisodePageEpisodeTile extends StatefulWidget {
  const EpisodePageEpisodeTile(
      this.episode, this.supplements, this.playCallback, this.resumeCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final VoidCallback playCallback, resumeCallback;

  @override
  State<EpisodePageEpisodeTile> createState() => _EpisodePageEpisodeTileState();
}

class _EpisodePageEpisodeTileState extends State<EpisodePageEpisodeTile> {
  String status = '', duration = '';
  bool isLoading = false, isActive = false;
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final activeId = widget.supplements.activeId;
    final playerState = widget.supplements.playerState;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    isLoading = playerState == loadingState && activeId == episode.id;
    isActive = (isPlaying || isPaused) && activeId == episode.id;

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
            remainingTime: widget.supplements.activeEpisodeRemainingTime,
            remainingFraction:
                widget.supplements.activeEpisodeRemainingFraction,
            playCallback: isActive
                ? widget.resumeCallback
                : isLoading
                    ? () {}
                    : widget.playCallback,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 10.dw, 10.dh)));
  }
}

class SeriesPageEpisodeTile extends StatefulWidget {
  const SeriesPageEpisodeTile(this.index, this.episode, this.supplements,
      this.playCallback, this.resumeCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final int index;
  final Supplements supplements;
  final void Function(int) playCallback;
  final VoidCallback resumeCallback;

  @override
  State<SeriesPageEpisodeTile> createState() => _SeriesPageEpisodeTileState();
}

class _SeriesPageEpisodeTileState extends State<SeriesPageEpisodeTile> {
  bool shouldPaintTopBorder = false, isLoading = false, isActive = false;
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
    final isPaused = playerState == pausedState;
    isLoading = playerState == loadingState && activeId == episode.id;
    isActive = (isPlaying || isPaused) && activeId == episode.id;

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
                      ? AppColors.dividerColor
                      : Colors.transparent))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shouldPaintTopBorder
              ? SizedBox(height: 10.dh)
              : SizedBox(height: 1.dh),
          AppText(date, size: 14.w, color: AppColors.textColor2),
          SizedBox(height: 5.dh),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              size: 16.w,
              color: AppColors.textColor,
              weight: FontWeight.w600,
              alignment: TextAlign.start,
              maxLines: 2),
          EpisodeActionButtons(
            Pages.seriesPage,
            status: status,
            duration: duration,
            remainingTime: widget.supplements.activeEpisodeRemainingTime,
            remainingFraction:
                widget.supplements.activeEpisodeRemainingFraction,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 0, 8.dh),
            playCallback: isActive
                ? widget.resumeCallback
                : isLoading
                    ? () {}
                    : () => widget.playCallback(widget.index),
          )
        ],
      ),
    );
  }
}

class SeriesPageIntroEpisode extends StatefulWidget {
  const SeriesPageIntroEpisode(this.seriesName, this.episodeList,
      this.supplements, this.playCallback, this.resumeCallback,
      {key})
      : super(key: key);

  final String seriesName;
  final void Function(int) playCallback;
  final VoidCallback resumeCallback;
  final List episodeList;
  final Supplements supplements;

  @override
  State<SeriesPageIntroEpisode> createState() => _SeriesPageIntroEpisodeState();
}

class _SeriesPageIntroEpisodeState extends State<SeriesPageIntroEpisode> {
  String duration = '', status = '';
  int index = 0;
  bool isLoading = false, isActive = false;

  void _buildState() {
    final playerState = widget.supplements.playerState;
    final activeId = widget.supplements.activeId;
    final sortStyle = widget.supplements.sortStyle;
    final isLatestFirstSorted = sortStyle == SortStyles.latestFirst;
    index = isLatestFirstSorted ? widget.episodeList.length - 1 : 0;

    final introEpisode = widget.episodeList[index];
    status = Utils.getStatus(introEpisode.id, activeId, playerState);
    duration = Utils.convertFrom(introEpisode.duration);

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    isLoading = playerState == loadingState && activeId == introEpisode.id;
    isActive = (isPlaying || isPaused) && activeId == introEpisode.id;
  }

  @override
  Widget build(BuildContext context) {
    _buildState();
    return Container(
        margin: EdgeInsets.only(left: 18.dw, right: 24.dw, bottom: 10.dh),
        padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 8.dh),
        color: const Color(0xFFF2F1EF),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.all(2.dw),
              margin: EdgeInsets.only(bottom: 2.dh),
              child: AppText(
                'INTRO',
                size: 12.w,
                weight: FontWeight.w600,
              )),
          AppText(
            'Introducing ${widget.seriesName}',
            weight: FontWeight.w600,
            size: 15.w,
            maxLines: 2,
          ),
          EpisodeActionButtons(Pages.seriesPage,
              status: status,
              duration: duration,
              remainingTime: widget.supplements.activeEpisodeRemainingTime,
              remainingFraction:
                  widget.supplements.activeEpisodeRemainingFraction,
              playCallback: isActive
                  ? widget.resumeCallback
                  : isLoading
                      ? () {}
                      : () => widget.playCallback(index),
              actionPadding: EdgeInsets.only(top: 8.dh))
        ]));
  }
}
