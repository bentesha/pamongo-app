import 'package:hive/hive.dart';

part 'progress.g.dart';

@HiveType(typeId: 3)
class Progress extends HiveObject {
  @HiveField(0)
  final int position;

  @HiveField(1)
  final String id;

  Progress({
    required this.id,
    required this.position,
  });
}
