import '../source.dart';

class AppMaterialButton extends StatefulWidget {
  const AppMaterialButton(
      {required this.child,
      required this.onPressed,
      this.borderRadius = 0,
      key})
      : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;

  @override
  State<AppMaterialButton> createState() => _AppMaterialButtonState();
}

class _AppMaterialButtonState extends State<AppMaterialButton> {
  final isTappedNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        isTappedNotifier.value = true;
      },
      padding: EdgeInsets.zero,
      splashColor: Colors.transparent,
      child: ValueListenableBuilder<bool>(
          valueListenable: isTappedNotifier,
          child: widget.child,
          builder: (_, isTapped, child) {
            return !isTapped ? child : _animatedChild();
          }),
    );
  }

  _animatedChild() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: .05, end: .2),
      curve: Curves.easeOutQuint,
      duration: const Duration(milliseconds: 200),
      child: widget.child,
      builder: (_, value, child) {
        return Container(
            child: child,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(value),
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.borderRadius))));
      },
      onEnd: () {
        isTappedNotifier.value = false;
        widget.onPressed();
      },
    );
  }
}
