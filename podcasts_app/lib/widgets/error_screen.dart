import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/source.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {key}) : super(key: key);

  final ApiError error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(EvaIcons.wifiOff, size: 32, color: AppColors.inactive),
        Padding(
          padding: const EdgeInsets.all(20),
          child: AppText(
            error.message,
            size: 18,
            alignment: TextAlign.center,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
