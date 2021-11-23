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
            Icon(EvaIcons.wifiOff, size: 32.dw, color: AppColors.errorColor),
            Padding(
              padding: EdgeInsets.all(20.dw),
              child: AppText(
                error.message,
                size: 18.h,
                alignment: TextAlign.center,
                maxLines: 2,
              ),
            ),
            AppTextButton(
                callback: refreshCallback, text: 'Try Again', radius: 5.dw)
          ],
        ),
      ),
    );
  }
}
