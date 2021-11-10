import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';

part 'search_page_state.freezed.dart';

@freezed
class SearchPageState with _$SearchPageState {
  const factory SearchPageState.content(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) = _Content;
  const factory SearchPageState.loading(
      List<Episode> episodesList,
      List<Series> seriesList,
      List<Channel> channelsList,
      String searchKeyword,
      Supplements supplements) = _Loading;

  factory SearchPageState.initial() =>
      const SearchPageState.content([], [], [], '', Supplements());
}
