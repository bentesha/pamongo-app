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
                  const CircularProgressIndicator(
                      color: Colors.white,
                      valueColor: AlwaysStoppedAnimation(AppColors.secondary)),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AppText(message!, size: 16.w),
                  )
                ],
              )
            : CircularProgressIndicator(
                color: backgroundColor,
                valueColor: const AlwaysStoppedAnimation(AppColors.secondary)));
  }
}
