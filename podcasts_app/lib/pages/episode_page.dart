import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/episode_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/episode_page_state.dart';
import 'package:podcasts/themes/app_colors.dart';
import 'package:podcasts/widgets/error_screen.dart';
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
      child: AppTopBars.episodePage(() {
        bloc.shouldPop() ? Navigator.pop(context) : () {};
      }),
    );
  }

  _buildBody() {
    return BlocBuilder<EpisodePageBloc, EpisodePageState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
              loading: _buildLoading,
              failed: _buildError,
              content: _buildContent);
        });
  }

  Widget _buildContent(Episode episode, Supplements supplements) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _buildEpisodeTile(episode, supplements),
        _buildViewAllButton(episode)
      ],
    );
  }

  _buildEpisodeTile(Episode episode, Supplements supplements) {
    final activeId = supplements.activeId;
    final playerState = supplements.playerState;

    final isPlaying = playerState == playingState;
    final isPaused = playerState == pausedState;
    final isLoading = playerState == loadingState;
    final isInactive =
        (isPlaying || isLoading || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);
    final duration = Utils.convertFrom(episode.duration, includeSeconds: false);

    return Padding(
        padding: EdgeInsets.fromLTRB(18.dw, 0, 15.dw, 20.dh),
        child: EpisodeTile(
            page: Pages.episodePage,
            descriptionMaxLines: 10,
            useToggleExpansionButtons: true,
            status: status,
            episode: episode,
            duration: duration,
            playCallback: isInactive ? () {} : bloc.play,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 10.dw, 10.dh)));
  }

  _buildViewAllButton(Episode episode) {
    return Center(
      child: TextButton(
        onPressed: () => SeriesPage.navigateTo(context, episode.seriesId),
        child: AppText('View All Episodes',
            size: 15.w, weight: FontWeight.w600, color: AppColors.active),
      ),
    );
  }

  Widget _buildLoading(Episode episode, Supplements supplements) =>
      const AppLoadingIndicator();

  Widget _buildError(Episode episode, Supplements supplements) =>
      ErrorScreen(supplements.apiError!);

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
