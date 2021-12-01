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

const loadingState = IndicatorPlayerState.loading;
const playingState = IndicatorPlayerState.playing;
const pausedState = IndicatorPlayerState.paused;
const completedState = IndicatorPlayerState.completed;
const inactiveState = IndicatorPlayerState.inactive;
const errorState = IndicatorPlayerState.error;

@freezed
class ProgressIndicatorContent with _$ProgressIndicatorContent {
  const factory ProgressIndicatorContent(
      {required List<Episode> episodeList,
      @Default(0) int currentPosition,
      @Default(0) int bufferedPosition,
      @Default(inactiveState) IndicatorPlayerState playerState,
      @Default(SortStyles.oldestFirst) SortStyles sortStyle,
      AudioError? error,
      @Default(0) int currentIndex}) = _ProgressIndicatorContent;
}
