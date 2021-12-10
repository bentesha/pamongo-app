import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/events/episode_event.dart';
import 'package:podcasts/source.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';

typedef ContentStream = Stream<ProgressIndicatorContent>;
typedef ContentStreamController = StreamController<ProgressIndicatorContent>;
typedef InterruptionStream = Stream<AudioInterruptionEvent>;

enum ContentType { episode, series, channel }

class AudioPlayerService {
  static final player = AudioPlayer();
  static final box = Hive.box('saved_episodes');
  static final eventsBox = Hive.box('events');
  static const timeLimit = Duration(seconds: 10);
  static final defaultList = [Episode(date: DateTime.utc(2020))];
  static var content = ProgressIndicatorContent(episodeList: defaultList);
  static final contentController = ContentStreamController.broadcast();
  static var currentDuration = 0;

  AudioPlayerService(this.session);

  final AudioSession session;

  ContentStream get onIndicatorContentStateChanged => contentController.stream;
  ProgressIndicatorContent get getCurrentContent => content;
  Stream<Duration?> get onAudioPositionChanged => player.positionStream;
  int get getBufferedPosition => player.bufferedPosition.inMilliseconds;
  int get getRemainingTime => currentDuration - player.position.inMilliseconds;
  InterruptionStream get onInterruption => session.interruptionEventStream;
  Stream get onEarphoneDetached => session.becomingNoisyEventStream;

  Future<void> play(List<Episode> episodeList, {int index = 0}) async {
    var episode = episodeList[index];

    log(episodeList[index].title.toString());

    if (box.containsKey(episodeList[index].id)) {
      _addCurrentToBox();
      final savedEpisode = box.get(episode.id) as SavedEpisode;
      currentDuration = savedEpisode.duration;
      _updateContentWith(currentIndex: index, episodeList: episodeList);
      _handleSeekCallback(savedEpisode.position, index, false);
      return;
    }

    _addCurrentToBox();

    _updateContentWith(
      episodeList: episodeList,
      currentPosition: 0,
      playerState: loadingState,
      currentIndex: index,
    );

    try {
      final duration = await player.setUrl(episode.audioUrl).timeout(timeLimit);

      if (duration != null) {
        currentDuration = duration.inMilliseconds;
        episode = episode.copyWith(duration: currentDuration);
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
    final playerState = content.playerState;
    final currentPosition = content.currentPosition;
    final index = content.currentIndex;

    if (playerState.isInactive) return;
    if (playerState.isLoading) return;
    if (playerState.isCompleted) {
      await play(content.episodeList, index: index);
      return;
    }
    if (playerState.hasFailedToBuffer) {
      _handleSeekCallback(currentPosition, index, true);
      return;
    }
    if (playerState.isPlaying) {
      _addCurrentToBox();
      _updateContentWith(
          playerState: pausedState,
          currentPosition: player.position.inMilliseconds);
      await player.pause();
      return;
    }
    if (playerState.isPaused) {
      _updateContentWith(playerState: playingState);
      await player.play();
      return;
    }

    final id = content.episodeList[index].id;
    final savedEpisode = Hive.box('saved_episodes').get(id) as SavedEpisode?;
    if (savedEpisode != null) {
      _handleSeekCallback(savedEpisode.position, index, false);
    }
  }

  Future<void> changePosition(double position,
      {bool positionRequiresUpdate = false, bool isForwarding = true}) async {
    final index = content.currentIndex;

    if (content.playerState.isLoading) return;
    if (positionRequiresUpdate) {
      final currentPosition = player.position.inMilliseconds;
      final updatedPosition = isForwarding
          ? currentPosition + position
          : currentPosition - position;

      _handleSeekCallback(updatedPosition.toInt(), index, true);
      return;
    }

    _handleSeekCallback(position.toInt(), index, true);
  }

  Future<void> stop() async {
    await player.stop();
    _updateContentWith(playerState: inactiveState);
  }

  Future<void> seekNext() async {
    if (content.playerState.isLoading) return;

    var index = content.currentIndex;
    final isLast = index == content.episodeList.length - 1;
    index = isLast ? index : index + 1;
    await play(content.episodeList, index: index);
  }

  Future<void> seekPrev() async {
    var index = content.currentIndex;
    final isIntro = content.episodeList[index].episodeNumber == 0;

    if (isIntro) return;
    if (content.playerState.isLoading) return;

    final isLast = index == 1;
    index = isLast ? index : index - 1;
    await play(content.episodeList, index: index);
  }

  void markAsCompleted() {
    final episode = content.getCurrentEpisode;
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

  ///adds the current episode, that is not completed or paused to local storage
  void _addCurrentToBox() {
    final playerState = content.playerState;

    final episode = content.getCurrentEpisode;
    final id = episode.id;
    final duration = episode.duration;
    final position = player.position.inMilliseconds;

    if (!playerState.isCompleted && !playerState.isInactive) {
      box.put(
          id,
          SavedEpisode(
            position: position,
            duration: duration,
          ));
    }
  }

  Future<void> _handleSeekCallback(
      int newPosition, int index, bool isSeekingSameAudio) async {
    final duration = content.getCurrentEpisode.duration;
    final bufferedPosition = player.bufferedPosition.inMilliseconds;
    final currentPosition = player.position.inMilliseconds;
    final correctedPosition = newPosition > duration
        ? duration
        : newPosition.isNegative
            ? 0
            : newPosition;

    if (correctedPosition < bufferedPosition &&
        correctedPosition > currentPosition &&
        isSeekingSameAudio) {
      player.seek(Duration(milliseconds: correctedPosition));
      return;
    }

    _updateContentWith(
      currentPosition: correctedPosition,
      playerState: loadingState,
    );

    final episode = content.episodeList[index];

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

  void addProgressEventToBox(int position) {
    final episode = content.getCurrentEpisode;
    final id = episode.id;
    final event =
        ProgressEvent(position: position, episodeId: id).createEvent();
    eventsBox.add(event);
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
    if (content.playerState != playingState) {
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
      content = content.copyWith(sortStyle: sortStyle);

  void _updateContentWith(
      {IndicatorPlayerState? playerState,
      List<Episode>? episodeList,
      int? currentIndex,
      AudioError? error,
      int? currentPosition}) {
    content = content.copyWith(
        playerState: playerState ?? content.playerState,
        episodeList: episodeList ?? content.episodeList,
        currentIndex: currentIndex ?? content.currentIndex,
        currentPosition: currentPosition ?? content.currentPosition,
        error: error);
    contentController.add(content);
  }
}
