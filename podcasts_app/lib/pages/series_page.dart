import 'package:podcasts/widgets/series_page_episode_tile.dart';
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

    return WillPopScope(
      onWillPop: _handlePop,
      child: AppListView(
          backArrowCallback: widget.isOpenedUsingLink
              ? () => Homepage.navigateTo(context)
              : null,
          header: series.name,
          children: [
            _buildTitle(series),
            _buildEpisodeList(episodeList, supplements),
            shouldLeaveSpace ? SizedBox(height: 70.dh) : Container()
          ]),
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
                      size: 16.w, weight: FontWeight.w600, maxLines: 3),
                  SizedBox(height: 5.dh),
                  GestureDetector(
                    onTap: () => ChannelPage.navigateTo(context,
                        channelId: series.channelId),
                    child: AppText(series.channelName,
                        size: 14.w, color: AppColors.focusColor),
                  )
                ],
              ),
            ),
            SizedBox(width: 10.dw),
            AppImage(
                imageUrl: series.image,
                height: 96.dh,
                width: 96.dh,
                radius: 10.dw),
            SizedBox(width: 10.dw),
          ]),
        ),
        SizedBox(height: 10.dh),
        SeriesActionButtons(
            visitSeriesCallback: () {},
            shareCallback: () => bloc.share(ContentType.series, series.id),
            isOnSeriesPage: true),
        Padding(
            padding: EdgeInsets.only(right: 10.dw, top: 5.dh),
            child: AppRichText(
              text: AppText(series.description, size: 16.w, maxLines: 5),
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
        ? Padding(
            padding: EdgeInsets.all(18.dw),
            child: AppText('No episode has been uploaded yet.',
                size: 18.w, color: AppColors.textColor2),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 1, color: AppColors.dividerColor),
              Padding(
                padding: EdgeInsets.fromLTRB(18.dw, 10.dh, 10.dw, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AppText(
                      listLength.toString() + ' Episode${isOnlyOne ? '' : 's'}',
                      size: 18.w,
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
                itemBuilder: (_, index) => SeriesPageEpisodeTile(
                    index: index,
                    episode: episodeList[index],
                    supplements: supplements,
                    resumeCallback: bloc.togglePlayerStatus,
                    playCallback: bloc.play,
                    markAsDoneCallback: bloc.markAsPlayed,
                    shareCallback: (id) => bloc.share(ContentType.episode, id)),
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

  /// pushes to homepage if app is opened using the link, otherwise normal
  /// behaviour applies.
  Future<bool> _handlePop() async {
    if (widget.isOpenedUsingLink) Homepage.navigateTo(context);
    return true;
  }
}
