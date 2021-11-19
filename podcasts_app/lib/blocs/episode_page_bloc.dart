import 'package:bloc/bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/repositories/podcasts_repository.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/episode_page_state.dart';
import 'package:podcasts/utils/utils.dart';

class EpisodePageBloc extends Cubit<EpisodePageState> {
  final AudioPlayerService service;

  EpisodePageBloc(this.service) : super(EpisodePageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  Future<void> init({Episode? episode, episodeId = ''}) async {
    emit(EpisodePageState.loading(state.episode, state.supplements));

    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final playerState = content.playerState;

    episode = episode ?? await PodcastsRepository.getEpisodeById(episodeId);

    final supplements = state.supplements.copyWith(
        activeId: id,
        playerState: playerState,
        activeEpisodeRemainingTime: playerState == pausedState
            ? Utils.convertFrom(service.getRemainingTime, includeSeconds: false)
            : state.supplements.activeEpisodeRemainingTime);
    emit(EpisodePageState.content(episode, supplements));
  }

  void play() async => await service.play([state.episode]);

  void togglePlayerStatus() async => await service.toggleStatus();

  void markAsPlayed(String id) => service.removeFromBox(id);

  void share(String id) async => await service.share(ContentType.episode, id);

  _handleContentStream(ProgressIndicatorContent content) async {
    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final playerState = content.playerState;

    emit(EpisodePageState.loading(state.episode, state.supplements));
    final supplements = state.supplements.copyWith(
        activeId: id,
        playerState: playerState,
        activeEpisodeRemainingTime: playerState == pausedState
            ? Utils.convertFrom(service.getRemainingTime, includeSeconds: false)
            : state.supplements.activeEpisodeRemainingTime);
    emit(EpisodePageState.content(state.episode, supplements));
  }
}
