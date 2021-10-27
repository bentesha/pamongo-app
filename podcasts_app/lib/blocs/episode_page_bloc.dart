import 'package:bloc/bloc.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/episode_page_state.dart';

class EpisodePageBloc extends Cubit<EpisodePageState> {
  final AudioPlayerService service;

  EpisodePageBloc(this.service) : super(EpisodePageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  void init(Episode episode) {
    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final playerState = content.playerState;
    final supplements =
        state.supplements.copyWith(activeId: id, playerState: playerState);
    emit(EpisodePageState.content(episode, supplements));
  }

  void play() async => await service.play([state.episode]);

  bool shouldPop() {
    final isExpanded = service.isIndicatorExpanded;
    service.changeIndicatorExpandedStatusTo(false);
    return !isExpanded;
  }

  _handleContentStream(ProgressIndicatorContent content) async {
    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final playerState = content.playerState;
    final supplements =
        state.supplements.copyWith(activeId: id, playerState: playerState);
    emit(EpisodePageState.content(state.episode, supplements));
  }
}
