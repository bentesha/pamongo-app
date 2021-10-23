import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';

part 'supplements.freezed.dart';

enum SortStyles { firstToLast, lastToFirst}

@freezed
class Supplements with _$Supplements {
  const factory Supplements(
      {@Default(-1) int activeId,
      @Default(SortStyles.firstToLast) SortStyles sortStyle,
      AudioError? error,
      @Default(inactiveState) playerState}) = _Supplements;
}
