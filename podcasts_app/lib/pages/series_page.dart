import 'package:flutter_bloc/flutter_bloc.dart';
import '../source.dart';

class SeriesPage extends StatefulWidget {
  final String seriesId;
  final bool isOpenedUsingLink;

  const SeriesPage(this.seriesId, {this.isOpenedUsingLink = false, key})
      : super(key: key);

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
      child: WillPopScope(
        onWillPop: _handlePop,
        child: Scaffold(
          appBar: _buildAppBar(series.name),
          body: ListView(children: [
            _buildTitle(series),
            _buildEpisodeList(episodeList, supplements),
            shouldLeaveSpace ? const SizedBox(height: 80) : Container()
          ]),
        ),
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
              isOpenedUsingLink: widget.isOpenedUsingLink,
            );
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
        SeriesActionButtons(
            visitSeriesCallback: () {},
            shareCallback: () => bloc.share(ContentType.series, series.id),
            isOnSeriesPage: true),
        Padding(
            padding: const EdgeInsets.only(right: 10, top: 5),
            child: AppRichText(
              text: AppText(series.description, size: 16, maxLines: 5),
              useToggleExpansionButtons: true,
            )),
      ]),
    );
  }

  Widget _buildEpisodeList(List<Episode> episodeList, Supplements supplements) {
    final listLength = episodeList.length;
    final sortStyle = supplements.sortStyle;
    final isOnlyOne = listLength == 1;

    return listLength == 0
        ? const Padding(
            padding: EdgeInsets.all(18),
            child: AppText('No episode has been uploaded yet.',
                size: 18, color: AppColors.textColor2),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1, color: AppColors.dividerColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 10, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppText(
                      listLength.toString() + ' Episode${isOnlyOne ? '' : 's'}',
                      size: 18,
                      weight: FontWeight.w600,
                    ),
                    SortButton(
                        sortStyle: sortStyle, onSelectedCallback: bloc.sort)
                  ],
                ),
              ),
              ListView.separated(
                itemCount: episodeList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) =>
                    Container(height: 1, color: AppColors.dividerColor),
                itemBuilder: (_, index) => EpisodeTiles.seriesPage(
                    index: index,
                    episode: episodeList[index],
                    supplements: supplements,
                    resumeCallback: bloc.togglePlayerStatus,
                    playCallback: bloc.play,
                    markAsDoneCallback: bloc.markAsPlayed,
                    shareCallback: (id) => bloc.share(ContentType.episode, id)),
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

  /// pushes to homepage if app is opened using the link, otherwise normal
  /// behaviour applies.
  Future<bool> _handlePop() async {
    if (widget.isOpenedUsingLink) Homepage.navigateTo(context);
    return true;
  }
}
