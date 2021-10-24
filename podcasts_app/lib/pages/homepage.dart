import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/homepage_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/homepage_state.dart';
import 'package:podcasts/widgets/series_widget.dart';
import 'package:podcasts/widgets/audio_progress_widget.dart';
import '../source.dart';
import 'series_page.dart';
import 'episode_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late final HomepageBloc bloc;
  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = HomepageBloc(service);
    bloc.init();
    WidgetsBinding.instance!.addPostFrameCallback((_) => _showOverlay());
    super.initState();
  }

  _showOverlay() {
    final overlay = Overlay.of(context)!;
    final entry =
        OverlayEntry(builder: (context) => const AudioProgressWidget());
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppTopBars.homepage(context),
    );
  }

  _buildBody() {
    return BlocBuilder<HomepageBloc, HomepageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              failed: _buildError,
              content: _buildContent);
        });
  }

  Widget _buildError(List<Episode> episodeList, Supplements supplements) {
    return _buildContent(episodeList, supplements);
  }

  Widget _buildContent(List<Episode> episodeList, Supplements supplements) {
    final playerState = supplements.playerState;
    final shouldLeaveSpace = playerState != inactiveState;

    return RefreshIndicator(
      onRefresh: bloc.refresh,
      backgroundColor: Colors.white,
      color: AppColors.secondary,
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          _buildSeries(),
          _buildRecent(episodeList, supplements),
          shouldLeaveSpace ? const SizedBox(height: 70) : Container()
        ],
      ),
    );
  }

  Widget _buildLoading(List<Episode> episodeList, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  _buildSeries() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, top: 8),
          child: AppText('Series',
              family: FontFamily.casual,
              weight: 400,
              size: 18,
              color: AppColors.header),
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 175,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: seriesList.length,
              itemBuilder: (context, index) {
                final series = seriesList[index];
                final isFirst = index == 0;
                final isLast = index == 4;

                return Container(
                  margin: EdgeInsets.only(
                      left: isFirst ? 24 : 10, right: isLast ? 12 : 0),
                  child: GestureDetector(
                    onTap: () => SeriesPage.navigateTo(context, series),
                    child: SizedBox(width: 96, child: SeriesWidget(series)),
                  ),
                );
              },
            )),
        const SizedBox(height: 8),
      ],
    );
  }

  _buildRecent(List<Episode> episodeList, Supplements supplements) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            episodeList.map((e) => _buildEpisode(e, supplements)).toList());
  }

  Widget _buildEpisode(Episode episode, Supplements supplements) {
    final activeId = supplements.activeId;
    final playerState = supplements.playerState;

    final isLoading = playerState == loadingState;
    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;

    final isInactive =
        (isLoading || isPlaying || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);

    return Column(
      children: [
        Container(height: 1, color: AppColors.separator),
        Padding(
            padding: const EdgeInsets.only(left: 24, right: 20),
            child: GestureDetector(
                onTap: () => EpisodePage.navigateTo(context, episode),
                child: EpisodeTile(Pages.homepage,
                    playCallback: isInactive ? () {} : () => bloc.play(episode),
                    status: status,
                    duration: Utils.convertFrom(episode.duration,
                        includeSeconds: false),
                    episode: episode,
                    actionPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10)))),
      ],
    );
  }
}
