import 'package:podcasts/source.dart';
import 'package:podcasts/widgets/screen_size_config.dart';

class ScreenSizeInit extends StatelessWidget {
  const ScreenSizeInit({required this.child, required this.designSize, key})
      : super(key: key);

  final Size designSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 0) {
        ScreenSizeConfig.init(
            designSize, Size(constraints.maxWidth, constraints.maxHeight));
        return child;
      }
      return Container();
    });
  }
}
