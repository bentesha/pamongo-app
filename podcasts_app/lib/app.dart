import 'package:audio_service/audio_service.dart';
import 'package:podcasts/pages/pages_source.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text.dart';
import 'package:podcasts/widgets/foreground_player.dart';
import 'package:uni_links/uni_links.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.backgroundColor,
            fontFamily: 'Louis'),
        //detecting whether the app is opened using a link or otherwise
        home: FutureBuilder<String?>(
            future: getInitialLink(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const Homepage();
              return _uriParseToPage(snapshot.data!);
            }));
  }

  _uriParseToPage(String uri) {
    final index = uri.indexOf('.tz/');
    final page = uri.substring(index + 4);
    final idIndex = page.indexOf('/');
    final id = page.substring(idIndex + 1);

    if (page.contains('series')) return SeriesPage(id, isOpenedUsingLink: true);
    if (page.contains('channel')) return ChannelPage(id, isOpenedUsingLink: true);
    if (page.contains('episode')) return EpisodePage(id: id);
    return Scaffold(body: Center(child: AppText('can\'t open $uri', size: 16)));
  }
}
