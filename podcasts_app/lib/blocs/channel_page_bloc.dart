import 'package:bloc/bloc.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/states/channel_page_state.dart';

class ChannelPageBloc extends Cubit<ChannelPageState> {
  final AudioPlayerService service;
  ChannelPageBloc(this.service) : super(ChannelPageState.initial()) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStream(content);
    });
  }

  void init() {
    final playerState = service.getCurrentContent.playerState;
    final supplements = state.supplements.copyWith(playerState: playerState);
    emit(ChannelPageState.content(defaultChannel, supplements));
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
