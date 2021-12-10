import 'package:hive/hive.dart';
import 'package:podcasts/utils/utils.dart';

part 'saved_episode.g.dart';

@HiveType(typeId: 1)
class SavedEpisode extends HiveObject {
  @HiveField(0)
  final int position;

  @HiveField(1)
  final int duration;

  int get timeLeft => duration - position;
  double get fractionPlayed => position / duration;
  String get getTimeLeft => Utils.convertFrom(timeLeft);

  factory SavedEpisode.empty() => SavedEpisode(position: 0, duration: 0);

  SavedEpisode({
    required this.position,
    required this.duration,
  });
}
