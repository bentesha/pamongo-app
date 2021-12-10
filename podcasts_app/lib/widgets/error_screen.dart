import 'package:podcasts/source.dart';

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
                onPressed: refreshCallback,
                text: 'Try Again',
                width: 150.dw,
                borderRadius: 5.dw)
          ],
        ),
      ),
    );
  }
}
