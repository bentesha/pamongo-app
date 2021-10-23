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

    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        ListView(children: [
          _buildTitle(),
          _buildBodyContent(envelopeList, supplements),
          shouldLeaveSpace ? const SizedBox(height: 70) : Container()
        ]),
      ],
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppTopBars.seriesPage(context),
    );
  }

  _buildTitle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 15, 10),
      child: Column(children: [
        SizedBox(
          height: 100,
          child: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(series.name,
                      family: FontFamily.workSans, weight: 600),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelName: series.channel),
                    child: Text(
                      series.channel,
                      style: const TextStyle(
                        fontFamily: 'WorkSans',
                        shadows: [
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
            const SizedBox(width: 10),
            AppImage(image: series.image, height: 96, width: 96),
            const SizedBox(width: 10),
          ]),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(right: 10),
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
        const SizedBox(height: 10),
        Container(
          height: 1,
          color: AppColors.separator,
          margin: const EdgeInsets.only(top: 10),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              AppText(series.episodeList.length.toString() + '  Episodes',
                  family: FontFamily.casual,
                  weight: 400,
                  size: 18,
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
        const SizedBox(height: 80)
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
      padding: const EdgeInsets.only(left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          index == 0 ? const SizedBox(height: 1) : const SizedBox(height: 10),
          AppText(episode.date,
              family: FontFamily.louis,
              size: 14,
              color: AppColors.onSecondary2),
          const SizedBox(height: 5),
          AppText('Ep. ${episode.episodeNumber} : ${episode.title}',
              weight: 600,
              size: 16,
              color: AppColors.onSecondary,
              family: FontFamily.louis),
          EpisodeActionButtons(
            Pages.seriesPage,
            playCallback: isInactive ? () {} : () => bloc.play(index),
            status: status,
            duration:
                Utils.convertFrom(episode.duration, includeSeconds: false),
            actionPadding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
          )
        ],
      ),
    );
  }

  _buildSortButton(SortStyles sortStyle) {
    final isFirstToLast = sortStyle == SortStyles.firstToLast;
    final isLastToFirst = sortStyle == SortStyles.lastToFirst;

    return PopupMenuButton<int>(
        icon: const Icon(AppIcons.sort, size: 20),
        onSelected: bloc.sort,
        padding: EdgeInsets.zero,
        itemBuilder: (context) => [
              const PopupMenuItem(
                enabled: false,
                child:
                    AppText("Sort by", weight: 400, family: FontFamily.casual),
                value: 0,
              ),
              PopupMenuItem(
                child: _buildPopupMenuItem(
                    isLastToFirst, 'latest', 'assets/images/sortUp.svg'),
                value: 1,
              ),
              PopupMenuItem(
                child: _buildPopupMenuItem(
                    isFirstToLast, 'oldest', 'assets/images/sortDown.svg'),
                value: 2,
              ),
            ]);
  }

  _buildPopupMenuItem(bool isSelected, String text, String imagePath) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
              width: isSelected ? 2 : 0,
              color: isSelected ? AppColors.header : Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(imagePath,
              height: 25, fit: BoxFit.contain, color: AppColors.onSecondary),
          const SizedBox(width: 10),
          AppText(text,
              weight: 400,
              size: 14,
              family: FontFamily.casual,
              color: AppColors.onSecondary),
        ],
      ),
    );
  }
}
