import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/supplements.dart';

part 'progress_indicator_content.freezed.dart';

enum IndicatorPlayerState {
  playing,
  paused,
  inactive,
  loading,
  completed,
  error
}

extension PlayerStateType on IndicatorPlayerState {
  bool get isCompleted => this == completedState;
  bool get isPaused => this == pausedState;
  bool get isLoading => this == loadingState;
  bool get isPlaying => this == playingState;
  bool get isInactive => this == inactiveState;
  bool get hasFailedToBuffer => this == errorState;
}

const loadingState = IndicatorPlayerState.loading;
const playingState = IndicatorPlayerState.playing;
const pausedState = IndicatorPlayerState.paused;
const completedState = IndicatorPlayerState.completed;
const inactiveState = IndicatorPlayerState.inactive;
const errorState = IndicatorPlayerState.error;

@freezed
abstract class ProgressIndicatorContent implements _$ProgressIndicatorContent {
  const ProgressIndicatorContent._();

  const factory ProgressIndicatorContent(
      {required List<Episode> episodeList,
      @Default(0) int currentPosition,
      @Default(0) int bufferedPosition,
      @Default(inactiveState) IndicatorPlayerState playerState,
      @Default(SortStyles.oldestFirst) SortStyles sortStyle,
      AudioError? error,
      @Default(0) int currentIndex}) = _ProgressIndicatorContent;

  Episode get getCurrentEpisode => episodeList[currentIndex];
}
