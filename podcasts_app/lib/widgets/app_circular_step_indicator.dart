import 'dart:math';
import 'package:flutter/material.dart';

class AppCircularStepIndicator extends StatelessWidget {
  const AppCircularStepIndicator(
      {this.unsteppedColor = Colors.grey,
      this.fillColor = Colors.transparent,
      this.stepColor = Colors.yellow,
      this.stepWidth = 2.5,
      this.currentStep = .3,
      required this.width,
      required this.height,
      key})
      : super(key: key);

  final Color unsteppedColor;
  final Color fillColor;
  final Color stepColor;
  final double stepWidth;
  final double currentStep;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        width: width,
        child: CustomPaint(
          painter: CircularStepIndicatorPainter(
              unsteppedColor: unsteppedColor,
              stepColor: stepColor,
              stepWidth: stepWidth,
              currentStep: currentStep,
              fillColor: fillColor),
        ));
  }
}

class CircularStepIndicatorPainter extends CustomPainter {
  final Color unsteppedColor;
  final Color fillColor;
  final Color stepColor;
  final double stepWidth;
  final double currentStep;

  CircularStepIndicatorPainter({
    required this.unsteppedColor,
    required this.fillColor,
    required this.stepColor,
    required this.stepWidth,
    required this.currentStep,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final circlePaint1 = Paint()..color = fillColor;
    final stepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = stepColor
      ..strokeWidth = stepWidth * 1.4
      ..strokeCap = StrokeCap.round;
    final stepPaint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = unsteppedColor
      ..strokeWidth = stepWidth
      ..strokeCap = StrokeCap.round;

    final radius1 = min(size.width / 2, size.height / 2);
    final radius2 = min(size.width / 2.1, size.height / 2.1);
    final center = Offset(size.width / 2, size.height / 2);
    final arcAngle = 2 * pi * currentStep;
    final rect = Rect.fromCircle(center: center, radius: radius2);
    canvas.drawCircle(center, radius1, circlePaint1);
    canvas.drawArc(rect, -pi / 2, 2 * pi, false, stepPaint2);
    canvas.drawArc(rect, -pi / 2, arcAngle, false, stepPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
