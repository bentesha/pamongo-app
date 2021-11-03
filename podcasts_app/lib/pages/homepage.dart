import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/homepage_bloc.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/homepage_state.dart';
import 'package:podcasts/widgets/audio_progress_widget.dart';
import 'package:podcasts/widgets/error_screen.dart';
import 'package:podcasts/widgets/page_episode_tiles.dart';
import '../source.dart';
import 'series_page.dart';

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
      preferredSize: Size.fromHeight(50.dh),
      child: AppTopBars.homepage(),
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

  Widget _buildContent(
      List episodeList, List seriesList, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;
    return RefreshIndicator(
      onRefresh: bloc.refresh,
      backgroundColor: Colors.white,
      color: AppColors.secondary,
      child: ListView(
        padding: EdgeInsets.only(top: 10.dh),
        children: [
          _buildSeries(seriesList),
          _buildRecent(episodeList, supplements),
          shouldLeaveSpace ? SizedBox(height: 80.dh) : SizedBox(height: 15.dh)
        ],
      ),
    );
  }

  _buildSeries(List seriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.dw, top: 8.dh),
          child: AppText('Series',
              family: 'Casual', size: 18.w, color: AppColors.active),
        ),
        SizedBox(height: 10.dh),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: seriesList.map((series) {
              final index = seriesList.indexOf(series);
              return _buildSeriesEntry(series, index, seriesList.length);
            }).toList(),
          ),
        ),
        SizedBox(height: 15.dh),
      ],
    );
  }

  Widget _buildSeriesEntry(Series series, int seriesIndex, int seriesLength) {
    final isFirst = seriesIndex == 0;
    final isLast = seriesIndex == seriesLength - 1;

    return GestureDetector(
      onTap: () async => SeriesPage.navigateTo(context, series.id),
      child: Container(
        width: 96.dw,
        margin: EdgeInsets.only(
            left: isFirst ? 18.dw : 10.dw, right: isLast ? 12.dw : 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppImage(
              image: series.image, height: 96.w, width: 96.w, radius: 10.dw),
          SizedBox(height: 9.dh),
          AppText(series.name,
              alignment: TextAlign.start, size: 14.w, maxLines: 3),
          SizedBox(height: 5.dh),
          AppText(series.channelName,
              size: 12.w,
              alignment: TextAlign.start,
              color: AppColors.onSecondary2,
              maxLines: 3)
        ]),
      ),
    );
  }

  _buildRecent(List episodeList, Supplements supplements) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: episodeList
            .map((e) => EpisodeTiles.homepage(
                playCallback: bloc.play, supplements: supplements, episode: e))
            .toList());
  }

  Widget _buildLoading(
          List episodeList, List seriesList, Supplements supplements) =>
      const AppLoadingIndicator();

  Widget _buildError(
          List episodeList, List seriesList, Supplements supplements) =>
      ErrorScreen(
        supplements.apiError!,
        refreshCallback: bloc.refresh,
      );

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
