import '../source.dart';

class ChannelPageBloc extends Cubit<ChannelPageState> {
  final AudioPlayerService service;
  ChannelPageBloc(this.service) : super(ChannelPageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  Future<void> init(String channelId) async {
    emit(ChannelPageState.loading(state.channel, state.supplements));
    final playerState = service.getCurrentContent.playerState;
    var supplements = state.supplements.copyWith(playerState: playerState);
    try {
      final channel = await PodcastsRepository.getChannelById(channelId);
      emit(ChannelPageState.content(channel, supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(ChannelPageState.failed(state.channel, supplements));
    }
  }

  void share(ContentType contentType, String id) async =>
      await service.share(contentType, id);

  _handleContentStream(ProgressIndicatorContent content) {
    final supplements =
        state.supplements.copyWith(playerState: content.playerState);
    emit(ChannelPageState.content(state.channel, supplements));
  }
}
