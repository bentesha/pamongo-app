import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/supplements.dart';

part 'channel_page_state.freezed.dart';

@freezed
class ChannelPageState with _$ChannelPageState {
  const factory ChannelPageState.loading(List<Episode> episodeList, Supplements supplements) = _Loading;
  const factory ChannelPageState.content(List<Episode> episodeList, Supplements supplements)= _Content;
  const factory ChannelPageState.failed(List<Episode> episodeList, Supplements supplements) = _Failed;

  factory ChannelPageState.initial() => const ChannelPageState.content([], Supplements());
}
