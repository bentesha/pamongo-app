import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:podcasts/constants.dart';
import 'package:podcasts/models/event.dart';

class EventsRepository {
  ///returns the status code of the http response that signifies whether the
  ///operation was successful or not.
  static Future<int> postEvent(Event event) async {
    final body = event.toJson();
    final encoded = json.encode(body);
    final response = await http.post(Uri.parse('${root}event'),
        body: encoded, headers: {'content-type': 'application/json'});
    return response.statusCode;
  }
}
