import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/progress_indicator_state.dart';
import 'package:audio_session/audio_session.dart';

class ProgressIndicatorBloc extends Cubit<ProgressIndicatorState> {
  final AudioPlayerService service;

  static const inactiveContent = ProgressIndicatorContent();

  ProgressIndicatorBloc(this.service)
      : super(const ProgressIndicatorState.inactive(inactiveContent)) {
    service.onAudioPositionChanged.listen((position) {
      _handlePositionStream(position);
    });

    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });

    service.onInterruption.listen((event) {
      log('INTERRUPTION!!!!!!!!!!!!!!');
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            // Another app started playing audio and we should duck.
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            // Another app started playing audio and we should pause.
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            // The interruption ended and we should unduck.
            break;
          case AudioInterruptionType.pause:
          // The interruption ended and we should resume.
          case AudioInterruptionType.unknown:
            // The interruption ended but we should not resume.
            break;
        }
      }
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

  void _handleContentStream(ProgressIndicatorContent content) {
    final hasFailedToBuffer = content.playerState == errorState;
    final bufferError = AudioError.fromType(ErrorType.failedToBuffer);

    if (hasFailedToBuffer) {
      emit(ProgressIndicatorState.failed(content, bufferError));
      return;
    }

    emit(ProgressIndicatorState.active(content));
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
          state.content.copyWith(currentPosition: _position)));
    }
  }
}
