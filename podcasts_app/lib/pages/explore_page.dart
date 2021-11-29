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
          const SizedBox(height: 10),
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
      preferredSize: const Size.fromHeight(60),
      child: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(EvaIcons.arrowBackOutline, size: 25),
              onPressed: () => Navigator.of(context).pop()),
          title: _buildSearchBar(keyword)),
    );
  }

  _buildSearchBar(String keyword) {
    return SizedBox(
      height: 35,
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
              contentPadding: const EdgeInsets.only(left: 10, top: 15),
              suffixIcon: IconButton(
                  onPressed: keyword.isEmpty
                      ? () {}
                      : () {
                          textEditingController.clear();
                          bloc.clear();
                        },
                  icon: Icon(keyword.isEmpty ? EvaIcons.search : EvaIcons.close,
                      size: 18, color: AppColors.secondaryColor)))),
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
                        size: 16,
                        weight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.secondaryColor),
                    Container(
                        height: 3,
                        width: 100,
                        margin: const EdgeInsets.only(top: 5),
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
              margin: const EdgeInsets.only(top: 30),
              child: const AppText('No episode matches that keyword', size: 16))
          : ListView.builder(
              padding:
                  EdgeInsets.fromLTRB(0, 10, 0, shouldLeaveSpace ? 80 : 10),
              itemCount: episodeList.length,
              itemBuilder: (_, index) {
                final episode = episodeList[index];
                return AppMaterialButton(
                  onPressed: () => EpisodePage.navigateTo(_, episode),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HighlightedText(
                          AppText(episode.title,
                              maxLines: 2,
                              size: 15,
                              weight: FontWeight.w600,
                              alignment: TextAlign.start),
                          keyword: keyword),
                      Row(
                        children: [
                          const AppText('from:  ', size: 14),
                          AppText(episode.seriesName,
                              maxLines: 1, size: 14, cutFrom: 45),
                        ],
                      ),
                      Row(
                        children: [
                          const AppText('ep no. ', size: 14),
                          AppText('${episode.episodeNumber}', size: 14),
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
            margin: const EdgeInsets.only(top: 30),
            child: AppText('No $content matches that keyword', size: 16))
        : GridView.count(
            crossAxisCount: 3,
            childAspectRatio: .73,
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: shouldLeaveSpace ? 70 : 0),
            children: list.map((e) {
              return AppMaterialButton(
                padding: const EdgeInsets.all(5),
                borderRadius: 10,
                onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) =>
                            isSeries ? SeriesPage(e.id) : ChannelPage(e.id))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppImage(image: e.image, height: 120, radius: 10),
                    const SizedBox(height: 10),
                    HighlightedText(
                        AppText(e.name,
                            maxLines: 2,
                            size: 14,
                            weight: FontWeight.bold,
                            alignment: TextAlign.start),
                        keyword: keyword),
                  ],
                ),
              );
            }).toList());
  }

  static const _inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.disabledColor),
      borderRadius: BorderRadius.all(Radius.circular(15)));
}
