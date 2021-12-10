import 'package:cached_network_image/cached_network_image.dart';
import 'package:podcasts/source.dart';

class AppImageButton extends StatefulWidget {
  const AppImageButton(
      {required this.imageUrl,
      this.size,
      required this.onPressed,
      this.highlightColor,
      this.placeholderIcon,
      this.radius,
      this.placeholderColor,
      Key? key})
      : super(key: key);

  final String imageUrl;
  final double? size;
  final VoidCallback onPressed;
  final Color? highlightColor, placeholderColor;
  final Widget? placeholderIcon;
  final double? radius;

  @override
  _AppImageButtonState createState() => _AppImageButtonState();
}

class _AppImageButtonState extends State<AppImageButton>
    with SingleTickerProviderStateMixin {
  double dx = 0.0, dy = 0.0;
  late final AnimationController controller;
  late final Animation animation;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this,
        reverseDuration: const Duration(milliseconds: 0),
        duration: const Duration(milliseconds: 250));

    animation =
        Tween<double>(begin: 0, end: widget.size ?? 800).animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
              widget.onPressed();
            }
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size ?? 200,
        height: widget.size ?? 200,
        decoration: BoxDecoration(
            borderRadius:
                BorderRadius.all(Radius.circular(widget.radius ?? 7.dw))),
        child: GestureDetector(
          onTapUp: _onTapUp,
          child: AnimatedBuilder(
              animation: animation,
              child: _child(),
              builder: (context, child) {
                return ClipRect(
                  child: CustomPaint(
                    foregroundPainter: RippleEffectPainter(
                        dx,
                        dy,
                        animation.value,
                        widget.highlightColor ?? Colors.white54),
                    child: _child(),
                  ),
                );
              }),
        ));
  }

  _child() => ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(widget.radius ?? 7.dw)),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, __) => Container(
              alignment: Alignment.center,
              color: widget.placeholderColor ?? Theme.of(context).primaryColor,
              child: widget.placeholderIcon ??
                  const Icon(EvaIcons.image, size: 32, color: Colors.white)),
        ),
      );

  _onTapUp(TapUpDetails details) {
    setState(() {
      dx = details.localPosition.dx;
      dy = details.localPosition.dy;
    });
    controller.forward();
  }
}

class RippleEffectPainter extends CustomPainter {
  final double dx, dy, radius;
  final Color highlightColor;
  RippleEffectPainter(this.dx, this.dy, this.radius, this.highlightColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center =
        Offset(dx == 0 ? size.width / 2 : dx, dy == 0 ? size.height / 2 : dy);
    final paint = Paint()..color = highlightColor;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
