import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/source.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

typedef ContentStream = Stream<ProgressIndicatorContent>;
typedef ContentStreamController = StreamController<ProgressIndicatorContent>;

enum ContentType { episode, series, channel }
class AudioPlayerService {
  static final player = AudioPlayer();
  static final box = Hive.box('played_episodes');
  static const timeLimit = Duration(seconds: 10);
  static final initialEpisodeList = [Episode(date: DateTime.utc(2020))];
  var _content = ProgressIndicatorContent(episodeList: initialEpisodeList);
  static final contentController = ContentStreamController.broadcast();
  var _duration = 0;

  ContentStream get onIndicatorContentStateChanged => contentController.stream;
  ProgressIndicatorContent get getCurrentContent => _content;
  Stream<Duration?> get onAudioPositionChanged => player.positionStream;
  int get getBufferedPosition => player.bufferedPosition.inMilliseconds;
  int get getRemainingTime => _duration - player.position.inMilliseconds;

  Future<void> play(List<Episode> episodeList,
      {int index = 0, bool shoudlFormatIndex = true}) async {
    _addCurrentToBox();

    final lastIndex = episodeList.length - 1;
    final isLatestFirstSorted = _content.sortStyle == SortStyles.latestFirst;
    if (isLatestFirstSorted && shoudlFormatIndex) index = lastIndex - index;
    var episode = episodeList[index];
    final previousId = _content.episodeList[_content.currentIndex].id;

    if (box.containsKey(episodeList[index].id) && previousId != episode.id) {
      final savedEpisode = box.get(episode.id) as SavedEpisode;
      _duration = savedEpisode.duration;
      _updateContentWith(currentIndex: index, episodeList: episodeList);
      _handleSeekCallback(savedEpisode.position, index);
      return;
    }

    _updateContentWith(
      episodeList: episodeList,
      currentPosition: 0,
      playerState: loadingState,
      currentIndex: index,
    );

    try {
      final duration = await player.setUrl(episode.audioUrl).timeout(timeLimit);

      if (duration != null) {
        _duration = duration.inMilliseconds;
        episode = episode.copyWith(duration: duration.inMilliseconds);
        episodeList[index] = episode;
        _updateContentWith(playerState: playingState, episodeList: episodeList);
        await player.play();
      }
    } on TimeoutException catch (_) {
      _handleTimeoutException();
    } catch (e) {
      _handleAudioError(AudioError.fromType(ErrorType.failedToBuffer));
    }
  }

  /// pauses if player is playing, plays if player is paused or failed to buffer.
  /// starts an episode again if it is completed
  Future<void> toggleStatus() async {
    final playerState = _content.playerState;
    final currentPosition = _content.currentPosition;
    final hasFailedToBuffer = playerState == errorState;
    final index = _content.currentIndex;
    final isCompleted = playerState == completedState;
    final isPlaying = playerState == playingState;
    final isLoading = playerState == loadingState;
    final isPaused = playerState == pausedState;

    if (isLoading) return;
    if (hasFailedToBuffer) return _handleSeekCallback(currentPosition, index);
    if (isCompleted) return await play(_content.episodeList, index: index);
    if (isPlaying) {
      _updateContentWith(
          playerState: pausedState, currentPosition: currentPosition);
      await player.pause();
      return;
    }
    if (isPaused) {
      _updateContentWith(playerState: playingState);
      await player.play();
      return;
    }

    final id = _content.episodeList[index].id;
    final savedEpisode = Hive.box('played_episodes').get(id) as SavedEpisode?;
    if (savedEpisode != null) {
      log(savedEpisode.position.toString());
      _handleSeekCallback(savedEpisode.position, index);
    }
  }

  Future<void> changePosition(double position,
      {bool positionRequiresUpdate = false, bool isForwarding = true}) async {
    final index = _content.currentIndex;
    final isLoading = _content.playerState == loadingState;

    if (isLoading) return;
    if (positionRequiresUpdate) {
      final currentPosition = player.position.inMilliseconds;
      final updatedPosition = isForwarding
          ? currentPosition + position
          : currentPosition - position;

      _handleSeekCallback(updatedPosition.toInt(), index);
      return;
    }

    _handleSeekCallback(position.toInt(), index);
  }

  Future<void> stop() async {
    await player.stop();
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
    final episode = _content.episodeList[_content.currentIndex];
    final duration = episode.duration;
    final id = episode.id;
    if (box.containsKey(id)) box.delete(id);
    _updateContentWith(playerState: completedState, currentPosition: duration);
  }

  void markAsFailedToBuffer() {
    final position = player.position.inMilliseconds;
    _updateContentWith(currentPosition: position, playerState: errorState);
    if (player.playing) player.pause();
  }

  Future<void> _handleSeekCallback(int newPosition, int index) async {
    final duration = _content.episodeList[_content.currentIndex].duration;
    final correctedPosition = newPosition > duration
        ? duration
        : newPosition.isNegative
            ? 0
            : newPosition;

    _updateContentWith(
      currentPosition: correctedPosition,
      playerState: loadingState,
    );

    final episode = _content.episodeList[index];
    try {
      if (player.playing) player.pause();
      await _checkConnectivity();
      await player.setUrl(episode.audioUrl).timeout(timeLimit);
      await player.seek(Duration(milliseconds: newPosition)).timeout(timeLimit);
      _updateContentWith(playerState: playingState);
      player.play();
    } on AudioError catch (e) {
      _handleAudioError(e);
    } on TimeoutException catch (_) {
      _handleTimeoutException();
    }
  }

  ///adds the current episode, that is not completed to local storage
  void _addCurrentToBox() {
    final playerState = _content.playerState;
    final shouldSaveToBox =
        playerState != completedState && playerState != inactiveState;
    final episode = _content.episodeList[_content.currentIndex];
    final id = episode.id;
    final duration = episode.duration;

    if (shouldSaveToBox) {
      box.put(
          id,
          SavedEpisode(
            position: player.position.inMilliseconds,
            duration: duration,
          ));
    }
  }

  void removeFromBox(String id) {
    box.delete(id);
    _updateContentWith();
  }

  Future<void> share(ContentType contentType, String id) async {
    var text = '';
    switch (contentType) {
      case ContentType.episode:
        text = '${sharingHost}episode/$id';
        break;
      case ContentType.series:
        text = '${sharingHost}series/$id';
        break;
      case ContentType.channel:
        text = '${sharingHost}channel/$id';
        break;
      default:
    }
    await Share.share(text);
  }

  _handleAudioError(AudioError error) {
    log(error.toString());
    _updateContentWith(playerState: errorState, error: error);
  }

  _handleTimeoutException() {
    final e = AudioError.fromType(ErrorType.timeout);
    if (_content.playerState != playingState) {
      return _updateContentWith(playerState: errorState, error: e);
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      await http.get(Uri.parse('https://pub.dev/')).timeout(timeLimit);
    } on TimeoutException catch (_) {
      throw AudioError.fromType(ErrorType.timeout);
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
      List<Episode>? episodeList,
      int? currentIndex,
      AudioError? error,
      int? currentPosition}) {
    _content = _content.copyWith(
        playerState: playerState ?? _content.playerState,
        episodeList: episodeList ?? _content.episodeList,
        currentIndex: currentIndex ?? _content.currentIndex,
        currentPosition: currentPosition ?? _content.currentPosition,
        error: error);
    contentController.add(_content);
  }
}
