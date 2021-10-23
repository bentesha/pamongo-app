import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';

part 'series.freezed.dart';

@freezed
class Series with _$Series {
  const factory Series(
      {@Default('') String image,
      @Default('') String description,
      @Default('') String name,
      @Default('') String channel,
      @Default([]) List<Episode> episodeList}) = _Series;
}
