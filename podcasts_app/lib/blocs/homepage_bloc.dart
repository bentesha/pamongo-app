import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/repositories/podcasts_repository.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/states/homepage_state.dart';

class HomepageBloc extends Cubit<HomepageState> {
  final AudioPlayerService service;

  HomepageBloc(this.service) : super(HomepageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  void init() async {
    emit(HomepageState.loading(
        state.episodeList, state.seriesList, state.supplements));
    try {
      final recent = await PodcastsRepository.getRecentEpisodes();
      final featured = await PodcastsRepository.getFeaturedSeries();
      emit(HomepageState.content(recent, featured, state.supplements));
    } on ApiError catch (e) {
      final supplements = state.supplements.copyWith(apiError: e);
      emit(HomepageState.failed(
          state.episodeList, state.seriesList, supplements));
    }
  }

  void play(Episode episode) async => await service.play([episode]);

  void togglePlayerStatus() async => await service.toggleStatus();

  Future<void> refresh() async {
    emit(HomepageState.loading(
        state.episodeList, state.seriesList, state.supplements));
    await Future.delayed(const Duration(seconds: 3)).then((_) => init());
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final episodeList = state.episodeList;
    final id = content.episodeList[content.currentIndex].id;
    final playerState = content.playerState;
    final remainingTime = service.getRemainingTime;

    final supplements = state.supplements.copyWith(
        playerState: playerState,
        activeId: id,
        activeEpisodeRemainingFraction: playerState == pausedState
            ? service.getRemainingTimeFraction
            : state.supplements.activeEpisodeRemainingFraction,
        activeEpisodeRemainingTime: playerState == pausedState
            ? Utils.convertFrom(remainingTime, includeSeconds: false)
            : state.supplements.activeEpisodeRemainingTime);
    emit(HomepageState.content(episodeList, state.seriesList, supplements));
  }
}
