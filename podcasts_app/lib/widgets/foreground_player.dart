import 'package:audio_service/audio_service.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/services/audio_player_service.dart';

class ForegroundPlayer extends BaseAudioHandler with SeekHandler {
  final AudioPlayerService service;

  ForegroundPlayer(this.service) {
    service.onIndicatorContentStateChanged.listen((content) {
      _handleContentStateChanges(content);
    });
  }

  @override
  Future<void> play() => service.toggleStatus();

  @override
  Future<void> pause() => service.toggleStatus();

  @override
  Future<void> seek(Duration position) =>
      service.changePosition(position.inMilliseconds.toDouble());

  @override
  Future<void> rewind() => service.changePosition(10000,
      positionRequiresUpdate: true, isForwarding: false);

  @override
  Future<void> fastForward() =>
      service.changePosition(30000, positionRequiresUpdate: true);

  @override
  Future<void> skipToPrevious() => service.seekPrev();

  @override
  Future<void> skipToNext() => service.seekNext();

  @override
  Future<void> stop() => service.stop();

  final MediaControl _forward_30 = const MediaControl(
      label: 'Forward',
      androidIcon: 'drawable/forward_30',
      action: MediaAction.fastForward);

  final MediaControl _rewind_10 = const MediaControl(
      label: 'Rewind',
      androidIcon: 'drawable/replay_10',
      action: MediaAction.rewind);

  final MediaControl _pause = const MediaControl(
      label: 'Pause', androidIcon: 'drawable/pause', action: MediaAction.pause);

  final MediaControl _play = const MediaControl(
      label: 'Play', androidIcon: 'drawable/play', action: MediaAction.play);

  final MediaControl _prev = const MediaControl(
      label: 'Skip to Previous',
      androidIcon: 'drawable/prev',
      action: MediaAction.skipToPrevious);

  final MediaControl _next = const MediaControl(
      label: 'Skip to Next',
      androidIcon: 'drawable/next',
      action: MediaAction.skipToNext);

  void _handleContentStateChanges(ProgressIndicatorContent content) {
    final episode = content.episodeList[content.currentIndex];
    final playerState = content.playerState;
    final currentPosition = content.currentPosition;

    mediaItem.add(MediaItem(
      id: episode.audioUrl,
      album: episode.seriesName,
      title: episode.title,
      duration: Duration(milliseconds: episode.duration),
      artUri: Uri.parse(episode.image),
    ));

    final isPlayingSeries = content.episodeList.length > 1;
    playbackState
        .add(_playbackState(currentPosition, playerState, isPlayingSeries));
  }

  PlaybackState _playbackState(int currentPosition,
      IndicatorPlayerState playerState, bool isPlayingSeries) {
    final isPaused = playerState == pausedState;
    final isCompleted = playerState == completedState;
    final isLoading = playerState == loadingState;
    final isPlaying = playerState == playingState;
    final failedToBuffer = playerState == errorState;

    return PlaybackState(
      controls: isPlayingSeries
          ? [
              _prev,
              _rewind_10,
              isPaused || isCompleted || failedToBuffer ? _play : _pause,
              _forward_30,
              _next
            ]
          : [
              _rewind_10,
              isPaused || isCompleted || failedToBuffer ? _play : _pause,
              _forward_30
            ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices:
          isPlayingSeries ? const [0, 2, 4] : const [0, 1, 2],
      processingState: isLoading
          ? AudioProcessingState.buffering
          : AudioProcessingState.ready,
      playing: isPlaying,
      updatePosition: Duration(milliseconds: currentPosition),
      speed: 1.0,
      queueIndex: 0,
    );
  }
}
