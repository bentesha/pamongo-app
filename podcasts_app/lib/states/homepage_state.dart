import 'package:freezed_annotation/freezed_annotation.dart';
import '../source.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.loading(List<Episode> episodeList,
      List<Series> seriesList, Supplements supplements) = _Loading;
  const factory HomepageState.failed(List<Episode> episodeList,
      List<Series> seriesList, Supplements supplements) = _Failed;
  const factory HomepageState.content(List<Episode> episodeList,
      List<Series> seriesList, Supplements supplements) = _Content;

  factory HomepageState.initial() =>
      const HomepageState.content([], [], Supplements(playerState: inactiveState));
}
