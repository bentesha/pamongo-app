import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/utils/utils.dart';
import '../source.dart';

part 'episode.freezed.dart';

@freezed
abstract class Episode implements _$Episode {
  const Episode._();

  const factory Episode(
      {@Default('') String image,
      @Default('') String seriesName,
      @Default(0) int duration,
      required DateTime date,
      @Default('') String id,
      @Default('') String seriesId,
      int? position,
      @Default(0) int episodeNumber,
      @Default('') String title,
      @Default('') String audioUrl,
      @Default('') String description}) = _Episode;

  String get getDuration => Utils.convertFrom(duration);
  String get getDate => Utils.formatDateBy(date, 'yMMMd');

  static Episode fromJson(Map<String, dynamic> json,
      {String seriesImage = '', String seriesName = '', String seriesId = ''}) {
    // final hasPosition = json['info'] != null;

    return Episode(
        image: seriesImage,
        seriesName: seriesName,
        duration: json['duration'],
        date: Utils.convertFromTimestamp(json['createdAt']),
        id: json['id'],
        seriesId: seriesId,
        position: /* hasPosition ? json['info']['position'] : */ null,
        episodeNumber: json['sequence'],
        title: json['name'],
        audioUrl: json['fileUrl'],
        description: json['description']);
  }
}
