import 'package:hive/hive.dart';

part 'saved_episodes.g.dart';

@HiveType(typeId: 1)
class SavedEpisode extends HiveObject {
  @HiveField(0)
  final int position;

  @HiveField(1)
  final int duration;

  SavedEpisode({
    required this.position,
    required this.duration,
  });
}
