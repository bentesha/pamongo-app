import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/source.dart';
import 'package:http/http.dart' as http;

typedef ContentStream = Stream<ProgressIndicatorContent>;
typedef ContentStreamController = StreamController<ProgressIndicatorContent>;

class AudioPlayerService {
  final _player = AudioPlayer();

  ProgressIndicatorContent _content = const ProgressIndicatorContent();
  final _contentController = ContentStreamController.broadcast();
  final _indicatorController = StreamController<bool>.broadcast();

  ContentStream get onIndicatorContentStateChanged => _contentController.stream;
  ProgressIndicatorContent get getCurrentContent => _content;
  Stream<Duration?> get onAudioPositionChanged => _player.positionStream;
  int get getBufferedPosition => _player.bufferedPosition.inMilliseconds;

  //determines whether the bottom audio-progress-indicator is expanded or not
  bool _isIndicatorExpanded = false;
  bool get isIndicatorExpanded => _isIndicatorExpanded;
  Stream<bool> get isIndicatorExpandedStream => _indicatorController.stream;

  Future<void> play(List<Episode> episodeList, {int index = 0}) async {
    _updateContentWith(
        episodeList: episodeList,
        currentPosition: 0,
        playerState: loadingState,
        currentIndex: index);

    final episode = episodeList[index];

    try {
      final duration = await _player.setUrl(episode.audioUrl);
      if (duration != null) {
        episode.copyWith(duration: duration.inMilliseconds);
        episodeList[index] = episode;
        _updateContentWith(playerState: playingState, episodeList: episodeList);
        await _player.play();
      }
      //use this if the duration from api issue is fixed
      /* await _player.setUrl(episode.audioUrl);
      _updateContentWith(playerState: playingState);
      await _player.play(); */
    } catch (e) {
      log(e.toString());
      _updateContentWith(playerState: errorState);
    }
  }

  ///pauses if player is playing, plays if player is paused or failed to buffer.
  ///starts an episode again if it is completed
  Future<void> toggleStatus() async {
    final playerState = _content.playerState;
    final currentPosition = _content.currentPosition;
    final hasFailedToBuffer = playerState == errorState;
    final index = _content.currentIndex;

    if (playerState == loadingState) return;
    if (hasFailedToBuffer) {
      _handleSeekCallback(currentPosition, index);
      return;
    }
    if (playerState == completedState) {
      await play(_content.episodeList, index: index);
      return;
    }
    if (playerState == playingState) {
      _updateContentWith(
          playerState: pausedState, currentPosition: currentPosition);
      await _player.pause();
      return;
    }
    _updateContentWith(playerState: playingState);
    await _player.play();
  }

  Future<void> changePosition(double position,
      {bool positionRequiresUpdate = false, bool isForwarding = true}) async {
    final index = _content.currentIndex;
    final isLoading = _content.playerState == loadingState;

    if (isLoading) return;
    if (positionRequiresUpdate) {
      final currentPosition = _player.position.inMilliseconds;
      final updatedPosition = isForwarding
          ? currentPosition + position
          : currentPosition - position;

      _handleSeekCallback(updatedPosition.toInt(), index);
      return;
    }

    _handleSeekCallback(position.toInt(), index);
  }

  Future<void> stop() async {
    await _player.stop();
    _updateContentWith(playerState: inactiveState);
  }

  Future<void> seekNext() async {
    final isLoading = _content.playerState == loadingState;
    if (isLoading) return;
    int index = _content.currentIndex;
    final isLast = index == _content.episodeList.length - 1;
    index = isLast ? index : index + 1;
    play(_content.episodeList, index: index);
  }

  Future<void> seekPrev() async {
    final isLoading = _content.playerState == loadingState;
    if (isLoading) return;
    int index = _content.currentIndex;
    index = index == 0 ? 0 : index - 1;
    play(_content.episodeList, index: index);
  }

  void markAsCompleted() {
    final duration = _content.episodeList[_content.currentIndex].duration;
    _updateContentWith(playerState: completedState, currentPosition: duration);
  }

  void markAsFailedToBuffer() {
    final position = _player.position.inMilliseconds;
    _updateContentWith(currentPosition: position, playerState: errorState);
    _player.pause();
  }

  Future<void> _handleSeekCallback(int newPosition, int index) async {
    final duration = _content.episodeList[_content.currentIndex].duration;
    final correctedPosition = newPosition > duration
        ? duration
        : newPosition.isNegative
            ? 0
            : newPosition;
    _updateContentWith(
        currentPosition: correctedPosition, playerState: loadingState);

    final episode = _content.episodeList[index];

    try {
      if (_player.playing) _player.pause();
      await checkConnectivity();
      await _player.setUrl(episode.audioUrl);
      await _player.seek(Duration(milliseconds: newPosition));
      _updateContentWith(playerState: playingState);
      _player.play();
    } catch (_) {
      _updateContentWith(playerState: errorState);
      if (_player.playing) _player.pause();
    }
  }

  void changeIndicatorExpandedStatusTo(bool isExpanded) {
    _isIndicatorExpanded = isExpanded;
    _indicatorController.add(isExpanded);
  }

  Future<void> checkConnectivity() async {
    try {
      await http
          .get(Uri.parse('https://pub.dev/'))
          .timeout(const Duration(seconds: 3));
    } on TimeoutException catch (_) {
      throw AudioError.fromErrorCode(errorCode: 0);
    } on SocketException catch (_) {
      throw AudioError.fromErrorCode(errorCode: 0);
    }
  }

  void _updateContentWith(
      {IndicatorPlayerState? playerState,
      List<Episode>? episodeList,
      int? currentIndex,
      int? currentPosition}) {
    _content = _content.copyWith(
        playerState: playerState ?? _content.playerState,
        episodeList: episodeList ?? _content.episodeList,
        currentIndex: currentIndex ?? _content.currentIndex,
        currentPosition: currentPosition ?? _content.currentPosition);
    _contentController.add(_content);
  }
}
