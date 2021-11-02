import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const Channel._();

  const factory Channel(
      {@Default('') String channelName,
      @Default('') String channelImage,
      @Default('') String channelDescription,
      @Default([]) List channelSeriesList,
      @Default('') String channelOwner}) = _Channel;

  static Channel fromJson(Map<String, dynamic> json,
          {List seriesList = const []}) =>
      Channel(
          channelName: json['name'],
          channelDescription: json['description'],
          channelImage: json['thumbnailUrl'],
          channelOwner: 'James Calvin',
          channelSeriesList: seriesList);
}
