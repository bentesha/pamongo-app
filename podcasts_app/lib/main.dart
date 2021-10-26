import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';
import 'app.dart';
import 'package:provider/provider.dart';

void main() async {

  final myApp = Provider<AudioPlayerService>(
      create: (_) => AudioPlayerService(), child: const MyApp());
  runApp(myApp);
}
