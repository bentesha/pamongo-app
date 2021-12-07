import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:podcasts/models/saved_episode.dart';
import 'package:podcasts/models/progress_indicator_content.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/screen_size_config.dart';
import 'package:intl/intl.dart';

extension SizeExtension on num {
  // ignore: unused_element
  int get w => ScreenSizeConfig.getIntWidth(this);
  int get h => ScreenSizeConfig.getIntHeight(this);
  double get dw => ScreenSizeConfig.getDoubleWidth(this);
  double get dh => ScreenSizeConfig.getDoubleHeight(this);
}

class Utils {
  static IndicatorPlayerState getStatus(
      String episodeId, String activeId, IndicatorPlayerState playerState) {
    if (activeId == episodeId) {
      return playerState;
    }
    return inactiveState;
  }

  static SavedEpisode? getPlayedStatus(String id) {
    final box = Hive.box('played_episodes');
    return box.get(id);
  }

  static DateTime convertFromTimestamp(String timestamp) {
    final date = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(timestamp);
    return date;
  }

  static String formatDateBy(DateTime date, String format) =>
      DateFormat(format).format(date);

  static String getRandomString() {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(15, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  ///returns true if the device is connected to internet
  static Future<bool> checkConnectivity() async {
    const timeLimit = Duration(minutes: 1);
    final response =
        await http.get(Uri.parse('https://pub.dev/')).timeout(timeLimit);
    return response.statusCode == 200;
  }

  ///converts a millisecond to time in hour-minute-seconds format
  static String convertFrom(int duration, {bool includeSeconds = true}) {
    final hours = duration ~/ 3600000;
    final hoursRemainder = duration.remainder(3600000);
    final minutes = (hoursRemainder ~/ 60000);
    final minutesRemainder = hoursRemainder.remainder(60000);
    final seconds = (minutesRemainder / 1000).round();

    String hoursString = hours.toString();
    String minutesString = minutes.toString();
    String secondsString = seconds.toString();

    final withLabels = includeSeconds == false;

    if (hoursString.trim().isNotEmpty) {
      hoursString = _getLabelFrom(hours, withLabels, 'hr');
    }

    minutesString = _getLabelFrom(minutes, withLabels, 'min');
    secondsString = _getLabelFrom(seconds, withLabels, '');

    if (minutesString == '60') {
      minutesString = '00';
      hoursString = _getLabelFrom(hours + 1, withLabels, 'hr');
    }
    if (secondsString == '60') {
      secondsString = '00';
      minutesString = _getLabelFrom(minutes + 1, withLabels, 'min');
    }

    return includeSeconds
        ? hours == 0
            ? minutesString + ' : ' + secondsString
            : hoursString + ' : ' + minutesString + ' : ' + secondsString
        : hours == 0
            ? minutesString
            : hoursString + minutesString;
  }

  static String _getLabelFrom(int duration, bool withLabels, String label) {
    var durationString = duration.toString();
    final isLong = durationString.length > 1;

    return withLabels
        ? isLong
            ? durationString = durationString + ' $label '
            : durationString = '0' + durationString + ' $label '
        : isLong
            ? durationString
            : durationString = '0' + durationString;
  }
}
