import 'dart:convert';
import 'dart:developer';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:podcasts/models/series.dart';

class PodcastsApi {
  static const root = 'http://pamongo.mobicap.co.tz:9090/api/';

  static Future<List> getFeaturedSeries() async {
    try {
      const url =
          '${root}series?eager=channel&rangeStart=0&rangeEnd=5&orderByDesc=createdAt';
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);
      final results = body['results'];
      return results
          .map((e) => Series.fromJson(e, channelName: e['channel']['name']))
          .toList();
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<Channel> getChannelById(String channelId) async {
    try {
      final url =
          '${root}series?eager=%5Bchannel,episodes%5D&channelId=$channelId';
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);
      final jsonSeries = body['results'];
      final jsonChannel = jsonSeries.first['channel'];

      final seriesList = jsonSeries.map((series) {
        final episodeList = series['episodes']
            .map((episode) => Episode.fromJson(episode,
                seriesId: series['id'],
                seriesImage: series['thumbnailUrl'],
                seriesName: series['name']))
            .toList();
        return Series.fromJson(series,
            channelName: jsonChannel['name'], episodeList: episodeList);
      }).toList();

      return Channel.fromJson(jsonChannel, seriesList: seriesList);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<Series> getSeriesById(String seriesId) async {
    try {
      final url = '${root}series?eager=%5Bepisodes,%20channel%5D&id=$seriesId';
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);

      final series = body['results'][0];
      final channel = series['channel'];
      final episodes = series['episodes'];
      final episodeList = episodes
          .map((e) => Episode.fromJson(e,
              seriesId: series['id'],
              seriesImage: series['thumbnailUrl'],
              seriesName: series['name']))
          .toList();

      return Series.fromJson(series,
          channelName: channel['name'], episodeList: episodeList);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<List> getRecentEpisodes() async {
    try {
      const url =
          '${root}episode?eager=series&rangeStart=0&rangeEnd=6&orderByDesc=createdAt';
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);
      final results = body['results'];
      return results.map((e) {
        final series = e['series'];
        return Episode.fromJson(e,
            seriesId: series['id'],
            seriesImage: series['thumbnailUrl'],
            seriesName: series['name']);
      }).toList();
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }
}
