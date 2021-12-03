import 'package:hive/hive.dart';

part 'device_info.g.dart';

@HiveType(typeId: 2)
class DeviceInfo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String make;

  @HiveField(2)
  final String type;

  @HiveField(3)
  final String model;

  @HiveField(4)
  final String version;

  DeviceInfo({
    required this.id,
    required this.make,
    required this.type,
    required this.model,
    required this.version,
  });

   Map<String, dynamic> toJson(){
    return {
      'id': id,
      'make' : make,
      'type' : type,
      'model' : model,
      'version' : version,
    };
  }
}
