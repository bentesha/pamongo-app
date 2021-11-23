import 'dart:async';
import '../source.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({this.episode, this.id, key}) : super(key: key);

  final Episode? episode;
  final String? id;

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
    bloc.init(episode: widget.episode, episodeId: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handlePop,
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  _buildAppBar() {
    final isOpenedUsingLink = widget.episode == null;

    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppTopBars.episodePage(isOpenedUsingLink),
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
          shareCallback: bloc.share,
        ),
        SizedBox(height: shouldLeaveSpace ? 70 : 10)
      ],
    );
  }

  Widget _buildLoading(Episode episode, Supplements supplements) =>
      const AppLoadingIndicator();

  /// pushes to homepage if app is opened using the link, otherwise normal
  /// behaviour applies.
  Future<bool> _handlePop() async {
    final isOpenedUsingLink = widget.episode == null;
    if (isOpenedUsingLink) Homepage.navigateTo(context);
    return true;
  }
}
