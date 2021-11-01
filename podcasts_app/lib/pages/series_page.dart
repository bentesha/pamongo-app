import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:podcasts/blocs/series_page_bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';
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
  final scrollController = ScrollController();

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
    return BlocConsumer<SeriesPageBloc, SeriesPageState>(
      bloc: bloc,
      listener: (_, state) {
        final error =
            state.maybeWhen(failed: (_, s) => s.apiError, orElse: () => null);

        if (error != null) _showError(error);
      },
      builder: (_, state) {
        return state.when(
            loading: _buildLoading,
            content: _buildContent,
            failed: _buildError);
      },
    );
  }

  _showError(ApiError error) async {
    Fluttertoast.showToast(
        msg: error.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: AppColors.error,
        textColor: AppColors.onPrimary);
  }

  Widget _buildError(Series series, Supplements supplements) {
    return _buildContent(series, supplements);
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

  _buildEpisodeIntro(
      String seriesName, Episode introEpisode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final status = Utils.getStatus(introEpisode.id, activeId, playerState);
    final duration = Utils.convertFrom(introEpisode.duration);

    return Container(
        margin: EdgeInsets.only(left: 18.dw, right: 24.dw, bottom: 10.dh),
        padding: EdgeInsets.symmetric(horizontal: 10.dw, vertical: 8.dh),
        color: const Color(0xffEEEDE7),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: EdgeInsets.all(2.dw),
              margin: EdgeInsets.only(bottom: 3.dh),
              color: AppColors.onSecondary2,
              child: AppText('INTRO',
                  size: 12.w,
                  weight: FontWeight.w600,
                  color: AppColors.onPrimary2)),
          AppText('Introducing $seriesName', size: 15.w),
          EpisodeActionButtons(Pages.seriesPage,
              status: status,
              duration: duration,
              playCallback: bloc.playIntro,
              actionPadding: EdgeInsets.only(top: 5.dh))
        ]));
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
                  AppText(series.name, size: 16.w, weight: FontWeight.w600),
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

  Widget _buildLoading(Series series, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildEpisodeList(List episodeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;
    final isOnlyOne = episodeList.length == 2;

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
                  (episodeList.length - 1).toString() +
                      '  ' +
                      'Episode${isOnlyOne ? '' : 's'}',
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
          controller: scrollController,
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
        SizedBox(height: 10.dh)
      ],
    );
  }

  _buildEpisode(int index, Episode episode, Supplements supplements) {
    final playerState = supplements.playerState;
    final activeId = supplements.activeId;

    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isPaused = playerState == pausedState;

    final isInactive =
        (isPlaying || isLoading || isPaused) && activeId == episode.id;

    final status = Utils.getStatus(episode.id, activeId, playerState);
    final duration = Utils.convertFrom(episode.duration, includeSeconds: false);

    return Container(
      padding: EdgeInsets.only(left: 18.dw),
      decoration: const BoxDecoration(
          border:
              Border(top: BorderSide(width: 1, color: AppColors.separator))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.dh),
          AppText(episode.date, size: 14.w, color: AppColors.onSecondary2),
          SizedBox(height: 5.dh),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              weight: FontWeight.w600, size: 16.w, alignment: TextAlign.start),
          EpisodeActionButtons(
            Pages.seriesPage,
            status: status,
            duration: duration,
            actionPadding: EdgeInsets.fromLTRB(0, 10.dh, 0, 8.dh),
            playCallback: isInactive ? () {} : () => bloc.play(index),
          )
        ],
      ),
    );
  }

  Future<bool> _handleWillPop() async {
    final shouldPop = bloc.shouldPop();
    if (shouldPop) return true;
    return false;
  }
}
