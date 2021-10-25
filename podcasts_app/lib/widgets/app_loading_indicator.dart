import 'package:lottie/lottie.dart';
import '../source.dart';
class AppLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color backgroundColor;
  const AppLoadingIndicator({
    this.message,
    this.backgroundColor = AppColors.background,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: AppColors.background,
        child: message != null
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/icons/loading_content.json',
                      height: 40, width: 40),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppText(message!),
                  )
                ],
              )
            : Lottie.asset('assets/icons/loading_content.json',
                height: 40, width: 40));
  }
}
