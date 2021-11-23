import 'package:audio_session/audio_session.dart';
import 'package:hive/hive.dart';
import 'package:podcasts/models/saved_episodes.dart';
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
    ..registerAdapter(SavedEpisodeAdapter());

  await Hive.openBox('played_episodes');

  final session = await AudioSession.instance;

  final myApp = Provider<AudioPlayerService>(
      create: (_) => AudioPlayerService(session), child: const MyApp());
  runApp(myApp);
}
