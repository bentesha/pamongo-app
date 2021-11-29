import 'package:podcasts/source.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final PageController controller = PageController();
  final textEditingController = TextEditingController();
  final indexNotifier = ValueNotifier<int>(0);
  late final AudioPlayerService service;
  late final ExplorePageBloc bloc;

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    bloc = ExplorePageBloc(service);
    bloc.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExplorePageBloc, ExplorePageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(
              loading: _buildLoading,
              content: _buildContent,
              failed: _buildFailed);
        });
  }

  Widget _buildContent(List<Episode> episodeList, List<Series> seriesList,
      List<Channel> channelList, String keyword, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;

    return Scaffold(
      appBar: _buildAppBar(episodeList, seriesList, channelList, keyword),
      body: Column(
        children: [
          SizedBox(height: 10.dh),
          Row(
            children: [
              _buildTabSwitcher(index: 0, tabName: 'Episodes'),
              _buildTabSwitcher(index: 1, tabName: 'Series'),
              _buildTabSwitcher(index: 2, tabName: 'Channels'),
            ],
          ),
          Expanded(
            child: PageView(
                controller: controller,
                onPageChanged: _onPageChanged,
                children: [
                  _buildEpisodeList(episodeList, keyword, shouldLeaveSpace),
                  _buildSeriesGrid(seriesList, keyword, shouldLeaveSpace),
                  _buildChannelsGrid(channelList, keyword, shouldLeaveSpace),
                ]),
          ),
        ],
      ),
    );
  }

  _buildAppBar(List<Episode> episodeList, List<Series> seriesList,
      List<Channel> channelList, String keyword) {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.dh),
      child: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(EvaIcons.arrowBackOutline, size: 25.dw),
              onPressed: () => Navigator.of(context).pop()),
          title: _buildSearchBar(keyword)),
    );
  }

  _buildSearchBar(String keyword) {
    return SizedBox(
      height: 35.dh,
      child: TextField(
          controller: textEditingController,
          onChanged: bloc.changeKeyword,
          cursorColor: AppColors.primaryColor,
          style: const TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              hintText: 'search Pamongo',
              filled: true,
              fillColor: AppColors.indicatorColor,
              enabledBorder: _inputBorder,
              focusedBorder: _inputBorder,
              contentPadding: EdgeInsets.only(left: 10.dw, top: 15.dw),
              suffixIcon: IconButton(
                  onPressed: keyword.isEmpty
                      ? () {}
                      : () {
                          textEditingController.clear();
                          bloc.clear();
                        },
                  icon: Icon(keyword.isEmpty ? EvaIcons.search : EvaIcons.close,
                      size: 18.dw, color: AppColors.secondaryColor)))),
    );
  }

  _buildTabSwitcher({required int index, required String tabName}) {
    return ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (_, currentIndex, __) {
          final isSelected = index == currentIndex;

          return Expanded(
              child: GestureDetector(
            onTap: () {
              controller.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut);
              indexNotifier.value = index;
            },
            child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1, color: AppColors.dividerColor))),
                child: Column(
                  children: [
                    AppText(tabName,
                        size: 16.w,
                        weight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor),
                    Container(
                        height: 3.dh,
                        width: 100.dw,
                        margin: EdgeInsets.only(top: 5.dh),
                        color: currentIndex == index
                            ? AppColors.primaryColor
                            : Colors.transparent)
                  ],
                )),
          ));
        });
  }

  Widget _buildLoading(List<Episode> episodeList, List<Series> seriesList,
          List<Channel> channelList, Supplements supplements) =>
      const AppLoadingIndicator();

  Widget _buildFailed(List<Episode> episodeList, List<Series> seriesList,
          List<Channel> channelList, Supplements supplements) =>
      ErrorScreen(
        supplements.apiError!,
        refreshCallback: bloc.load,
      );

  void _onPageChanged(int index) {
    controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
    indexNotifier.value = index;
  }

  _buildEpisodeList(
          List<Episode> episodeList, String keyword, bool shouldLeaveSpace) =>
      episodeList.isEmpty
          ? Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 30.dw),
              child: AppText('No episode matches that keyword', size: 16.w))
          : ListView.builder(
              padding: EdgeInsets.fromLTRB(
                  0, 10.dh, 0, shouldLeaveSpace ? 80.dh : 10.dh),
              itemCount: episodeList.length,
              itemBuilder: (_, index) {
                final episode = episodeList[index];
                return AppMaterialButton(
                  onPressed: () => EpisodePage.navigateTo(_, episode),
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.dw, vertical: 5.dh),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightedText(
                          AppText(episode.title,
                              maxLines: 2,
                              size: 15.w,
                              weight: FontWeight.w600,
                              alignment: TextAlign.start),
                          keyword: keyword),
                      Row(
                        children: [
                          AppText('from:  ', size: 14.h),
                          AppText(episode.seriesName,
                              maxLines: 1, size: 14.h, cutFrom: 45),
                        ],
                      ),
                      Row(
                        children: [
                          AppText('ep no. ', size: 14.h),
                          AppText('${episode.episodeNumber}', size: 14.h),
                        ],
                      )
                    ],
                  ),
                );
              },
            );

  _buildSeriesGrid(
          List<Series> seriesList, String keyword, bool shouldLeaveSpace) =>
      _buildGrid(seriesList, ContentType.series, keyword, shouldLeaveSpace);

  _buildChannelsGrid(
          List<Channel> channelList, String keyword, bool shouldLeaveSpace) =>
      _buildGrid(channelList, ContentType.channel, keyword, shouldLeaveSpace);

  _buildGrid(List list, ContentType contentType, String keyword,
      bool shouldLeaveSpace) {
    final isSeries = contentType == ContentType.series;
    final content = isSeries ? 'series' : 'channel';

    return list.isEmpty
        ? Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 30.dw),
            child: AppText('No $content matches that keyword', size: 16.w))
        : GridView.count(
            crossAxisCount: 3,
            childAspectRatio: .73,
            padding: EdgeInsets.only(
                left: 15.dw,
                right: 15.dw,
                top: 15.dh,
                bottom: shouldLeaveSpace ? 70.dh : 0),
            children: list.map((e) {
              return AppMaterialButton(
                padding: EdgeInsets.all(5.dw),
                borderRadius: 10.dw,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) =>
                            isSeries ? SeriesPage(e.id) : ChannelPage(e.id))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage(image: e.image, height: 120.h, radius: 10.dw),
                    SizedBox(height: 10.dh),
                    HighlightedText(
                        AppText(e.name,
                            maxLines: 2,
                            size: 14.w,
                            weight: FontWeight.bold,
                            alignment: TextAlign.start),
                        keyword: keyword),
                  ],
                ),
              );
            }).toList());
  }

  final _inputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: AppColors.disabledColor),
      borderRadius: BorderRadius.all(Radius.circular(15.dw)));
}
