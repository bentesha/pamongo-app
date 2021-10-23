import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/supplements.dart';

part 'series_page_state.freezed.dart';

@freezed
class SeriesPageState with _$SeriesPageState {
  const factory SeriesPageState.loading(List<Episode> episodeList, Supplements supplements) = _Loading;
  const factory SeriesPageState.content(List<Episode> episodeList, Supplements supplements)= _Content;
  const factory SeriesPageState.failed(List<Episode> episodeList, Supplements supplements) = _Failed;

  factory SeriesPageState.initial() => const SeriesPageState.content([], Supplements());
}
