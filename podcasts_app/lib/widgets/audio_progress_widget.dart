import 'package:podcasts/source.dart';

class AudioProgressWidget extends StatefulWidget {
  const AudioProgressWidget({key}) : super(key: key);

  @override
  State<AudioProgressWidget> createState() => _AudioProgressWidgetState();
}

class _AudioProgressWidgetState extends State<AudioProgressWidget> {
  static double startValue = 0;
  static double endValue = 0;
  static double initialOffset = 796.3.dh;
  static double maxTopGlobalOffset = 275.dh;
  ValueNotifier<double> notifier = ValueNotifier(initialOffset);
  ValueNotifier<bool> isShowInitialWidgetNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: notifier,
        builder: (context, value, snapshot) {
          return Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: value,
                bottom: 0,
                child: Material(
                  child: GestureDetector(
                      onTap: _onTap,
                      onVerticalDragEnd: _onVerticalDragEnd,
                      onVerticalDragStart: _onVerticalDragStart,
                      onVerticalDragUpdate: _onVerticalDragUpdate,
                      child: _buildBody()),
                ),
              ),
            ],
          );
        });
  }

  _buildBody() {
    return ValueListenableBuilder<bool>(
        valueListenable: isShowInitialWidgetNotifier,
        builder: (context, value, child) {
          return AppProgressIndicator(value);
        });
  }

  void _onTap() async {
    if (isShowInitialWidgetNotifier.value) {
      notifier.value = maxTopGlobalOffset;
      isShowInitialWidgetNotifier.value = false;
      return;
    }
    notifier.value = initialOffset;
    await showInitial();
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) async {
    endValue = details.globalPosition.dy;
    final isDraggingDownwards = endValue > startValue;

    if (isDraggingDownwards && endValue > initialOffset) {
      notifier.value = initialOffset;
      await showInitial();
      return;
    }

    if (endValue < maxTopGlobalOffset) {
      notifier.value = maxTopGlobalOffset;
      return;
    }
    if (endValue < initialOffset) {
      isShowInitialWidgetNotifier.value = false;
    }
    notifier.value = details.globalPosition.dy - 80.dh;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    startValue = details.globalPosition.dy;
    isShowInitialWidgetNotifier.value = false;
  }

  void _onVerticalDragEnd(DragEndDetails details) async {
    final isDraggingUpwards = endValue < startValue;

    if (isDraggingUpwards) {
      notifier.value = maxTopGlobalOffset;
      return;
    }
    notifier.value = initialOffset;
    await showInitial();
  }

  Future<void> showInitial() async {
    await Future.delayed(const Duration(milliseconds: 400))
        .then((_) => isShowInitialWidgetNotifier.value = true);
  }
}
