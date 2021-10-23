import 'package:podcasts/errors/audio_error.dart';

import '../source.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.error, {key}) : super(key: key);

  final AudioError error;

  @override
  Widget build(BuildContext context) {
    final type = error.type;

    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(0))),
        title: Icon(
            type == ErrorType.internet ? Icons.wifi_off : Icons.error_outline,
            color: AppColors.error,
            size: 30),
        titlePadding: const EdgeInsets.only(bottom: 10, top: 30),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(error.message,
                size: 16,
                family: FontFamily.workSans,
                color: AppColors.onSecondary2),
          ],
        ));
  }
}
