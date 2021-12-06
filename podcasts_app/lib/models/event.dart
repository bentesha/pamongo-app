import 'package:hive/hive.dart';
import 'package:podcasts/models/device_info.dart';

part 'event.g.dart';

@HiveType(typeId: 3)
class Event extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DeviceInfo device;

  @HiveField(3)
  final int timestamp;

  @HiveField(4)
  final Map<String, dynamic> data;

  Event({
    required this.id,
    required this.name,
    required this.device,
    required this.timestamp,
    required this.data,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'device': device.toJson(),
      'timestamp': timestamp,
      'data': data,
    };
  }
}
