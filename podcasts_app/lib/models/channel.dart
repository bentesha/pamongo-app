import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const Channel._();

  const factory Channel(
      {@Default('') String name,
      @Default('') String image,
      @Default('') String id,
      @Default('') String description,
      @Default([]) List seriesList,
      @Default('') String owner}) = _Channel;

  static Channel fromJson(Map<String, dynamic> json,
          {List seriesList = const []}) =>
      Channel(
          name: json['name'],
          description: json['description'],
          image: json['thumbnailUrl'],
          id: json['id'],
          owner: 'James Calvin',
          seriesList: seriesList);
}
