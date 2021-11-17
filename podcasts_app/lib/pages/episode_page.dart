import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/episode_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/episode_page_state.dart';
import 'package:podcasts/widgets/page_episode_tiles.dart';
import '../source.dart';

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
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.dh),
      child: AppTopBars.episodePage(),
    );
  }

  _buildBody() {
    return BlocBuilder<EpisodePageBloc, EpisodePageState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(loading: _buildLoading, content: _buildContent);
        });
  }

  Widget _buildContent(Episode episode, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        EpisodeTiles.episodePage(
          episode: episode,
          supplements: supplements,
          resumeCallback: bloc.togglePlayerStatus,
          playCallback: bloc.play,
          markAsDoneCallback: bloc.markAsPlayed,
        ),
        shouldLeaveSpace ? SizedBox(height: 70.dh) : SizedBox(height: 10.dh)
      ],
    );
  }

  Widget _buildLoading(Episode episode, Supplements supplements) =>
      const AppLoadingIndicator();
}
