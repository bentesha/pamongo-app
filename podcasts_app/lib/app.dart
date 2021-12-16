import 'dart:async';
import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:device_info/device_info.dart';
import 'package:hive/hive.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/events/episode_event.dart';
import 'package:podcasts/models/device_info.dart';
import 'package:podcasts/repositories/events_repository.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/foreground_player.dart';
import 'package:podcasts/widgets/screen_size_init.dart';
import 'package:uni_links/uni_links.dart';
import 'package:audio_session/audio_session.dart';

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of(context, listen: false);
    _initForegroundPlayer(service);
    _getDeviceInfo();
    _setUpTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSizeInit(
        designSize: const Size(411.4, 866.3),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: AppColors.backgroundColor,
                fontFamily: 'Louis'),
            //detecting whether the app is opened using a link or otherwise
            home: FutureBuilder<String?>(
                future: getInitialLink(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const Homepage();
                  return _getInitialPage(snapshot.data!);
                })));
  }

  _getInitialPage(String uri) {
    final index = uri.indexOf('.tz/');
    final page = uri.substring(index + 4);
    final idIndex = page.indexOf('/');
    final id = page.substring(idIndex + 1);

    if (page.contains('series')) return SeriesPage(id, isOpenedUsingLink: true);
    if (page.contains('episode')) return EpisodePage(id: id);
    if (page.contains('channel')) {
      return ChannelPage(id, isOpenedUsingLink: true);
    }
    return Scaffold(
        body: Center(child: AppText('can\'t open $uri', size: 16.w)));
  }

  _initForegroundPlayer(AudioPlayerService service) async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    await AudioService.init(
      builder: () => ForegroundPlayer(service),
      config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.example.podcasts_app',
          androidNotificationChannelName: 'Pamongo',
          androidNotificationIcon: 'drawable/logo_small'),
    );
  }

  _getDeviceInfo() async {
    final plugin = DeviceInfoPlugin();
    final box = Hive.box(deviceInfoBox);

    if (box.isNotEmpty) return;

    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      box.put(
          'device_info',
          DeviceInfo(
              id: info.id,
              make: info.manufacturer,
              type: 'android',
              model: info.model,
              version: info.version.release));
    }
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      box.put(
          'device_info',
          DeviceInfo(
              id: info.utsname.nodename,
              make: info.utsname.machine,
              type: 'ios',
              model: info.model,
              version: info.systemVersion));
    }
  }

  _setUpTimer() {
    final _progressBox = Hive.box(progressBox);

    Timer.periodic(const Duration(seconds: 15), (timer) async {
      final progressList = _progressBox.values.toList();
      final isConnected = await Utils.checkConnectivity();

      if (progressList.isEmpty) return;
      if (!isConnected) return;
      for (var progress in progressList) {
        final event =
            PlayEvent(position: progress.position, episodeId: progress.id)
                .createEvent();
        final statusCode = await EventsRepository.postEvent(event);
        if (statusCode == 200) _progressBox.delete(progress.id);
      }
    });
  }
}
