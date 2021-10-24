import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/series.dart';

part 'channel.freezed.dart';

@freezed
class Channel with _$Channel {
  const factory Channel(
      {@Default('') String channelName,
      @Default('') String channelImage,
      @Default('') String channelDescription,
      @Default([]) List<Series> channelSeriesList,
      @Default('') String channelOwner}) = _Channel;
}
