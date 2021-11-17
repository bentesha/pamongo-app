import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/models/channel.dart';
import 'package:podcasts/models/episode.dart';
import 'package:http/http.dart' as http;
import 'package:podcasts/models/series.dart';

class PodcastsRepository {
  static const root = 'http://pamongo.mobicap.co.tz:9090/api/';
  static const timeLimit = Duration(seconds: 10);

  static Future<List<Series>> getFeaturedSeries() async => await getSeries(
      'series?eager=channel&rangeStart=0&rangeEnd=7&orderByDesc=createdAt');

  static Future<List<Episode>> getRecentEpisodes() async => getEpisodes(
      'episode?eager=series&rangeStart=0&rangeEnd=7&orderByDesc=createdAt&sequence%3Aneq=1');

  static Future<List<Series>> getAllSeries() async =>
      await getSeries('series?eager=channel&orderByDesc=createdAt');

  static Future<List<Episode>> getAllEpisodes() async =>
      getEpisodes('episode?eager=series&orderByDesc=createdAt');

  static Future<List<Channel>> getAllChannels() async {
    try {
      const url = '${root}channel?orderByDesc=createdAt';
      final response = await http.get(Uri.parse(url)).timeout(timeLimit);
      final body = jsonDecode(response.body);
      final results = body['results'];

      final List<Channel> channelsList = [];
      for (Map<String, dynamic> e in results) {
        channelsList.add(Channel.fromJson(e, seriesList: []));
      }
      return channelsList;
    } on TimeoutException catch (_) {
      throw ApiError.fromType(ApiErrorType.timeout);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<Channel> getChannelById(String channelId) async {
    try {
      final url =
          '${root}series?eager=%5Bchannel,episodes%5D&channelId=$channelId';
      final response = await http.get(Uri.parse(url)).timeout(timeLimit);
      final body = jsonDecode(response.body);
      final jsonSeries = body['results'];
      final jsonChannel = jsonSeries.first['channel'];

      List<Episode> episodeList = [];
      final seriesList = jsonSeries.map((series) {
        final episodes = series['episodes'];
        for (Map<String, dynamic> e in episodes) {
          episodeList.add(Episode.fromJson(e,
              seriesId: series['id'],
              seriesImage: series['thumbnailUrl'],
              seriesName: series['name']));
        }

        return Series.fromJson(series,
            channelName: jsonChannel['name'], episodeList: episodeList);
      }).toList();

      return Channel.fromJson(jsonChannel, seriesList: seriesList);
    } on TimeoutException catch (_) {
      throw ApiError.fromType(ApiErrorType.timeout);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<Series> getSeriesById(String seriesId) async {
    try {
      final url = '${root}series?eager=%5Bepisodes,%20channel%5D&id=$seriesId';
      final response = await http.get(Uri.parse(url)).timeout(timeLimit);
      final body = jsonDecode(response.body);

      final series = body['results'][0];
      final channel = series['channel'];
      final episodes = series['episodes'];

      List<Episode> episodeList = [];
      for (Map<String, dynamic> e in episodes) {
        episodeList.add(Episode.fromJson(e,
            seriesId: series['id'],
            seriesImage: series['thumbnailUrl'],
            seriesName: series['name']));
      }

      return Series.fromJson(series,
          channelName: channel['name'], episodeList: episodeList);
    } on TimeoutException catch (_) {
      throw ApiError.fromType(ApiErrorType.timeout);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<List<Episode>> getEpisodes(String url) async {
    try {
      final _url = root + url;
      final response = await http.get(Uri.parse(_url)).timeout(timeLimit);
      final body = jsonDecode(response.body);
      final results = body['results'];

      List<Episode> episodeList = [];
      for (Map<String, dynamic> e in results) {
        final series = e['series'];
        episodeList.add(Episode.fromJson(e,
            seriesId: series['id'],
            seriesImage: series['thumbnailUrl'],
            seriesName: series['name']));
      }
      return episodeList;
    } on TimeoutException catch (_) {
      throw ApiError.fromType(ApiErrorType.timeout);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }

  static Future<List<Series>> getSeries(String url) async {
    try {
      final _url = root + url;
      final response = await http.get(Uri.parse(_url)).timeout(timeLimit);
      final body = jsonDecode(response.body);
      final results = body['results'];

      final List<Series> seriesList = [];
      for (Map<String, dynamic> e in results) {
        seriesList.add(Series.fromJson(e, channelName: e['channel']['name']));
      }
      return seriesList;
    } on TimeoutException catch (_) {
      throw ApiError.fromType(ApiErrorType.timeout);
    } catch (_) {
      log(_.toString());
      throw ApiError.fromType(ApiErrorType.unknown);
    }
  }
}
