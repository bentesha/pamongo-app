import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/search_page_state.dart';

class SearchPageBloc extends Cubit<SearchPageState> {
  SearchPageBloc(this.service) : super(SearchPageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentChanges(content);
    });
  }

  final AudioPlayerService service;

  List<Episode> _episodesList = [];
  List<Series> _seriesList = [];
  List<Channel> _channelsList = [];

  void init(List<Episode> episodesList, List<Series> seriesList,
      List<Channel> channelsList) {
    _episodesList = episodesList;
    _seriesList = seriesList;
    _channelsList = channelsList;
    final playerState = service.getCurrentContent.playerState;
    final supplements = state.supplements.copyWith(playerState: playerState);
    emit(SearchPageState.content(episodesList, seriesList, channelsList,
        state.searchKeyword, supplements));
  }

  void changeKeyword(String keyword) {
    var episodesList = state.episodesList;
    var seriesList = state.seriesList;
    var channelsList = state.channelsList;
    final supplements = state.supplements;

    emit(SearchPageState.loading(
        episodesList, seriesList, channelsList, keyword, supplements));

    episodesList = _episodesList
        .where((e) => e.title.toLowerCase().contains(keyword))
        .toList();
    seriesList = _seriesList
        .where((e) => e.name.toLowerCase().contains(keyword))
        .toList();
    channelsList = _channelsList
        .where((e) => e.name.toLowerCase().contains(keyword))
        .toList();

    emit(SearchPageState.content(
        episodesList, seriesList, channelsList, keyword, supplements));
  }

  _handleContentChanges(ProgressIndicatorContent content) {
    final supplements =
        state.supplements.copyWith(playerState: content.playerState);

    emit(SearchPageState.content(state.episodesList, state.seriesList,
        state.channelsList, state.searchKeyword, supplements));
  }
}
