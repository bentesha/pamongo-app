import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
class Episode with _$Episode {
  const factory Episode(
      {@Default('') String image,
      @Default('') String seriesName,
      @Default('') String channel,
      @Default('') String date,
      @Default(0) int duration,
      @Default(-1) int id,
      @Default(0) int episodeNumber,
      @Default('') String title,
      @Default('') String audioUrl,
      @Default('') String description}) = _Episode;
}
