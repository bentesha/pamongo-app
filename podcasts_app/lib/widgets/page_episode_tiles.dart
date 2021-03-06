import '../source.dart';
import 'episode_tile.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class EpisodeTiles {
  static Widget homepage(
      {required void Function(Episode) playCallback,
      required VoidCallback resumeCallback,
      required void Function(String) markAsDoneCallback,
      required void Function(String) shareCallback,
      required Supplements supplements,
      required Episode episode}) {
    return HomepageEpisodeTile(
      episode,
      supplements,
      playCallback,
      resumeCallback,
      markAsDoneCallback,
      shareCallback,
    );
  }

  static Widget episodePage(
      {required VoidCallback playCallback,
      required Supplements supplements,
      required void Function(String) markAsDoneCallback,
      required void Function(String) shareCallback,
      required VoidCallback resumeCallback,
      required Episode episode}) {
    return EpisodePageEpisodeTile(
      episode,
      supplements,
      playCallback,
      resumeCallback,
      markAsDoneCallback,
      shareCallback,
    );
  }

  static Widget seriesPage(
      {required void Function(int) playCallback,
      required Supplements supplements,
      required int index,
      required void Function(String) markAsDoneCallback,
      required void Function(String) shareCallback,
      required VoidCallback resumeCallback,
      required Episode episode}) {
    return SeriesPageEpisodeTile(
      index,
      episode,
      supplements,
      playCallback,
      resumeCallback,
      markAsDoneCallback,
      shareCallback,
    );
  }
}

class HomepageEpisodeTile extends StatefulWidget {
  const HomepageEpisodeTile(this.episode, this.supplements, this.playCallback,
      this.resumeCallback, this.markAsDoneCallback, this.shareCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final void Function(Episode) playCallback;
  final void Function(String) markAsDoneCallback, shareCallback;
  final VoidCallback resumeCallback;

  @override
  State<HomepageEpisodeTile> createState() => _HomepageEpisodeTileState();
}

class _HomepageEpisodeTileState extends State<HomepageEpisodeTile> {
  String status = '', duration = '', savedEpisodeStatus = '';
  bool isLoading = false, isActive = false;
  Episode episode = Episode(date: DateTime.now());
  SavedEpisode savedEpisode = SavedEpisode.empty();

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
    savedEpisode = Utils.getPlayedStatus(episode.id) ?? SavedEpisode.empty();
    savedEpisodeStatus =
        Utils.convertFrom(savedEpisode.timeLeft, includeSeconds: false);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();

    return Column(
      children: [
        Container(height: 1, color: AppColors.dividerColor),
        AppMaterialButton(
          onPressed: () => EpisodePage.navigateTo(context, widget.episode),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 20),
            child: EpisodeTile(
              page: Pages.homepage,
              episode: widget.episode,
              status: status,
              shareCallback: widget.shareCallback,
              savedEpisodeStatus: savedEpisodeStatus,
              savedEpisode: savedEpisode,
              descriptionMaxLines: 3,
              markAsDoneCallback: widget.markAsDoneCallback,
              playCallback: isActive
                  ? widget.resumeCallback
                  : isLoading
                      ? () {}
                      : () => widget.playCallback(episode),
              duration: duration,
            ),
          ),
        ),
      ],
    );
  }
}

class EpisodePageEpisodeTile extends StatefulWidget {
  const EpisodePageEpisodeTile(
      this.episode,
      this.supplements,
      this.playCallback,
      this.resumeCallback,
      this.markAsDoneCallback,
      this.shareCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final Supplements supplements;
  final VoidCallback playCallback, resumeCallback;
  final void Function(String) markAsDoneCallback, shareCallback;

  @override
  State<EpisodePageEpisodeTile> createState() => _EpisodePageEpisodeTileState();
}

class _EpisodePageEpisodeTileState extends State<EpisodePageEpisodeTile> {
  String status = '', duration = '', savedEpisodeStatus = '';
  bool isLoading = false, isActive = false;
  Episode episode = Episode(date: DateTime.now());
  SavedEpisode savedEpisode = SavedEpisode.empty();

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
    savedEpisode = Utils.getPlayedStatus(episode.id) ?? SavedEpisode.empty();
    savedEpisodeStatus =
        Utils.convertFrom(savedEpisode.timeLeft, includeSeconds: false);
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
          savedEpisodeStatus: savedEpisodeStatus,
          savedEpisode: savedEpisode,
          shareCallback: widget.shareCallback,
          status: status,
          episode: episode,
          duration: duration,
          markAsDoneCallback: widget.markAsDoneCallback,
          playCallback: isActive
              ? widget.resumeCallback
              : isLoading
                  ? () {}
                  : widget.playCallback,
        ));
  }
}

class SeriesPageEpisodeTile extends StatefulWidget {
  const SeriesPageEpisodeTile(
      this.index,
      this.episode,
      this.supplements,
      this.playCallback,
      this.resumeCallback,
      this.markAsDoneCallback,
      this.shareCallback,
      {key})
      : super(key: key);

  final Episode episode;
  final int index;
  final Supplements supplements;
  final void Function(int) playCallback;
  final VoidCallback resumeCallback;
  final void Function(String) markAsDoneCallback, shareCallback;

  @override
  State<SeriesPageEpisodeTile> createState() => _SeriesPageEpisodeTileState();
}

class _SeriesPageEpisodeTileState extends State<SeriesPageEpisodeTile> {
  bool isLoading = false, isActive = false;
  String status = '', duration = '', date = '', savedEpisodeStatus = '';
  Episode episode = Episode(date: DateTime.now());
  SavedEpisode savedEpisode = SavedEpisode.empty();

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
    savedEpisode = Utils.getPlayedStatus(episode.id) ?? SavedEpisode.empty();
    savedEpisodeStatus =
        Utils.convertFrom(savedEpisode.timeLeft, includeSeconds: false);
  }

  @override
  Widget build(BuildContext context) {
    _buildState();

    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: AppText(date, size: 14, color: AppColors.textColor2),
          ),
          AppText(
            'Ep. ${episode.episodeNumber} : ${episode.title}',
            size: 15,
            color: AppColors.textColor2,
            weight: FontWeight.w600,
            alignment: TextAlign.start,
            maxLines: 2,
          ),
          EpisodeActionButtons(
            id: episode.id,
            status: status,
            savedEpisodeStatus: savedEpisodeStatus,
            savedEpisode: savedEpisode,
            shareCallback: widget.shareCallback,
            duration: duration,
            markAsDoneCallback: widget.markAsDoneCallback,
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
