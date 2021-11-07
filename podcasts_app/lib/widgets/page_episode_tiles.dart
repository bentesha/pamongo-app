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
            padding: const EdgeInsets.only(left: 18, right: 20),
            child: GestureDetector(
                onTap: () => EpisodePage.navigateTo(context, widget.episode),
                child: EpisodeTile(
                  page: Pages.homepage,
                  episode: widget.episode,
                  status: status,
                  descriptionMaxLines: 3,
                  actionPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
        padding: const EdgeInsets.fromLTRB(18, 0, 15, 20),
        child: EpisodeTile(
            page: Pages.episodePage,
            descriptionMaxLines: 10,
            useToggleExpansionButtons: true,
            status: status,
            episode: episode,
            duration: duration,
            playCallback: isActive
                ? widget.resumeCallback
                : isLoading
                    ? () {}
                    : widget.playCallback,
            actionPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10)));
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
      padding: const EdgeInsets.only(left: 18, right: 18),
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
              ? const SizedBox(height: 10)
              : const SizedBox(height: 1),
          AppText(date, size: 14, color: AppColors.textColor2),
          const SizedBox(height: 5),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              size: 16,
              color: AppColors.textColor,
              weight: FontWeight.w600,
              alignment: TextAlign.start,
              maxLines: 2),
          EpisodeActionButtons(
            Pages.seriesPage,
            status: status,
            duration: duration,
            actionPadding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
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
        margin: const EdgeInsets.only(left: 18, right: 24, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: const Color(0xFF626263),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(bottom: 2),
              child: const AppText('INTRO',
                  size: 12,
                  weight: FontWeight.w600,
                  color: AppColors.onPrimary)),
          AppText('Introducing ${widget.seriesName}',
              weight: FontWeight.w600,
              size: 15,
              maxLines: 2,
              color: AppColors.onPrimary),
          EpisodeActionButtons(Pages.seriesPage,
              statusColor: AppColors.onPrimary,
              iconsColor: AppColors.onPrimary,
              status: status,
              duration: duration,
              playCallback: isActive
                  ? widget.resumeCallback
                  : isLoading
                      ? () {}
                      : () => widget.playCallback(index),
              actionPadding: const EdgeInsets.only(top: 8))
        ]));
  }
}
