import '../source.dart';

class AppSlider extends StatefulWidget {
  const AppSlider(
      {required this.currentValue,
      required this.bufferedValue,
      required this.onValueChanged,
      required this.duration,
      required this.sliderWidth,
      Key? key})
      : super(key: key);

  final int currentValue;
  final int bufferedValue;
  final int duration;
  final ValueChanged<double> onValueChanged;
  final double sliderWidth;

  @override
  _AppSliderState createState() => _AppSliderState();
}

class _AppSliderState extends State<AppSlider> {
  double xTapped = 0;
  bool shouldUseTappedValue = false;

  ///converts a duration to a local position value btn 0 and a sizedbox widget
  ///width.
  double correctFrom(int value) {
    return value * widget.sliderWidth / widget.duration;
  }

  ///reverses a local position value to duration to be used for changing audio
  ///position.
  double reverseFrom(double value) {
    return value * widget.duration / widget.sliderWidth;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (d) {
        final dx = d.localPosition.dx;
        setState(() {
          xTapped = dx < 0 ? 0 : dx;
          widget.onValueChanged(reverseFrom(xTapped));
        });
      },
      onHorizontalDragUpdate: (d) {
        final dx = d.localPosition.dx;
        final duration = correctFrom(widget.duration);
        setState(() {
          xTapped = dx < 0
              ? 0
              : dx > duration
                  ? duration
                  : dx;
          shouldUseTappedValue = true;
        });
      },
      onHorizontalDragEnd: (d) {
        widget.onValueChanged(reverseFrom(xTapped));
        shouldUseTappedValue = false;
      },
      child: SizedBox(
          height: 30.dh,
          width: widget.sliderWidth,
          child: CustomPaint(
            painter: AppSliderPainter(
                correctFrom(widget.bufferedValue),
                shouldUseTappedValue
                    ? xTapped
                    : correctFrom(widget.currentValue)),
          )),
    );
  }
}

class AppSliderPainter extends CustomPainter {
  final double xBuffered;
  final double xTapped;
  const AppSliderPainter(this.xBuffered, this.xTapped);

  _paintUsing(Color color) {
    return Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final unbufferedPaint = _paintUsing(AppColors.disabledColor);
    final bufferedPaint = _paintUsing(Colors.white);
    final playedPaint = _paintUsing(AppColors.primaryColor);

    final circlePaint = Paint()
      ..color = AppColors.primaryColor
      ..style = PaintingStyle.fill;

    final dy = size.height / 2;

    final startingPoint = Offset(size.width * .008, dy);
    final endingPointUnbuffered = Offset(size.width, dy);
    final endingPointBuffered = Offset(xBuffered, dy);
    final endingPointPlayed = Offset(xTapped, dy);
    final circleOffset = Offset(xTapped, dy);

    canvas.drawLine(startingPoint, endingPointUnbuffered, unbufferedPaint);
    canvas.drawLine(startingPoint, endingPointBuffered, bufferedPaint);
    canvas.drawLine(startingPoint, endingPointPlayed, playedPaint);
    canvas.drawCircle(circleOffset, 4, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
