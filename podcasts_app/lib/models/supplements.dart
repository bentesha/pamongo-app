import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';

part 'supplements.freezed.dart';

enum SortStyles { oldestFirst, latestFirst }

@freezed
class Supplements with _$Supplements {
  const factory Supplements(
      {@Default('') String activeId,
      @Default(SortStyles.oldestFirst) SortStyles sortStyle,
      ApiError? apiError,
      required IndicatorPlayerState playerState}) = _Supplements;
}
