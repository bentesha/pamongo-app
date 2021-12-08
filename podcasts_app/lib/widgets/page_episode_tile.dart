import '../source.dart';
import 'episode_tile.dart';

enum Pages { homepage, episodePage, seriesPage, channelPage }

class PageEpisodeTile extends StatelessWidget {
  const PageEpisodeTile(
      {required this.playCallback,
      required this.resumeCallback,
      required this.markAsDoneCallback,
      required this.shareCallback,
      required this.supplements,
      required this.episode,
      required this.page,
      key})
      : super(key: key);

  final Episode episode;

  final Supplements supplements;
  final void Function(String) markAsDoneCallback, shareCallback;
  final VoidCallback resumeCallback, playCallback;
  final Pages page;

  @override
  Widget build(BuildContext context) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final isLoading = playerState.isLoading && activeId == episode.id;
    final isActive =
        (playerState.isPlaying || playerState.isPaused) &&
            activeId == episode.id;

    final isOnHomepage = page == Pages.homepage;

    final _child = EpisodeTile(
      page: page,
      episode: episode,
      shareCallback: shareCallback,
      playerState: playerState,
      activeId: activeId,
      markAsDoneCallback: markAsDoneCallback,
      playCallback: isActive
          ? resumeCallback
          : isLoading
              ? () {}
              : playCallback,
    );

    return Column(
      children: [
        isOnHomepage
            ? Container(height: 1, color: AppColors.dividerColor)
            : Container(),
        isOnHomepage
            ? AppMaterialButton(
                onPressed: () => EpisodePage.navigateTo(context, episode),
                child: _child,
              )
            : _child,
      ],
    );
  }
}
