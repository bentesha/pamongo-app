import 'package:podcasts/events/event.dart';
import 'package:uuid/uuid.dart';

abstract class EpisodeEvent extends Event {
  final int position;
  final String episodeId;
  final String eventName;

  EpisodeEvent(this.eventName, this.episodeId, this.position);

  final uuid = const Uuid();

  @override
  createEvent() {
    return {
      'id': uuid.v4(),
      'type': eventName,
      'device': super.deviceInfo,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': {'episodeId': episodeId, 'position': position},
    };
  }
}

class PlayEvent extends EpisodeEvent {
  PlayEvent({required int position, required String episodeId})
      : super('play', episodeId, position);
}

class StopEvent extends EpisodeEvent {
  StopEvent({required int position, required String episodeId})
      : super('stop', episodeId, position);
}

class ProgressEvent extends EpisodeEvent {
  ProgressEvent({required int position, required String episodeId})
      : super('progress', episodeId, position);
}
