import 'package:hive/hive.dart';
import 'package:podcasts/models/device_info.dart';
import 'package:podcasts/models/event.dart';

abstract class Events {
  static final box = Hive.box('device_info');

  final deviceInfo = box.get('device_info') as DeviceInfo;

  Event createEvent();
}