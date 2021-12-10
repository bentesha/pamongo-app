import 'package:audio_session/audio_session.dart';
import 'package:hive/hive.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/models/device_info.dart';
import 'package:podcasts/models/progress.dart';
import 'package:podcasts/source.dart';
import 'app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive
    ..init(directory.path)
    ..registerAdapter(SavedEpisodeAdapter())
    ..registerAdapter(ProgressAdapter())
    ..registerAdapter(DeviceInfoAdapter());
    

  await Hive.openBox(savedEpisodesBox);
  await Hive.openBox(deviceInfoBox);
  await Hive.openBox(progressBox);

  final session = await AudioSession.instance;

  final myApp = Provider<AudioPlayerService>(
      create: (_) => AudioPlayerService(session), child: const MyApp());
  runApp(myApp);
}
