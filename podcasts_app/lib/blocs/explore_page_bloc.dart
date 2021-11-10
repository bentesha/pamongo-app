import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/repositories/podcasts_repository.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/explore_page_state.dart';

class ExplorePageBloc extends Cubit<ExplorePageState> {
  ExplorePageBloc(this.service) : super(ExplorePageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  final AudioPlayerService service;

  Future<void> load() async {
    emit(ExplorePageState.loading(state.episodesList, state.seriesList,
        state.channelList, state.supplements));
    final playerState = service.getCurrentContent.playerState;
    var supplements = state.supplements.copyWith(playerState: playerState);
    try {
      final channelsList = await PodcastsRepository.getAllChannels();
      final seriesList = await PodcastsRepository.getAllSeries();
      final episodesList = await PodcastsRepository.getAllEpisodes();

      emit(ExplorePageState.content(
          episodesList, seriesList, channelsList, supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(ExplorePageState.failed(state.episodesList, state.seriesList,
          state.channelList, supplements));
    }
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final content = service.getCurrentContent;
    final playerState = content.playerState;

    final supplements = state.supplements.copyWith(playerState: playerState);
    emit(ExplorePageState.content(
        state.episodesList, state.seriesList, state.channelList, supplements));
  }
}
