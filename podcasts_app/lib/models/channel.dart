import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/source.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const Channel._();

  const factory Channel({
    @Default('') String name,
    @Default('') String image,
    @Default('') String id,
    @Default('') String description,
    @Default([]) List<Series> seriesList,
  }) = _Channel;

  static Channel fromJson(Map<String, dynamic> json,
          {List<Series> seriesList = const []}) =>
      Channel(
          name: json['name'],
          description: json['description'],
          image: json['thumbnailUrl'],
          id: json['id'],
          seriesList: seriesList);
}
