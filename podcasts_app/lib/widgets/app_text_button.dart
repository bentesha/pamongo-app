import 'package:flutter/material.dart';
import '../source.dart';

class AppTextButton extends StatefulWidget {
  const AppTextButton(
      {this.buttonColor = Colors.transparent,
      this.highlightColor = const Color(0xffF2F1F0),
      this.textColor,
      this.borderColor,
      this.icon,
      this.iconColor,
      this.padding,
      this.margin,
      this.height,
      this.width,
      this.text,
      this.child,
      this.isBolded = false,
      this.withIcon = false,
      required this.onPressed,
      this.duration = const Duration(milliseconds: 200),
      this.borderRadius,
      Key? key})
      : super(key: key);

  final Color buttonColor;
  final Color highlightColor;
  final Color? textColor;
  final IconData? icon;
  final Color? iconColor;
  final double? height;
  final double? width;
  final VoidCallback onPressed;
  final Duration duration;
  final double? borderRadius;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final bool isBolded, withIcon;
  final Widget? child;

  @override
  _AppTextButtonState createState() => _AppTextButtonState();
}

class _AppTextButtonState extends State<AppTextButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<Color?> animation;

  @override
  void initState() {
    controller = AnimationController(
        duration: widget.duration,
        reverseDuration: const Duration(milliseconds: 0),
        vsync: this);
    animation =
        ColorTween(end: widget.highlightColor, begin: widget.buttonColor)
            .animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onPressed();
              controller.reverse();
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: _child(),
      builder: (context, child) {
        return GestureDetector(
          onTap: () => controller.forward(),
          child: Container(
              height: widget.height,
              width: widget.width,
              margin: widget.margin ?? EdgeInsets.zero,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius ?? 0)),
                border: Border.all(
                    width: 1.0,
                    color: widget.borderColor ?? AppColors.borderColor),
                color: animation.value,
              ),
              alignment: Alignment.center,
              child: _child()),
        );
      },
    );
  }

  _child() {
    final hasProvidedChild = widget.child != null;

    return hasProvidedChild
        ? widget.child
        : widget.withIcon
            ? Row(children: [
                Icon(widget.icon ?? EvaIcons.share,
                    color: widget.iconColor ?? AppColors.secondaryColor,
                    size: 18),
                const SizedBox(width: 15),
                _text(),
              ])
            : _text();
  }

  _text() {
    return AppText(widget.text ?? 'Click Me',
        size: 15,
        weight: widget.isBolded ? FontWeight.w600 : FontWeight.w400,
        color: widget.textColor ?? AppColors.textColor);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
