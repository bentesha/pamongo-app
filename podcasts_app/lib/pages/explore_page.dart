import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/explore_page_bloc.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/pages/channel_page.dart';
import 'package:podcasts/pages/search_page.dart';
import 'package:podcasts/pages/series_page.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/states/explore_page_state.dart';
import 'package:podcasts/widgets/error_screen.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final PageController controller = PageController();
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
      List<Channel> channelList, Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;

    return Scaffold(
      appBar: _buildAppBar(episodeList, seriesList, channelList),
      body: Column(
        children: [
          SizedBox(height: 10.dh),
          Row(
            children: [
              _buildTabSwitcher(index: 0, tabName: 'Series'),
              _buildTabSwitcher(index: 1, tabName: 'Channels'),
            ],
          ),
          Expanded(
            child: PageView(
                controller: controller,
                onPageChanged: _onPageChanged,
                children: [
                  _buildSeriesGrid(seriesList, shouldLeaveSpace),
                  _buildChannelsGrid(channelList, shouldLeaveSpace),
                ]),
          ),
        ],
      ),
    );
  }

  _buildAppBar(List<Episode> episodeList, List<Series> seriesList,
      List<Channel> channelList) {
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
          title: GestureDetector(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (_) => SearchPage(
                      episodesList: episodeList,
                      seriesList: seriesList,
                      channelsList: channelList,
                    ))),
            child: Container(
                color: AppColors.indicatorColor,
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints.expand(height: 40.dh),
                padding: EdgeInsets.only(left: 10.dw),
                child: AppText(
                  'search Pamongo',
                  size: 16.w,
                  color: AppColors.textColor2,
                )),
          )),
    );
  }

  _buildTabSwitcher({required int index, required String tabName}) {
    return ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (_, currentIndex, __) {
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
                    AppText(tabName, size: 18.w),
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

  _buildSeriesGrid(List<Series> seriesList, bool shouldLeaveSpace) =>
      _buildGrid(seriesList, true, shouldLeaveSpace);

  _buildChannelsGrid(List<Channel> channelList, bool shouldLeaveSpace) =>
      _buildGrid(channelList, false, shouldLeaveSpace);

  _buildGrid(List list, bool isSeries, bool shouldLeaveSpace) {
    return GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        crossAxisCount: 3,
        childAspectRatio: .7,
        padding: EdgeInsets.only(
            left: 15.dw,
            right: 15.dw,
            top: 15.dh,
            bottom: shouldLeaveSpace ? 70.dh : 0),
        children: list.map((e) {
          return GestureDetector(
            onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (_) =>
                        isSeries ? SeriesPage(e.id) : ChannelPage(e.id))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage(image: e.image, height: 120.h, radius: 10.dw),
                SizedBox(height: 10.dh),
                AppText(e.name,
                    maxLines: 2, size: 14.w, alignment: TextAlign.start)
              ],
            ),
          );
        }).toList());
  }
}
