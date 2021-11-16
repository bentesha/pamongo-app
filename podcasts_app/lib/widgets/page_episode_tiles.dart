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
        GestureDetector(
          onTap: () => EpisodePage.navigateTo(context, widget.episode),
          child: Container(
            color: Colors.transparent,
            child: Padding(
                padding: EdgeInsets.only(left: 18.dw, right: 20.dw),
                child: EpisodeTile(
                  page: Pages.homepage,
                  episode: widget.episode,
                  status: status,
                  remainingTime: widget.supplements.activeEpisodeRemainingTime,
                  descriptionMaxLines: 3,
                  actionPadding: EdgeInsets.fromLTRB(0, 8.dh, 0, 8.dh),
                  playCallback: isActive
                      ? widget.resumeCallback
                      : isLoading
                          ? () {}
                          : () => widget.playCallback(episode),
                  duration: duration,
                )),
          ),
        ),
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
  bool isLoading = false, isActive = false;
  String status = '', duration = '', date = '';
  Episode episode = Episode(date: DateTime.now());

  void _buildState() {
    episode = widget.episode;
    final playerState = widget.supplements.playerState;
    final activeId = widget.supplements.activeId;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    isLoading = playerState == loadingState && activeId == episode.id;
    isActive = (isPlaying || isPaused) && activeId == episode.id;

    status = Utils.getStatus(episode.id, activeId, playerState);
    duration = Utils.convertFrom(episode.duration, includeSeconds: false);
    date = Utils.formatDateBy(episode.date, 'yMMMd');
  }

  @override
  Widget build(BuildContext context) {
    _buildState();

    return Padding(
      padding: EdgeInsets.only(left: 18.dw, right: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.dh, bottom: 5.dh),
            child: AppText(date, size: 14.w, color: AppColors.textColor2),
          ),
          AppText(
            'Ep. ${episode.episodeNumber} : ${episode.title}',
            size: 16.w,
            color: AppColors.textColor2,
            weight: FontWeight.w600,
            alignment: TextAlign.start,
            maxLines: 2,
          ),
          EpisodeActionButtons(
            Pages.seriesPage,
            status: status,
            duration: duration,
            remainingTime: widget.supplements.activeEpisodeRemainingTime,
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
