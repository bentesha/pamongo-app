import 'package:flutter/material.dart';

class AppImageButton extends StatefulWidget {
  const AppImageButton(
      {required this.image,
      this.size,
      required this.onPressed,
      this.splashColor,
      Key? key})
      : super(key: key);

  final Widget image;
  final double? size;
  final VoidCallback onPressed;
  final Color? splashColor;

  @override
  _AppImageButtonState createState() => _AppImageButtonState();
}

class _AppImageButtonState extends State<AppImageButton> {
  late final double size;

  @override
  void initState() {
    size = widget.size ?? 200;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          widget.image,
          Material(
              elevation: 0,
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Future.delayed(const Duration(milliseconds: 200))
                    .then((value) => widget.onPressed()),
                splashColor:
                    widget.splashColor ??  Colors.grey.withOpacity(.35),
              )),
        ],
      ),
    );
  }
}
