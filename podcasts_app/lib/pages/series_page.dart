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
  const SeriesPage({required this.seriesId, key}) : super(key: key);

  static void navigateTo(BuildContext context, String seriesId) =>
      Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => SeriesPage(seriesId: seriesId)));

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
    return WillPopScope(onWillPop: _handleWillPop, child: _buildBody());
  }

  _buildBody() {
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
              supplements: supplements),
          _buildEpisodeList(episodeList, supplements),
          shouldLeaveSpace ? SizedBox(height: 80.dh) : Container()
        ]),
      ),
    );
  }

  _buildAppBar(String appBarTitle) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.dh),
      child: ValueListenableBuilder<double>(
          valueListenable: topScrolledPixelsNotifier,
          builder: (context, value, child) {
            return AppTopBars.seriesPage(
                topScrolledPixels: value,
                title: appBarTitle,
                popCallback: () {
                  if (bloc.shouldPop()) Navigator.pop(context);
                });
          }),
    );
  }

  _buildTitle(Series series) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 15.dw, 15.dh),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 100.dh,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(series.name,
                      size: 16.w, weight: FontWeight.w600, maxLines: 2),
                  SizedBox(height: 8.dh),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelId: series.channelId),
                    child: Text(
                      series.channelName,
                      style: TextStyle(
                        fontSize: 14.dw,
                        fontFamily: 'Louis',
                        fontWeight: FontWeight.w500,
                        shadows: const [
                          Shadow(color: AppColors.active, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.active,
                        decorationThickness: 2,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.dw),
            AppImage(
                image: series.image, height: 96.h, width: 96.h, radius: 10.dw),
            SizedBox(width: 10.dw),
          ]),
        ),
        SizedBox(height: 10.dh),
        SeriesActionButtons(visitSeriesCallback: () {}, isOnSeriesPage: true),
        Padding(
            padding: EdgeInsets.only(right: 10.dw),
            child: AppRichText(
              text: AppText(series.description,
                  size: 16.w, color: AppColors.onSecondary2, maxLines: 4),
              useToggleExpansionButtons: true,
            ))
      ]),
    );
  }

  Widget _buildEpisodeList(List episodeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;
    final isOnlyOne = episodeList.length == 2;
    final numberOfEpisodes = episodeList.length - 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(18.dw, 0, 10.dw, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppText(
                  numberOfEpisodes.toString() +
                      ' Episode${isOnlyOne ? '' : 's'}',
                  family: 'Casual',
                  size: 18.w,
                  color: AppColors.active),
              isOnlyOne
                  ? SizedBox(height: 35.dh)
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
                    playCallback: bloc.play);
          },
        ),
        SizedBox(height: 10.dh)
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

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
