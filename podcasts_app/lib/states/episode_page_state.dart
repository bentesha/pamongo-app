import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/supplements.dart';

part 'episode_page_state.freezed.dart';

@freezed
class EpisodePageState with _$EpisodePageState {
  const factory EpisodePageState.loading(Episode episode, Supplements supplements) = _Loading;
  const factory EpisodePageState.content(Episode episode,Supplements supplements) = _Content;
  const factory EpisodePageState.failed(Episode episode,Supplements supplements) = _Failed;

  factory EpisodePageState.initial() => const EpisodePageState.content(Episode(), Supplements());
}
