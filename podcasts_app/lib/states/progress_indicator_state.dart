import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';

part 'progress_indicator_state.freezed.dart';

@freezed
class ProgressIndicatorState with _$ProgressIndicatorState {
  const factory ProgressIndicatorState.active(ProgressIndicatorContent content) = _Active;
  const factory ProgressIndicatorState.inactive(ProgressIndicatorContent content) = _Inactive;
  const factory ProgressIndicatorState.loading(ProgressIndicatorContent content) = _Loading;
  const factory ProgressIndicatorState.failed(ProgressIndicatorContent content, AudioError error) = _Failed;
}
