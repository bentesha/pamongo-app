import 'package:audio_session/audio_session.dart';
import 'package:hive/hive.dart';
import 'package:podcasts/models/device_info.dart';
import 'package:podcasts/models/event.dart';
import 'package:podcasts/models/saved_episode.dart';
import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'app.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(SavedEpisodeAdapter())
    ..registerAdapter(EventAdapter())
    ..registerAdapter(DeviceInfoAdapter());

  await Hive.openBox('played_episodes');
  await Hive.openBox('device_info');
  await Hive.openBox('events');

  final session = await AudioSession.instance;

  final myApp = Provider<AudioPlayerService>(
      create: (_) => AudioPlayerService(session), child: const MyApp());
  runApp(myApp);
}
