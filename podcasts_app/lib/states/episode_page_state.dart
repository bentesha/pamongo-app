import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/models_source.dart';

part 'episode_page_state.freezed.dart';

@freezed
class EpisodePageState with _$EpisodePageState {
  const factory EpisodePageState.loading(Episode episode, Supplements supplements) = _Loading;
  const factory EpisodePageState.content(Episode episode,Supplements supplements) = _Content;

  factory EpisodePageState.initial() =>  EpisodePageState.content(Episode(date: DateTime.utc(2020)), const Supplements(playerState: inactiveState));
}
