import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/errors/audio_error.dart';
import 'package:podcasts/models/episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/models/supplements.dart';
import 'package:podcasts/source.dart';
import 'package:http/http.dart' as http;

typedef ContentStream = Stream<ProgressIndicatorContent>;
typedef ContentStreamController = StreamController<ProgressIndicatorContent>;

class AudioPlayerService {
  final _player = AudioPlayer();

  static final initialEpisodeList = [Episode(date: DateTime.utc(2020))];
  var _content = ProgressIndicatorContent(episodeList: initialEpisodeList);
  final _contentController = ContentStreamController.broadcast();

  ContentStream get onIndicatorContentStateChanged => _contentController.stream;
  ProgressIndicatorContent get getCurrentContent => _content;
  Stream<Duration?> get onAudioPositionChanged => _player.positionStream;
  int get getBufferedPosition => _player.bufferedPosition.inMilliseconds;

  Future<void> play(List episodeList,
      {int index = 0, bool shoudlFormatIndex = true}) async {
    final lastIndex = episodeList.length - 1;
    final isLatestFirstSorted = _content.sortStyle == SortStyles.latestFirst;
    if (isLatestFirstSorted && shoudlFormatIndex) index = lastIndex - index;

    _updateContentWith(
        episodeList: episodeList,
        currentPosition: 0,
        playerState: loadingState,
        currentIndex: index);

    try {
      var episode = episodeList[index];
      final duration = await _player.setUrl(episode.audioUrl);
      if (duration != null) {
        episode = episode.copyWith(duration: duration.inMilliseconds);
        episodeList[index] = episode;
        _updateContentWith(playerState: playingState, episodeList: episodeList);
        await _player.play();
      }
    } catch (e) {
      log(e.toString());
      _updateContentWith(
          playerState: errorState,
          error: AudioError.fromType(ErrorType.failedToBuffer));
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

    var index = _content.currentIndex;
    final isLast = index == _content.episodeList.length - 1;
    index = isLast ? index : index + 1;
    await play(_content.episodeList, index: index, shoudlFormatIndex: false);
  }

  Future<void> seekPrev() async {
    var index = _content.currentIndex;
    final isIntro = _content.episodeList[index].episodeNumber == 0;
    if (isIntro) return;

    final isLoading = _content.playerState == loadingState;
    if (isLoading) return;

    final isLast = index == 1;
    index = isLast ? index : index - 1;
    await play(_content.episodeList, index: index, shoudlFormatIndex: false);
  }

  void markAsCompleted() {
    final duration = _content.episodeList[_content.currentIndex].duration;
    _updateContentWith(playerState: completedState, currentPosition: duration);
  }

  void markAsFailedToBuffer() {
    final position = _player.position.inMilliseconds;
    _updateContentWith(currentPosition: position, playerState: errorState);
    if (_player.playing) _player.pause();
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
      await _checkConnectivity();
      await _player.setUrl(episode.audioUrl);
      await _player.seek(Duration(milliseconds: newPosition));
      _updateContentWith(playerState: playingState);
      _player.play();
    } on AudioError catch (e) {
      log(e.toString());
      _updateContentWith(playerState: errorState, error: e);
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      await http
          .get(Uri.parse('https://pub.dev/'))
          .timeout(const Duration(seconds: 3));
    } on TimeoutException catch (_) {
      throw AudioError.fromType(ErrorType.internet);
    } on SocketException catch (_) {
      throw AudioError.fromType(ErrorType.internet);
    } catch (_) {
      throw AudioError.fromType(ErrorType.unknown);
    }
  }

  void updateContentSortStyle(SortStyles sortStyle) =>
      _content = _content.copyWith(sortStyle: sortStyle);

  void _updateContentWith(
      {IndicatorPlayerState? playerState,
      List? episodeList,
      int? currentIndex,
      AudioError? error,
      int? currentPosition}) {
    _content = _content.copyWith(
        playerState: playerState ?? _content.playerState,
        episodeList: episodeList ?? _content.episodeList,
        currentIndex: currentIndex ?? _content.currentIndex,
        currentPosition: currentPosition ?? _content.currentPosition,
        error: error);
    _contentController.add(_content);
  }
}
