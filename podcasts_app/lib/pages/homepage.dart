import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:podcasts/blocs/homepage_bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/repositories/podcasts_api.dart';
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
    return BlocConsumer<HomepageBloc, HomepageState>(
        bloc: bloc,
        listener: (_, state) {
          final error = state.maybeWhen(
              failed: (_, __, s) => s.apiError, orElse: () => null);

          if (error != null) _showError(error);
        },
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              failed: _buildError,
              content: _buildContent);
        });
  }

  _showError(ApiError error) async {
    Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.error,
        textColor: AppColors.onPrimary);
  }

  Widget _buildLoading(
      List episodeList, List seriesList, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildError(
      List episodeList, List seriesList, Supplements supplements) {
    return _buildContent(episodeList, seriesList, supplements);
  }

  Widget _buildContent(
      List episodeList, List seriesList, Supplements supplements) {
    final playerState = supplements.playerState;
    final shouldLeaveSpace = playerState != inactiveState;

    return RefreshIndicator(
      onRefresh: bloc.refresh,
      backgroundColor: Colors.white,
      color: AppColors.secondary,
      child: ListView(
        padding: const EdgeInsets.only(top: 10),
        children: [
          _buildSeries(seriesList),
          _buildRecent(episodeList, supplements),
          shouldLeaveSpace ? const SizedBox(height: 70) : Container()
        ],
      ),
    );
  }

  _buildSeries(List seriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18, top: 8),
          child: AppText('Series',
              family: 'Casual', size: 18, color: AppColors.active),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: seriesList.map((series) {
              final index = seriesList.indexOf(series);
              final isFirst = index == 0;
              final isLast = index == seriesList.length - 1;

              return Container(
                  margin: EdgeInsets.only(
                      left: isFirst ? 18 : 10, right: isLast ? 12 : 0),
                  child: GestureDetector(
                    onTap: () async =>
                        SeriesPage.navigateTo(context, series.id),
                    child:
                        SizedBox(width: 96, child: _buildSeriesEntry(series)),
                  ));
            }).toList(),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  _buildSeriesEntry(Series series) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AppImage(image: series.image, height: 96, width: 96, radius: 10),
      const SizedBox(height: 9),
      AppText(series.name, alignment: TextAlign.start, size: 14, maxLines: 3),
      const SizedBox(height: 5),
      AppText(series.channelName,
          size: 12,
          alignment: TextAlign.start,
          color: AppColors.onSecondary2,
          maxLines: 3)
    ]);
  }

  _buildRecent(List episodeList, Supplements supplements) {
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
                child: EpisodeTile(
                  page: Pages.homepage,
                  episode: episode,
                  status: status,
                  descriptionMaxLines: 3,
                  actionPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  playCallback: isInactive ? () {} : () => bloc.play(episode),
                  duration: Utils.convertFrom(episode.duration,
                      includeSeconds: false),
                ))),
      ],
    );
  }

  void _insertOverlay() {
    final overlay = Overlay.of(context)!;
    final entry =
        OverlayEntry(builder: (context) => const AudioProgressWidget());
    overlay.insert(entry);
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
