import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/progress_indicator_state.dart';

class ProgressIndicatorBloc extends Cubit<ProgressIndicatorState> {
  final AudioPlayerService service;

  bool isExpanded = false;
  static final initialContent =
      ProgressIndicatorContent(episodeList: [Episode(date: DateTime.now())]);

  ProgressIndicatorBloc(this.service)
      : super(ProgressIndicatorState.initial(initialContent, true)) {
    service.onAudioPositionChanged.listen((position) {
      _handlePositionStream(position);
    });

    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  Future<void> togglePlayerStatus() async => await service.toggleStatus();

  void changePosition(double position,
          {bool positionRequiresUpdate = false, bool isForwarding = true}) =>
      service.changePosition(position,
          positionRequiresUpdate: positionRequiresUpdate,
          isForwarding: isForwarding);

  void skipToNext() async => await service.seekNext();

  void skipToPrev() async => await service.seekPrev();

  void share(String id) async => await service.share(ContentType.episode, id);

  void _handleContentStream(ProgressIndicatorContent content) {
    final hasFailedToBuffer = content.playerState == errorState;
    final isInactive = content.playerState == inactiveState;

    if (hasFailedToBuffer) {
      emit(ProgressIndicatorState.failed(content, state.isHiding,
          content.error ?? AudioError.fromType(ErrorType.unknown)));
      return;
    }

    if (isInactive) {
      emit(ProgressIndicatorState.initial(initialContent, true));
      return;
    }

    emit(ProgressIndicatorState.active(content, isExpanded));
  }

  void _handlePositionStream(Duration? position) {
    final content = state.content;
    final episode = content.episodeList[content.currentIndex];
    final duration = episode.duration;
    final playerState = content.playerState;
    final bufferedPosition = service.getBufferedPosition;

    final shouldUpdatePosition = position != null &&
        position != Duration.zero &&
        duration != 0 &&
        playerState != errorState &&
        playerState != loadingState &&
        playerState != completedState;

    if (shouldUpdatePosition) {
      final _position = position!.inMilliseconds >= duration
          ? duration
          : position.inMilliseconds;

      if (_position >= duration) {
        service.markAsCompleted();
        return;
      }

      if (_position >= bufferedPosition &&
          bufferedPosition < duration &&
          bufferedPosition != 0) {
        service.markAsFailedToBuffer();
        return;
      }

      emit(ProgressIndicatorState.active(
          state.content.copyWith(currentPosition: _position), state.isHiding));
    }
  }

  void toggleVisibilityStatus() {
    isExpanded = !isExpanded;
    emit(ProgressIndicatorState.active(state.content, !state.isHiding));
  }
}
