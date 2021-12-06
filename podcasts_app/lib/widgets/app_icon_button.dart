import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatefulWidget {
  const AppIconButton(
      {this.icon,
      this.iconColor,
      this.margin,
      this.spreadRadius,
      this.iconSize,
      required this.onPressed,
      Key? key})
      : super(key: key);

  final IconData? icon;
  final Color? iconColor;
  final EdgeInsetsGeometry? margin;
  final double? spreadRadius;
  final double? iconSize;
  final VoidCallback onPressed;

  @override
  _AppIconButtonState createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        reverseDuration: const Duration(milliseconds: 100),
        duration: const Duration(milliseconds: 200));
    animation =
        Tween(begin: 5.0, end: widget.spreadRadius ?? 30.0).animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse().then((value) => widget.onPressed());
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        child: Icon(
          widget.icon ?? EvaIcons.award,
          color: widget.iconColor ?? Colors.black,
          size: widget.iconSize,
        ),
        builder: (context, child) {
          final hasStartedAnimating = animation.value > 5;
          return GestureDetector(
            onTap: () => controller.forward(),
            child: Container(
              margin: widget.margin,
              child: child,
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                    color: hasStartedAnimating
                        ? Colors.grey.withOpacity(.3)
                        : Colors.transparent,
                    spreadRadius: hasStartedAnimating ? animation.value : 0)
              ]),
            ),
          );
        });
  }
}
