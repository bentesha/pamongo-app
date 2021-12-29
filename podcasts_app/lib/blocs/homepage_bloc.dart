import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:hive/hive.dart';
import 'package:podcasts/models/device_info.dart';
import '../constants.dart';
import '../source.dart';

class HomepageBloc extends Cubit<HomepageState> {
  final AudioPlayerService service;

  HomepageBloc(this.service) : super(HomepageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  void init() async {
    emit(HomepageState.loading(
        state.episodeList, state.seriesList, state.supplements));
    await _storeDeviceInfo();
    try {
      final recent = await PodcastsRepository.getFeaturedEpisodes();
      final featured = await PodcastsRepository.getFeaturedSeries();
      emit(HomepageState.content(recent, featured, state.supplements));
    } on ApiError catch (e) {
      final supplements = state.supplements.copyWith(apiError: e);
      emit(HomepageState.failed(
          state.episodeList, state.seriesList, supplements));
    }
  }

  void play(Episode episode) async => await service.play([episode]);

  void togglePlayerStatus() async => await service.toggleStatus();

  void markAsPlayed(String id) => service.removeFromBox(id);

  void share(String id) => service.share(ContentType.episode, id);

  Future<void> refresh() async {
    emit(HomepageState.loading(
        state.episodeList, state.seriesList, state.supplements));
    await Future.delayed(const Duration(seconds: 3)).then((_) => init());
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final episodeList = state.episodeList;
    final id = content.getCurrentEpisode.id;
    final playerState = content.playerState;
    emit(HomepageState.loading(
        episodeList, state.seriesList, state.supplements));

    final supplements =
        state.supplements.copyWith(playerState: playerState, activeId: id);
    emit(HomepageState.content(episodeList, state.seriesList, supplements));
  }

  Future<void> _storeDeviceInfo() async {
    final box = Hive.box(kDeviceInfoBox);

    if (box.isNotEmpty) return;

    final plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      await box.put(
          kDeviceInfo,
          DeviceInfo(
              id: info.id,
              make: info.manufacturer,
              type: 'android',
              model: info.model,
              version: info.version.release));
    }
  }
}
