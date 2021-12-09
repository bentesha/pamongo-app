import '../source.dart';

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
    final id = content.getCurrentEpisode.id;
    final playerState = content.playerState;

    episode = episode ?? await PodcastsRepository.getEpisodeById(episodeId);

    final supplements =
        state.supplements.copyWith(activeId: id, playerState: playerState);
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

    final supplements =
        state.supplements.copyWith(activeId: id, playerState: playerState);
    emit(EpisodePageState.content(state.episode, supplements));
  }
}
