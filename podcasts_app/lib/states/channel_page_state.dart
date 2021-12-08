import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';

part 'channel_page_state.freezed.dart';

@freezed
class ChannelPageState with _$ChannelPageState {
  const factory ChannelPageState.loading(
      Channel channel, Supplements supplements) = _Loading;
  const factory ChannelPageState.content(
      Channel channel, Supplements supplements) = _Content;
  const factory ChannelPageState.failed(
      Channel channel, Supplements supplements) = _Failed;

  factory ChannelPageState.initial() => const ChannelPageState.content(
      Channel(), Supplements(playerState: inactiveState));
}
