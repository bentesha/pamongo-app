import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/episode_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/episode_page_state.dart';
import 'package:podcasts/themes/app_colors.dart';
import '../source.dart';
import 'series_page.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({required this.episode, key}) : super(key: key);

  final Episode episode;

  static void navigateTo(BuildContext context, Episode episode) =>
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => EpisodePage(episode: episode)));

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  late final EpisodePageBloc bloc;
  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = EpisodePageBloc(service);
    bloc.init(widget.episode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleWillPop,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.dh),
      child: AppTopBars.episodePage(context),
    );
  }

  _buildBody() {
    return BlocBuilder<EpisodePageBloc, EpisodePageState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: _buildError);
        });
  }

  Widget _buildLoading(Episode episode, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildContent(Episode episode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    final isLoading = playerState == loadingState;
    final isInactive =
        (isPlaying || isLoading || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(18.dw, 0, 15.dw, 20.dh),
            child: EpisodeTile(Pages.episodePage,
                status: status,
                episode: episode,
                duration:
                    Utils.convertFrom(episode.duration, includeSeconds: false),
                playCallback: isInactive ? () {} : bloc.play,
                actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 10.dw, 10.dh))),
        _buildButton(episode)
      ],
    );
  }

  Widget _buildError(Episode episode, Supplements supplements) {
    return _buildContent(episode, supplements);
  }

  _buildButton(Episode episode) {
    return Center(
      child: TextButton(
        onPressed: () => SeriesPage.navigateTo(
            context,
            Series(
                image: episode.image,
                name: episode.seriesName,
                description: episode.description,
                channel: episode.channel,
                episodeList: seriesEpisodeList)),
        child: AppText(
          'View All Episodes',
          color: AppColors.secondary,
          size: 15.w,
          weight: 600,
        ),
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
