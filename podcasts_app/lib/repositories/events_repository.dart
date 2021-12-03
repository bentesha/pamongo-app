import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:podcasts/constants.dart';

class EventRepository {
  static void postEvent() async {
    try {
      await http.post(Uri.parse('${root}event/'));
    } on SocketException catch (_) {
    } catch (_) {}
  }
}
