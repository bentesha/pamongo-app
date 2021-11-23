import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';

part 'series.freezed.dart';

@freezed
class Series with _$Series {
  const Series._();

  const factory Series(
      {@Default('') String image,
      @Default('') String name,
      @Default('') String channelName,
      @Default('') String description,
      @Default(0) int totalNumberOfEpisodes,
      @Default('') String id,
      @Default('') String channelId,
      @Default([]) List<Episode> episodeList}) = _Series;

  static Series fromJson(Map<String, dynamic> json,
          {String channelName = '', List<Episode> episodeList = const []}) =>
      Series(
          image: json['thumbnailUrl'],
          name: json['name'],
          id: json['id'],
          channelId: json['channelId'],
          description: json['description'],
          totalNumberOfEpisodes: json['totalEpisodes'],
          channelName: channelName,
          episodeList: episodeList);
}
