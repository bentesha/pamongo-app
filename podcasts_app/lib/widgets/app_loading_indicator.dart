import 'package:lottie/lottie.dart';
import '../source.dart';

class AppLoadingIndicator extends StatelessWidget {
  final String? message;
  final Color backgroundColor;
  const AppLoadingIndicator({
    this.message,
    this.backgroundColor = AppColors.backgroundColor,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        color: AppColors.backgroundColor,
        child: message != null
            ? Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/icons/loading_2.json',
                      height: 40.dw, width: 40.dw),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppText(message!, size: 16.w),
                  )
                ],
              )
            : Lottie.asset('assets/icons/loading_2.json',
                height: 40.dw, width: 40.dw));
  }
}
