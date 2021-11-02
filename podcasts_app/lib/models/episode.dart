import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/utils/utils.dart';

part 'episode.freezed.dart';

@freezed
class Episode with _$Episode {
  const Episode._();

  const factory Episode(
      {@Default('') String image,
      @Default('') String seriesName,
      @Default(0) int duration,
      required DateTime date,
      @Default('') String id,
      @Default('') String seriesId,
      @Default(0) int episodeNumber,
      @Default('') String title,
      @Default('') String audioUrl,
      @Default('') String description}) = _Episode;

  static Episode fromJson(Map<String, dynamic> json,
          {String seriesImage = '',
          String seriesName = '',
          String seriesId = ''}) =>
      Episode(
          image: seriesImage,
          seriesName: seriesName,
          duration: json['duration'] * 60000,
          date: Utils.convertFromTimestamp(json['createdAt']),
          id: json['id'],
          seriesId: seriesId,
          episodeNumber: json['sequence'],
          title: json['name'],
          audioUrl: json['fileUrl'],
          description: json['description']);
}
