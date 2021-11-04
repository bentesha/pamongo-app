import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';

part 'progress_indicator_state.freezed.dart';

@freezed
class ProgressIndicatorState with _$ProgressIndicatorState {
  const factory ProgressIndicatorState.active(ProgressIndicatorContent content, bool isHiding) = _Active;
  const factory ProgressIndicatorState.failed(ProgressIndicatorContent content, bool isHiding, AudioError error) = _Failed;

  factory ProgressIndicatorState.initial() => 
  ProgressIndicatorState.active(ProgressIndicatorContent(episodeList: [Episode(date: DateTime.now())]), true);
}
