import 'package:bloc/bloc.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/series.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/series_page_state.dart';

class SeriesPageBloc extends Cubit<SeriesPageState> {
  final AudioPlayerService service;

  SeriesPageBloc(this.service) : super(SeriesPageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

   init(Series series) {
    final content = service.getCurrentContent;
    final id = content.episodeList[content.currentIndex].id;
    final supplements = state.supplements
        .copyWith(activeId: id, playerState: content.playerState);
    emit(SeriesPageState.content(series.episodeList, supplements));
  }

  void play(int index) async {
    final episodeList = state.episodeList;
    await service.play(episodeList, index: index);
  }

  void sort(int sortValue) async {
    final episodeList = state.episodeList;
    var supplements = state.supplements;
    emit(SeriesPageState.loading(episodeList, supplements));

    final isByFirstToLast = sortValue == 2;
    final sortStyle = supplements.sortStyle;

    if (isByFirstToLast) {
      if (sortStyle == SortStyles.lastToFirst) {
        final normaList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.firstToLast);
        emit(SeriesPageState.content(normaList, supplements));
        return;
      }
    } else {
      if (sortStyle == SortStyles.firstToLast) {
        final reversedList = episodeList.reversed.toList();
        supplements = supplements.copyWith(sortStyle: SortStyles.lastToFirst);
        emit(SeriesPageState.content(reversedList, supplements));
        return;
      }
    }

    emit(SeriesPageState.content(episodeList, supplements));
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
    emit(SeriesPageState.content(state.episodeList, supplements));
  }
}
