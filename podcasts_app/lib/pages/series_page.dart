import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/series_page_bloc.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';
import 'package:podcasts/widgets/error_screen.dart';
import 'package:podcasts/widgets/page_episode_tiles.dart';
import 'package:podcasts/widgets/series_action_buttons.dart';
import 'package:podcasts/widgets/sort_button.dart';
import '../source.dart';
import 'channel_page.dart';

class SeriesPage extends StatefulWidget {
  final String seriesId;
  const SeriesPage(this.seriesId, {key}) : super(key: key);

  static void navigateTo(BuildContext context, String seriesId) =>
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (_) => SeriesPage(seriesId)));

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late final SeriesPageBloc bloc;
  late final AudioPlayerService service;
  final topScrolledPixelsNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = SeriesPageBloc(service);
    bloc.init(widget.seriesId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeriesPageBloc, SeriesPageState>(
      bloc: bloc,
      builder: (_, state) {
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            failed: _buildError);
      },
    );
  }

  Widget _buildContent(Series series, Supplements supplements) {
    final episodeList = series.episodeList;
    final playerState = supplements.playerState;
    final shouldLeaveSpace = playerState != inactiveState;

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        topScrolledPixelsNotifier.value = notification.metrics.pixels;
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(series.name),
        body: ListView(children: [
          _buildTitle(series),
          EpisodeTiles.introEpisode(
              seriesName: series.name,
              episodeList: episodeList,
              playCallback: bloc.play,
              resumeCallback: bloc.togglePlayerStatus,
              supplements: supplements),
          _buildEpisodeList(episodeList, supplements),
          shouldLeaveSpace ? const SizedBox(height: 80) : Container()
        ]),
      ),
    );
  }

  _buildAppBar(String appBarTitle) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: ValueListenableBuilder<double>(
          valueListenable: topScrolledPixelsNotifier,
          builder: (context, value, child) {
            return AppTopBars.seriesPage(
                topScrolledPixels: value, title: appBarTitle);
          }),
    );
  }

  _buildTitle(Series series) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 15, 15),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 100,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(series.name,
                      size: 16, weight: FontWeight.w600, maxLines: 2),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelId: series.channelId),
                    child: AppText(series.channelName,
                        size: 14, color: AppColors.focusColor),
                  )
                ],
              ),
            ),
            const SizedBox(width: 10),
            AppImage(image: series.image, height: 96, width: 96, radius: 10),
            const SizedBox(width: 10),
          ]),
        ),
        const SizedBox(height: 10),
        SeriesActionButtons(visitSeriesCallback: () {}, isOnSeriesPage: true),
        Padding(
            padding: const EdgeInsets.only(right: 10),
            child: AppRichText(
              text: AppText(series.description, size: 16, maxLines: 4),
              useToggleExpansionButtons: true,
            ))
      ]),
    );
  }

  Widget _buildEpisodeList(List episodeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;
    final isOnlyOne = episodeList.length == 2;
    final numberOfEpisodes = episodeList.length - 1;

    return numberOfEpisodes == 0
        ? const Padding(
            padding: EdgeInsets.all(18),
            child: AppText('No episode has been uploaded yet.',
                size: 18, color: AppColors.textColor2),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppText(
                        numberOfEpisodes.toString() +
                            ' Episode${isOnlyOne ? '' : 's'}',
                        size: 18,
                        weight: FontWeight.w400),
                    isOnlyOne
                        ? const SizedBox(height: 35)
                        : SortButton(
                            sortStyle: sortStyle, onSelectedCallback: bloc.sort)
                  ],
                ),
              ),
              ListView.builder(
                itemCount: episodeList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final episode = episodeList[index];
                  final isIntroEpisode = episode.episodeNumber == 0;
                  return isIntroEpisode
                      ? Container()
                      : EpisodeTiles.seriesPage(
                          index: index,
                          episode: episode,
                          supplements: supplements,
                          resumeCallback: bloc.togglePlayerStatus,
                          playCallback: bloc.play);
                },
              ),
              const SizedBox(height: 10)
            ],
          );
  }

  Widget _buildError(Series series, Supplements supplements) {
    return ErrorScreen(supplements.apiError!,
        refreshCallback: () => bloc.init(widget.seriesId));
  }

  Widget _buildLoading(Series series, Supplements supplements) {
    return const AppLoadingIndicator();
  }
}
