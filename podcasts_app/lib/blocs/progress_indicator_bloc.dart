import 'package:audio_session/audio_session.dart';
import '../source.dart';

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

    service.onEarphoneDetached.listen((event) {
      service.toggleStatus();
    });

    service.onInterruption.listen((event) {
      _handleAudioInterruptions(event);
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
        playerState != loadingState;

    if (shouldUpdatePosition) {
      final _position = position!.inMilliseconds >= duration
          ? duration
          : position.inMilliseconds;

      //* below
      if (duration - _position <= 100) return service.markAsCompleted();

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

  _handleAudioInterruptions(AudioInterruptionEvent event) {
    if (event.begin) {
      switch (event.type) {
        case AudioInterruptionType.duck:
        case AudioInterruptionType.pause:
        case AudioInterruptionType.unknown:
          service.handleInterruptions(event.type, true);
          break;
      }
    } else {
      switch (event.type) {
        case AudioInterruptionType.duck:
        case AudioInterruptionType.pause:
          service.handleInterruptions(event.type, false);
          break;
        case AudioInterruptionType.unknown:
          break;
      }
    }
  }
}


//*
//should've been _position == duration, but this works correctly only when the
//episode has not been saved in the local storage, if it is, the way the 
//plugin position stream fires final position becomes greater than the 
//duration by few millisconds.
