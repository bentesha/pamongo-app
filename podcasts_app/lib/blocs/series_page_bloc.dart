import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/repositories/podcasts_api.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';

class SeriesPageBloc extends Cubit<SeriesPageState> {
  final AudioPlayerService service;

  SeriesPageBloc(this.service) : super(SeriesPageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  Future<void> init(String seriesId) async {
    emit(SeriesPageState.loading(state.series, state.supplements));
    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final sortStyle = content.sortStyle;
    var supplements = state.supplements.copyWith(
        activeId: id, playerState: content.playerState, sortStyle: sortStyle);

    try {
      var series = await PodcastsApi.getSeriesById(seriesId);
      var episodeList = series.episodeList;
      episodeList.sort((a, b) => a.episodeNumber.compareTo(b.episodeNumber));

      final isLastToFirstSorting = sortStyle == SortStyles.lastToFirst;
      if (isLastToFirstSorting) episodeList = episodeList.reversed.toList();
      series = series.copyWith(episodeList: episodeList);
      emit(SeriesPageState.content(series, supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(SeriesPageState.failed(state.series, supplements));
    }
  }

  Future<void> play(int index) async {
    final episodeList = state.series.episodeList;
    await service.play(episodeList, index: index);
  }

  Future<void> playIntro() async {
    final sortStyle = state.supplements.sortStyle;
    final isSortingFromFirstToLast = sortStyle == SortStyles.firstToLast;
    final index =
        isSortingFromFirstToLast ? 0 : state.series.episodeList.length - 1;
    await play(index);
  }

  void sort(int sortIndex) {
    var series = state.series;
    final episodeList = series.episodeList;
    var supplements = state.supplements;
    emit(SeriesPageState.loading(series, supplements));

    final isByFirstToLast = sortIndex == 2;
    final sortStyle = supplements.sortStyle;

    if (isByFirstToLast) {
      if (sortStyle == SortStyles.lastToFirst) {
        final normalList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.firstToLast);
        series = series.copyWith(episodeList: normalList);
        service.updateContentSortStyle(SortStyles.firstToLast);
        emit(SeriesPageState.content(series, supplements));
        return;
      }
    } else {
      if (sortStyle == SortStyles.firstToLast) {
        final reversedList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.lastToFirst);
        series = series.copyWith(episodeList: reversedList);
        service.updateContentSortStyle(SortStyles.lastToFirst);
        emit(SeriesPageState.content(series, supplements));
        return;
      }
    }

    emit(SeriesPageState.content(series, supplements));
  }

  bool shouldPop() {
    final isExpanded = service.isIndicatorExpanded;
    service.changeIndicatorExpandedStatusTo(false);
    return !isExpanded;
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final id = content.episodeList[content.currentIndex].id;
    final supplements = state.supplements
        .copyWith(activeId: id, playerState: content.playerState);
    emit(SeriesPageState.content(state.series, supplements));
  }
}
