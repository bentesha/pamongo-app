import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';

part 'explore_page_state.freezed.dart';

@freezed
class ExplorePageState with _$ExplorePageState {
  const factory ExplorePageState.loading(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      Supplements supplements) = _Loading;
  const factory ExplorePageState.content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      String searchKeyword,
      Supplements supplements) = _Content;
  const factory ExplorePageState.failed(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelList,
      Supplements supplements) = _Failed;

  factory ExplorePageState.initial() =>
      const ExplorePageState.content([], [], [], '', Supplements());
}
