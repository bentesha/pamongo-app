import 'package:hive/hive.dart';

abstract class Event {
  static final box = Hive.box('device_info');

  final deviceInfo = box.get('device_info').toJson();

  Map<String, dynamic> createEvent();
}
