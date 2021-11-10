import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/homepage_bloc.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/homepage_state.dart';
import 'package:podcasts/widgets/audio_progress_indicator.dart';
import 'package:podcasts/widgets/error_screen.dart';
import 'package:podcasts/widgets/page_episode_tiles.dart';
import '../source.dart';
import 'explore_page.dart';
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
    return Scaffold(
        body: BlocBuilder<HomepageBloc, HomepageState>(
            bloc: bloc,
            builder: (_, state) {
              return state.when(
                  loading: _buildLoading,
                  failed: _buildError,
                  content: _buildContent);
            }));
  }

  Widget _buildContent(
      List episodeList, List seriesList, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;
    return RefreshIndicator(
        onRefresh: bloc.refresh,
        backgroundColor: Colors.white,
        color: AppColors.accentColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
                floating: true,
                forceElevated: true,
                backgroundColor: AppColors.backgroundColor,
                elevation: 1,
                toolbarHeight: 55,
                centerTitle: false,
                title: Image.asset('assets/images/logo_long.png', height: 25),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const ExplorePage())),
                      padding: const EdgeInsets.only(right: 10),
                      icon: const Icon(Icons.explore_outlined,
                          size: 28, color: AppColors.secondaryColor))
                ]),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              _buildSeries(seriesList),
              _buildRecent(episodeList, supplements),
              shouldLeaveSpace
                  ? const SizedBox(height: 80)
                  : const SizedBox(height: 15),
            ]))
          ],
        ));
  }

  _buildSeries(List seriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 18, top: 18),
          child: AppText('Featured Series', weight: FontWeight.w600, size: 20),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10)
      ],
    );
  }

  Widget _buildSeriesEntry(Series series, int seriesIndex, int seriesLength) {
    final isFirst = seriesIndex == 0;
    final isLast = seriesIndex == seriesLength - 1;

    return GestureDetector(
      onTap: () async => SeriesPage.navigateTo(context, series.id),
      child: Container(
        width: 96,
        margin:
            EdgeInsets.only(left: isFirst ? 18 : 10, right: isLast ? 12 : 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppImage(image: series.image, height: 96, width: 96, radius: 10),
          const SizedBox(height: 9),
          AppText(series.name,
              alignment: TextAlign.start,
              size: 14,
              maxLines: 3,
              color: AppColors.textColor2,
              weight: FontWeight.w600),
          const SizedBox(height: 5),
          AppText(series.channelName,
              size: 12,
              alignment: TextAlign.start,
              color: AppColors.textColor2,
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
                resumeCallback: bloc.togglePlayerStatus,
                playCallback: bloc.play,
                supplements: supplements,
                episode: e))
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
        OverlayEntry(builder: (context) => const AudioProgressIndicator());
    overlay.insert(entry);
  }
}
