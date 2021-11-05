import 'package:audio_service/audio_service.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/foreground_player.dart';
import 'package:podcasts/widgets/screen_size_init.dart';
import 'pages/homepage.dart';

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
    initForegroundPlayer(service);
    super.initState();
  }

  initForegroundPlayer(AudioPlayerService service) async {
    await AudioService.init(
      builder: () => ForegroundPlayer(service),
      config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.example.podcasts_app',
          androidNotificationChannelName: 'Pamongo',
          androidNotificationIcon: 'drawable/logo_small'),
    );
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
            home: const Homepage()));
  }
}
