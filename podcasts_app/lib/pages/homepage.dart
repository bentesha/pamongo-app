import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/homepage_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/homepage_state.dart';
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
    WidgetsBinding.instance!.addPostFrameCallback((_) => _insertOverlay());
    super.initState();
  }

  _insertOverlay() {
    final overlay = Overlay.of(context)!;
    final entry =
        OverlayEntry(builder: (context) => const AudioProgressWidget());
    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _handleWillPop,
        child: Scaffold(appBar: _buildAppBar(), body: _buildBody()));
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
          padding: EdgeInsets.only(left: 18, top: 8),
          child: AppText('Series',
              family: FontFamily.casual,
              weight: 400,
              size: 18,
              color: AppColors.active),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: seriesList.map((series) {
              final index = seriesList.indexOf(series);
              final isFirst = index == 0;
              final isLast = index == 4;

              return Container(
                  margin: EdgeInsets.only(
                      left: isFirst ? 18 : 10, right: isLast ? 12 : 0),
                  child: GestureDetector(
                    onTap: () => SeriesPage.navigateTo(context, series),
                    child: SizedBox(width: 96, child: _series(series)),
                  ));
            }).toList(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  _series(Series series) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppImage(image: series.image, height: 96, width: 96, radius: 10),
      const SizedBox(height: 9),
      AppText(series.name,
          family: FontFamily.louis,
          alignment: TextAlign.start,
          size: 14,
          weight: 400),
      const SizedBox(height: 5),
      AppText(series.channel,
          size: 12,
          family: FontFamily.louis,
          alignment: TextAlign.start,
          weight: 400,
          color: AppColors.onSecondary2)
    ]);
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
            padding: const EdgeInsets.only(left: 18, right: 20),
            child: GestureDetector(
                onTap: () => EpisodePage.navigateTo(context, episode),
                child: EpisodeTile(Pages.homepage,
                    playCallback: isInactive ? () {} : () => bloc.play(episode),
                    status: status,
                    duration: Utils.convertFrom(episode.duration,
                        includeSeconds: false),
                    episode: episode,
                    actionPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8)))),
      ],
    );
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
