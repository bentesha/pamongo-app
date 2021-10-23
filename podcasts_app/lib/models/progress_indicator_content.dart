import 'package:freezed_annotation/freezed_annotation.dart';
import 'episode.dart';

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
      {@Default([Episode()]) List<Episode> episodeList,
      @Default(0) int currentPosition,
      @Default(inactiveState) IndicatorPlayerState playerState,
      @Default(0) int currentIndex}) = _ProgressIndicatorContent;
}
