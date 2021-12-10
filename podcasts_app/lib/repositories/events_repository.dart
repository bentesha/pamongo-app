import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:podcasts/constants.dart';

class EventsRepository {
  ///returns the status code of the http response that signifies whether the
  ///operation was successful or not.
  static Future<int> postEvent(Map<String, dynamic> event) async {
    final body = json.encode(event);
    final response = await http.post(Uri.parse('${root}event'),
        body: body, headers: {'content-type': 'application/json'});
    return response.statusCode;
  }
}
