import '../source.dart';
class ExplorePageBloc extends Cubit<ExplorePageState> {
  ExplorePageBloc(this.service) : super(ExplorePageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  final AudioPlayerService service;
  String _searchKeyword = '';
  List<Episode> _episodesList = [];
  List<Series> _seriesList = [];
  List<Channel> _channelList = [];

  Future<void> load() async {
    emit(ExplorePageState.loading(state.episodesList, state.seriesList,
        state.channelList, state.supplements));
    final playerState = service.getCurrentContent.playerState;
    var supplements = state.supplements.copyWith(playerState: playerState);
    try {
      final channelList = await PodcastsRepository.getAllChannels();
      final seriesList = await PodcastsRepository.getAllSeries();
      final episodeList = await PodcastsRepository.getAllEpisodes();

      _episodesList = episodeList;
      _seriesList = seriesList;
      _channelList = channelList;

      emit(ExplorePageState.content(
          episodeList, seriesList, channelList, '', supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(ExplorePageState.failed(state.episodesList, state.seriesList,
          state.channelList, supplements));
    }
  }

  void changeKeyword(String keyword) {
    var episodesList = state.episodesList;
    var seriesList = state.seriesList;
    var channelsList = state.channelList;
    final supplements = state.supplements;

    _searchKeyword = keyword;

    emit(ExplorePageState.loading(
        episodesList, seriesList, channelsList, supplements));

    episodesList = _episodesList
        .where((e) => e.title.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    seriesList = _seriesList
        .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    channelsList = _channelList
        .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
        .toList();

    log(seriesList.length.toString());

    emit(ExplorePageState.content(
        episodesList, seriesList, channelsList, keyword, supplements));
  }

  void clear() {
    emit(ExplorePageState.loading(state.episodesList, state.seriesList,
        state.channelList, state.supplements));

    _searchKeyword = '';

    emit(ExplorePageState.content(
        _episodesList, _seriesList, _channelList, '', state.supplements));
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final content = service.getCurrentContent;
    final playerState = content.playerState;

    final supplements = state.supplements.copyWith(playerState: playerState);
    emit(ExplorePageState.content(state.episodesList, state.seriesList,
        state.channelList, _searchKeyword, supplements));
  }
}
