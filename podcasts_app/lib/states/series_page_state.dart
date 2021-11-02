import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';

part 'series_page_state.freezed.dart';

@freezed
class SeriesPageState with _$SeriesPageState {
  const factory SeriesPageState.loading(Series series, Supplements supplements) = _Loading;
  const factory SeriesPageState.content(Series series, Supplements supplements)= _Content;
  const factory SeriesPageState.failed(Series series, Supplements supplements) = _Failed;

  factory SeriesPageState.initial() => const SeriesPageState.content(Series(), Supplements());
}
