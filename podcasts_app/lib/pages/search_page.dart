import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/blocs/search_page_bloc.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/pages/pages_source.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/states/search_page_state.dart';
import 'package:podcasts/widgets/highlighted_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage(
      {required this.episodesList,
      required this.seriesList,
      required this.channelsList,
      key})
      : super(key: key);

  final List<Series> seriesList;
  final List<Episode> episodesList;
  final List<Channel> channelsList;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  late final SearchPageBloc bloc;
  late final AudioPlayerService service;

  @override
  void initState() {
    super.initState();
    service = Provider.of(context, listen: false);
    bloc = SearchPageBloc(service);
    bloc.init(widget.episodesList, widget.seriesList, widget.channelsList);
  }

  @override
  void dispose() {
    controller.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
      _buildSearchTextFiled(),
      _buildSearchResults(),
    ]));
  }

  _buildSearchTextFiled() {
    return Container(
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: AppColors.dividerColor))),
        child: Padding(
          padding: EdgeInsets.only(right: 18.dw, left: 18.dw, top: 25.dh),
          child: TextField(
            onChanged: bloc.changeKeyword,
            cursorColor: AppColors.primaryColor,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.dw),
            decoration: InputDecoration(
              hintText: 'search Pamongo',
              enabledBorder: _inputBorder,
              focusedBorder: _inputBorder,
              contentPadding: EdgeInsets.only(bottom: 5.dh),
              isDense: true,
            ),
            autofocus: true,
          ),
        ));
  }

  _buildSearchResults() {
    return BlocBuilder<SearchPageBloc, SearchPageState>(
        bloc: bloc,
        builder: (_, state) {
          return state.when(content: _buildContent, loading: _buildLoading);
        });
  }

  Widget _buildContent(
      List<Episode> episodeList,
      List<Series> seriesList,
      List<Channel> channelList,
      String searchKeyword,
      Supplements supplements) {
    final shouldLeaveSpace = supplements.playerState != inactiveState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEpisodesList(episodeList, searchKeyword),
        _buildSeriesList(seriesList, searchKeyword),
        _buildChannelsList(channelList, searchKeyword),
        shouldLeaveSpace ? SizedBox(height: 70.dh) : Container(),
      ],
    );
  }

  _buildEpisodesList(List<Episode> episodesList, String keyword) =>
      _buildList(episodesList, 'Episodes', keyword);

  _buildSeriesList(List<Series> seriesList, String keyword) =>
      _buildList(seriesList, 'Series', keyword);

  _buildChannelsList(List<Channel> channelsList, String keyword) =>
      _buildList(channelsList, 'Channels', keyword);

  _buildList(List list, String listTitle, String keyword) {
    final isEpisodesList = listTitle == 'Episodes';

    return list.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !isEpisodesList
                  ? Container(
                      height: 1.5,
                      color: AppColors.dividerColor,
                      margin: EdgeInsets.only(top: 20.dh, bottom: 10.dh))
                  : SizedBox(height: 20.dh),
              Padding(
                padding: EdgeInsets.only(right: 18.dw, left: 18.dw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      listTitle,
                      size: 18.w,
                      color: AppColors.textColor2,
                      weight: FontWeight.w600,
                    ),
                    SizedBox(height: 10.dh),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            list.map((e) => _buildItem(e, keyword)).toList()),
                  ],
                ),
              ),
            ],
          )
        : Container();
  }

  Widget _buildItem(var item, String keyword) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (_) => item is Episode
                  ? EpisodePage(episode: item)
                  : item is Series
                      ? SeriesPage(item.id)
                      : ChannelPage(item.id))),
      child: Container(
        padding: EdgeInsets.only(bottom: 8.dh),
        color: Colors.transparent,
        child: Row(
          children: [
            AppImage(image: item.image, radius: 10.dw, height: 50.h, width: 50),
            SizedBox(width: 10.dw),
            Expanded(
                child: HighlightedText(
              AppText(
                item is Episode ? item.title : item.name,
                size: 14.w,
                maxLines: 2,
                alignment: TextAlign.start,
              ),
              keyword: keyword.toLowerCase(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) {
    return const AppLoadingIndicator();
  }

  final _inputBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryColor, width: 2));
}
