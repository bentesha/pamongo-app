import 'dart:async';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:podcasts/constants.dart';
import 'package:podcasts/models/saved_episode.dart';
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

  static SavedEpisode? getSavedStatus(String id) {
    final box = Hive.box(kSavedEpisodesBox);
    return box.get(id);
  }

  ///returns true if the device is connected to internet
  static Future<bool> checkConnectivity() async {
    const timeLimit = Duration(minutes: 1);
    final response =
        await http.get(Uri.parse('https://pub.dev/')).timeout(timeLimit);
    return response.statusCode == 200;
  }

  ///converts a millisecond to time in hour-minute-seconds format
  static String convertFrom(int duration, {bool isUsedOnAudioSlider = false}) {
    var hours = duration ~/ 3600000;
    final hoursRemainder = duration.remainder(3600000);
    var minutes = (hoursRemainder ~/ 60000);
    final minutesRemainder = hoursRemainder.remainder(60000);
    var seconds = (minutesRemainder / 1000).round();

    if (minutes == 60) {
      minutes = 0;
      hours += 1;
    }

    if (seconds == 60) {
      seconds = 0;
      minutes += 1;
    }

    final correctedHours = _ensureTwoDigits(hours);
    final correctedMinutes = _ensureTwoDigits(minutes);
    final correctedSeconds = _ensureTwoDigits(seconds);

    final hoursLabel = _getLabel(hours, 'hr');
    final minutesLabel = _getLabel(minutes, 'min');

    return isUsedOnAudioSlider
        ? hours == 0
            ? '$correctedMinutes : $correctedSeconds '
            : '$correctedHours : $correctedMinutes : $correctedSeconds '
        : hours == 0
            ? minutes == 0
                ? '$correctedSeconds sec '
                : '$correctedMinutes $minutesLabel '
            : '$correctedHours $hoursLabel $correctedMinutes $minutesLabel ';
  }

  static String _ensureTwoDigits(int number) {
    final isLong = number.toString().length > 1;
    return !isLong ? '0$number' : '$number';
  }

  static String _getLabel(int number, String singularLabel) {
    return number > 1 ? '${singularLabel}s' : singularLabel;
  }
}
