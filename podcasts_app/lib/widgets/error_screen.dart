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
        Icon(EvaIcons.wifiOff, size: 32.dw, color: AppColors.inactive),
        Padding(
          padding: EdgeInsets.all(20.dw),
          child: AppText(
            error.message,
            size: 18.h,
            alignment: TextAlign.center,
            maxLines: 2,
          ),
        )
      ],
    );
  }
}
