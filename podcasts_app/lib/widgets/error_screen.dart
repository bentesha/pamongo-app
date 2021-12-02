import 'package:podcasts/errors/api_error.dart';
import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/app_text_button.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen(this.error, {required this.refreshCallback, key})
      : super(key: key);

  final ApiError error;
  final VoidCallback refreshCallback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(EvaIcons.wifiOff, size: 32, color: AppColors.errorColor),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppText(
                error.message,
                size: 18,
                alignment: TextAlign.center,
                maxLines: 2,
              ),
            ),
            AppTextButton(
                onPressed: refreshCallback,
                text: 'Try Again',
                borderRadius: 5)
          ],
        ),
      ),
    );
  }
}
