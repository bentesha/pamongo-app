import '../source.dart';

class Homepage extends StatefulWidget {
  const Homepage({key}) : super(key: key);

  static navigateTo(BuildContext context) =>
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const Homepage()), (_) => false);

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
                toolbarHeight: 55.dh,
                centerTitle: false,
                title: Image.asset('assets/images/logo_long.png', height: 25),
                actions: [
                  IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const ExplorePage())),
                      padding: EdgeInsets.only(right: 10.dw),
                      icon: Icon(Icons.explore_outlined,
                          size: 28.dw, color: AppColors.secondaryColor))
                ]),
            SliverList(
                delegate: SliverChildListDelegate.fixed([
              _buildSeries(seriesList),
              _buildRecent(episodeList, supplements),
              shouldLeaveSpace
                  ? SizedBox(height: 80.dh)
                  : SizedBox(height: 15.dh),
            ]))
          ],
        ));
  }

  _buildSeries(List seriesList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.dw, top: 18.dh),
          child:
              AppText('Featured Series', weight: FontWeight.w600, size: 18.w),
        ),
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
        SizedBox(height: 10.dh)
      ],
    );
  }

  Widget _buildSeriesEntry(Series series, int seriesIndex, int seriesLength) {
    final isFirst = seriesIndex == 0;
    final isLast = seriesIndex == seriesLength - 1;

    return Container(
      width: 106.dw,
      margin: EdgeInsets.only(
          left: isFirst ? 12.dw : 0, right: isLast ? 8.dw : 0, top: 3.dh),
      child: AppMaterialButton(
        borderRadius: 10,
        onPressed: () async => SeriesPage.navigateTo(context, series.id),
        child: Padding(
          padding: EdgeInsets.all(6.dw),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            AppImage(
                image: series.image, height: 96.w, width: 96.w, radius: 10.dw),
            SizedBox(height: 9.dh),
            AppText(series.name,
                alignment: TextAlign.start,
                size: 13.w,
                maxLines: 3,
                color: AppColors.textColor2,
                weight: FontWeight.w600),
            SizedBox(height: 5.dh),
            AppText(series.channelName,
                size: 12.w,
                alignment: TextAlign.start,
                color: AppColors.textColor2,
                maxLines: 3)
          ]),
        ),
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
                  episode: e,
                  markAsDoneCallback: bloc.markAsPlayed,
                  shareCallback: bloc.share,
                ))
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
