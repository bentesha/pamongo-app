import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/series_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';
import 'package:podcasts/widgets/series_action_buttons.dart';
import '../source.dart';
import 'channel_page.dart';

class SeriesPage extends StatefulWidget {
  final Series series;
  const SeriesPage({required this.series, key}) : super(key: key);

  static void navigateTo(BuildContext context, Series series) =>
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (_) => SeriesPage(series: series)));

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  late final SeriesPageBloc bloc;
  late final AudioPlayerService service;
  late final Series series;
  final topScrolledPixelsNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = SeriesPageBloc(service);
    series = widget.series;
    bloc.init(series);
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

  Widget _buildError(List<Episode> episodeList, Supplements supplements) {
    return _buildContent(episodeList, supplements);
  }

  Widget _buildContent(List<Episode> episodeList, Supplements supplements) {
    final playerState = supplements.playerState;
    final shouldLeaveSpace = playerState != inactiveState;

    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        topScrolledPixelsNotifier.value = notification.metrics.pixels;
        return true;
      },
      child: Scaffold(
        appBar: _buildAppBar(widget.series.name),
        body: ListView(children: [
          _buildTitle(),
          _buildEpisodeIntro(episodeList[0], supplements),
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
            return AppTopBars.seriesPage(context,
                topScrolledPixels: value, title: appBarTitle);
          }),
    );
  }

  _buildEpisodeIntro(Episode introEpisode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final status = Utils.getStatus(introEpisode.id, activeId, playerState);
    final duration = Utils.convertFrom(introEpisode.duration);

    return Container(
        margin: EdgeInsets.only(left: 18.dw, right: 24.dw, bottom: 10.dh),
        padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 10.dh),
        color: const Color(0xffF8EA8C),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppText('INTRO', size: 14.w, weight: FontWeight.w600),
          AppText('Introducing ${widget.series.name}', size: 15.w),
          EpisodeActionButtons(Pages.seriesPage,
              playCallback: () => bloc.play(0),
              actionPadding: EdgeInsets.only(top: 8.dh),
              status: status,
              duration: duration)
        ]));
  }

  _buildTitle() {
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
                  AppText(series.name, size: 16.w, weight: FontWeight.w600),
                  SizedBox(height: 8.dh),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelName: series.channel),
                    child: Text(
                      series.channel,
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

  Widget _buildLoading(List<Episode> episodeList, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildEpisodeList(List<Episode> episodeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 1,
          color: AppColors.separator,
          margin: EdgeInsets.only(top: 10.dh),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(18.dw, 0, 10.dw, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppText(series.episodeList.length.toString() + '  Episodes',
                  family: 'Casual', size: 18.w, color: AppColors.active),
              _buildSortButton(sortStyle)
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
            final isIntroEpisode = index == 0;
            return isIntroEpisode
                ? Container()
                : _buildEpisode(index, episode, supplements);
          },
        ),
        SizedBox(height: 10.dh)
      ],
    );
  }

  _buildEpisode(int index, Episode episode, Supplements supplements) {
    return Column(children: [
      index == 1
          ? Container()
          : Container(height: 1, color: AppColors.separator),
      _episode(index, episode, supplements)
    ]);
  }

  _episode(int index, Episode episode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isPaused = playerState == pausedState;

    final isInactive =
        (isPlaying || isLoading || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);

    return Padding(
      padding: EdgeInsets.only(left: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 1 ? const SizedBox(height: 1) : SizedBox(height: 10.dh),
          AppText(episode.date, size: 14.w, color: AppColors.onSecondary2),
          SizedBox(height: 5.dh),
          AppText(
            'Ep. ${episode.episodeNumber} : ${episode.title}',
            weight: FontWeight.w600,
            size: 16.w,
          ),
          EpisodeActionButtons(
            Pages.seriesPage,
            playCallback: isInactive ? () {} : () => bloc.play(index),
            status: status,
            duration:
                Utils.convertFrom(episode.duration, includeSeconds: false),
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 0, 8.dh),
          )
        ],
      ),
    );
  }

  _buildSortButton(SortStyles sortStyle) {
    final isFirstToLast = sortStyle == SortStyles.firstToLast;
    final isLastToFirst = sortStyle == SortStyles.lastToFirst;

    return PopupMenuButton<int>(
        icon: Icon(AppIcons.sort, size: 20.dw),
        onSelected: bloc.sort,
        padding: EdgeInsets.zero,
        itemBuilder: (context) => [
              PopupMenuItem(
                height: 35.dh,
                enabled: false,
                child: AppText("Sort by", weight: FontWeight.w600, size: 16.w),
                value: 0,
              ),
              PopupMenuItem(
                height: 35.dh,
                child: _buildPopupMenuItem(isLastToFirst, 'latest'),
                value: 1,
              ),
              PopupMenuItem(
                height: 35.dh,
                child: _buildPopupMenuItem(isFirstToLast, 'oldest'),
                value: 2,
              ),
            ]);
  }

  _buildPopupMenuItem(bool isSelected, String text) {
    return Row(
      children: [
        Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.secondary : Colors.transparent)),
        SizedBox(width: 10.dw),
        AppText(text, size: 15.w),
      ],
    );
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
