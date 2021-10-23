import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/series.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const factory Channel(
      {required String channelName,
      required String channelImage,
      required String channelDescription,
      required List<Series> channelSeriesList,
      required String channelOwner}) = _Channel;
}
