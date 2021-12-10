import '../source.dart';

class SeriesPageEpisodeTile extends StatelessWidget {
  const SeriesPageEpisodeTile(
      {required this.playCallback,
      required this.supplements,
      required this.index,
      required this.markAsDoneCallback,
      required this.shareCallback,
      required this.resumeCallback,
      required this.episode,
      key})
      : super(key: key);

  final Episode episode;
  final int index;
  final Supplements supplements;
  final void Function(int) playCallback;
  final VoidCallback resumeCallback;
  final void Function(String) markAsDoneCallback, shareCallback;

  @override
  Widget build(BuildContext context) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final isLoading = playerState.isLoading && activeId == episode.id;
    final isActive = (playerState.isPlaying || playerState.isPaused) &&
        activeId == episode.id;

    return Padding(
      padding: EdgeInsets.only(left: 18.dw, right: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.dh, bottom: 5.dh),
            child: AppText(episode.getDate,
                size: 14.w, color: AppColors.textColor2),
          ),
          AppText(
            'Ep. ${episode.episodeNumber} : ${episode.title}',
            size: 15.w,
            color: AppColors.textColor2,
            weight: FontWeight.w600,
            alignment: TextAlign.start,
            maxLines: 2,
          ),
          EpisodeActionButtons(
            shareCallback: shareCallback,
            markAsDoneCallback: markAsDoneCallback,
            playerState: playerState,
            episode: episode,
            activeId: activeId,
            playCallback: isActive
                ? resumeCallback
                : isLoading
                    ? () {}
                    : () => playCallback(index),
          )
        ],
      ),
    );
  }
}
