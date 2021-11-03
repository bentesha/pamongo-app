import 'package:bloc/bloc.dart';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/repositories/podcasts_api.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/states/channel_page_state.dart';

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
      final channel = await PodcastsApi.getChannelById(channelId);
      emit(ChannelPageState.content(channel, supplements));
    } on ApiError catch (e) {
      supplements = supplements.copyWith(apiError: e);
      emit(ChannelPageState.failed(state.channel, supplements));
    }
  }

  bool shouldPop() {
    final isExpanded = service.isIndicatorExpanded;
    service.changeIndicatorExpandedStatusTo(false);
    return !isExpanded;
  }

  _handleContentStream(ProgressIndicatorContent content) {
    final supplements =
        state.supplements.copyWith(playerState: content.playerState);
    emit(ChannelPageState.content(state.channel, supplements));
  }
}
