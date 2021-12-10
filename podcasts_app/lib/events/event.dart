import 'package:hive/hive.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/models/device_info.dart';

abstract class Events {
  static final box = Hive.box(deviceInfoBox);

  final deviceInfo = box.get('device_info') as DeviceInfo;

  Map<String, dynamic> createEvent();
}