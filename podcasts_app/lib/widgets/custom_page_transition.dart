import 'package:podcasts/source.dart';

class CustomPageTransition extends PageRouteBuilder {
  final Widget child;
  CustomPageTransition({required this.child})
      : super(
            reverseTransitionDuration: const Duration(milliseconds: 100),
            pageBuilder: (context, animation, secAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child);
  }
}
