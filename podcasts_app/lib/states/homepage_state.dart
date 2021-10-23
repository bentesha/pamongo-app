import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/supplements.dart';
import '../source.dart';

part 'homepage_state.freezed.dart';

@freezed
class HomepageState with _$HomepageState {
  const factory HomepageState.loading(List<Episode> episodeList, Supplements supplements) = _Loading;
  const factory HomepageState.failed(List<Episode> episodeList,Supplements supplements) = _Failed;
  const factory HomepageState.content(List<Episode> episodeList,Supplements supplements) = _Content;

  factory HomepageState.initial() =>  const HomepageState.content([], Supplements());
}
