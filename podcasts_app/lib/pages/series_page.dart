import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:podcasts/blocs/series_page_bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';
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
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
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

  Widget _buildError(List<Episode> envelopeList, Supplements supplements) {
    return _buildContent(envelopeList, supplements);
  }

  Widget _buildContent(List<Episode> envelopeList, Supplements supplements) {
    final playerState = supplements.playerState;
    final shouldLeaveSpace = playerState != inactiveState;

    return ListView(children: [
      _buildTitle(),
      _buildBodyContent(envelopeList, supplements),
      shouldLeaveSpace ? SizedBox(height: 80.dh) : Container()
    ]);
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.dh),
      child: AppTopBars.seriesPage(context),
    );
  }

  _buildTitle() {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 15.dw, 10.dh),
      child: Column(children: [
        SizedBox(
          height: 100.dh,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(series.name,
                      size: 16.w, family: FontFamily.workSans, weight: 600),
                  SizedBox(height: 8.dh),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelName: series.channel),
                    child: Text(
                      series.channel,
                      style: TextStyle(
                        fontSize: 16.dw,
                        fontFamily: 'WorkSans',
                        shadows: const [
                          Shadow(color: Colors.black, offset: Offset(0, -5))
                        ],
                        color: Colors.transparent,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
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
        SizedBox(height: 15.dh),
        Padding(
          padding: EdgeInsets.only(right: 10.dw),
          child: AppRichText(series.description),
        )
      ]),
    );
  }

  Widget _buildLoading(List<Episode> envelopeList, Supplements supplements) {
    return const AppLoadingIndicator();
  }

  Widget _buildBodyContent(
      List<Episode> envelopeList, Supplements supplements) {
    final sortStyle = supplements.sortStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.dh),
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
                  family: FontFamily.casual,
                  weight: 400,
                  size: 18.w,
                  color: AppColors.header),
              _buildSortButton(sortStyle)
            ],
          ),
        ),
        ListView.builder(
          itemCount: envelopeList.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final envelope = envelopeList[index];
            return _buildEpisodes(index, envelope, supplements);
          },
        ),
        SizedBox(height: 80.dh)
      ],
    );
  }

  _buildEpisodes(int index, Episode envelope, Supplements supplements) {
    return Column(children: [
      index == 0
          ? Container()
          : Container(height: 1, color: AppColors.separator),
      _buildEpisode(index, envelope, supplements)
    ]);
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

    return Padding(
      padding: EdgeInsets.only(left: 18.dw),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 0 ? const SizedBox(height: 1) : SizedBox(height: 10.dh),
          AppText(episode.date,
              family: FontFamily.louis,
              size: 14.w,
              color: AppColors.onSecondary2),
          SizedBox(height: 5.dh),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              weight: 600,
              size: 16.w,
              color: AppColors.onSecondary,
              family: FontFamily.louis),
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
                child: AppText("Sort by",
                    weight: 400, size: 16.w, family: FontFamily.casual),
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
    return Container(
      padding: EdgeInsets.only(left: 10.dw),
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
            width: isSelected ? 4.dw : 0,
            color: isSelected ? AppColors.secondary : Colors.transparent),
      )),
      alignment: Alignment.centerLeft,
      child: AppText(text,
          weight: 400,
          size: 14.w,
          family: FontFamily.casual,
          color: AppColors.onSecondary),
    );
  }
}
