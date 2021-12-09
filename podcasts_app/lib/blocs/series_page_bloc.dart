import '../source.dart';

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
      var series = await PodcastsRepository.getSeriesById(seriesId);
      var episodeList = series.episodeList;
      episodeList.sort((a, b) => a.episodeNumber.compareTo(b.episodeNumber));

      final isLastFirstSorting = sortStyle == SortStyles.latestFirst;
      if (isLastFirstSorting) episodeList = episodeList.reversed.toList();
      series = series.copyWith(episodeList: episodeList);
      emit(SeriesPageState.content(series, supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(SeriesPageState.failed(state.series, supplements));
    }
  }

  Future<void> play(int index) async {
    var episodeList = state.series.episodeList;
    final isReversed = state.supplements.sortStyle == SortStyles.latestFirst;
    if (isReversed) {
      episodeList = episodeList.reversed.toList();
      index = episodeList.length - index - 1;
    }
    await service.play(episodeList, index: index);
  }

  void togglePlayerStatus() async => await service.toggleStatus();

  void markAsPlayed(String id) => service.removeFromBox(id);

  void share(ContentType contentType, String id) async =>
      await service.share(contentType, id);

  void sort(int sortIndex) {
    var series = state.series;
    var supplements = state.supplements;
    emit(SeriesPageState.loading(series, supplements));

    final episodeList = series.episodeList;
    final sortStyle = supplements.sortStyle;
    final isOldestFirstSorted = sortIndex == 2;

    if (isOldestFirstSorted) {
      if (sortStyle == SortStyles.latestFirst) {
        final normalList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.oldestFirst);
        service.updateContentSortStyle(SortStyles.oldestFirst);
        series = series.copyWith(episodeList: normalList);
        emit(SeriesPageState.content(series, supplements));
        return;
      }
    } else {
      if (sortStyle == SortStyles.oldestFirst) {
        final reversedList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.latestFirst);
        service.updateContentSortStyle(SortStyles.latestFirst);
        series = series.copyWith(episodeList: reversedList);
        emit(SeriesPageState.content(series, supplements));
        return;
      }
    }

    emit(SeriesPageState.content(series, supplements));
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final id = content.getCurrentEpisode.id;
    emit(SeriesPageState.loading(state.series, state.supplements));

    final supplements = state.supplements
        .copyWith(activeId: id, playerState: content.playerState);
    emit(SeriesPageState.content(state.series, supplements));
  }
}
