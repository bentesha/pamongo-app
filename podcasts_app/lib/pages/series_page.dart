import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/series_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';
import 'package:podcasts/widgets/error_screen.dart';
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
    final isSortingFromFirstToLast =
        supplements.sortStyle == SortStyles.firstToLast;

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        topScrolledPixelsNotifier.value = notification.metrics.pixels;
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(series.name),
        body: ListView(children: [
          _buildTitle(series),
          _buildEpisodeIntro(
              series.name,
              isSortingFromFirstToLast
                  ? episodeList[0]
                  : episodeList[episodeList.length - 1],
              supplements),
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
                topScrolledPixels: value,
                title: appBarTitle,
                popCallback: () {
                  if (bloc.shouldPop()) Navigator.pop(context);
                });
          }),
    );
  }

  _buildEpisodeIntro(
      String seriesName, Episode introEpisode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final status = Utils.getStatus(introEpisode.id, activeId, playerState);
    final duration = Utils.convertFrom(introEpisode.duration);

    return Container(
        margin: const EdgeInsets.only(left: 18, right: 24, bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        color: const Color(0xffEEEDE7),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.only(bottom: 3),
              color: AppColors.onSecondary2,
              child: const AppText('INTRO',
                  size: 12,
                  weight: FontWeight.w600,
                  color: AppColors.onPrimary2)),
          AppText('Introducing $seriesName', size: 15, maxLines: 2),
          EpisodeActionButtons(Pages.seriesPage,
              playCallback: () => bloc.play(0),
              actionPadding: const EdgeInsets.only(top: 5),
              status: status,
              duration: duration)
        ]));
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
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelId: series.channelId),
                    child: Text(
                      series.channelName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'Louis',
                        fontWeight: FontWeight.w500,
                        shadows: [
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
              text: AppText(series.description,
                  size: 16, color: AppColors.onSecondary2, maxLines: 4),
              useToggleExpansionButtons: true,
            ))
      ]),
    );
  }

  Widget _buildEpisodeList(List episodeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;
    final isOnlyOne = episodeList.length == 2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppText(
                  (episodeList.length - 1).toString() +
                      ' Episode${isOnlyOne ? '' : 's'}',
                  family: 'Casual',
                  size: 18,
                  color: AppColors.active),
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
                : _buildEpisode(index, episode, supplements);
          },
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  _buildEpisode(int index, Episode episode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;
    final sortStyle = supplements.sortStyle;

    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isPaused = playerState == pausedState;

    final isInactive =
        (isPlaying || isLoading || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);

    final duration = Utils.convertFrom(episode.duration, includeSeconds: false);
    final date = Utils.formatDateBy(episode.date, 'yMMMd');

    final shouldPaintTopBorder =
        sortStyle == SortStyles.firstToLast ? index != 1 : index != 0;

    return Container(
      padding: const EdgeInsets.only(left: 18),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  width: shouldPaintTopBorder ? 1 : 0,
                  color: shouldPaintTopBorder
                      ? AppColors.separator
                      : Colors.transparent))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shouldPaintTopBorder
              ? const SizedBox(height: 10)
              : const SizedBox(height: 1),
          AppText(date, size: 14, color: AppColors.onSecondary2),
          const SizedBox(height: 5),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              weight: FontWeight.w600,
              size: 16,
              alignment: TextAlign.start,
              maxLines: 2),
          EpisodeActionButtons(
            Pages.seriesPage,
            playCallback: isInactive ? () {} : () => bloc.play(index),
            status: status,
            duration: duration,
            actionPadding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          )
        ],
      ),
    );
  }

  Widget _buildError(Series series, Supplements supplements) {
    return ErrorScreen(supplements.apiError!);
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
