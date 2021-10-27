import 'package:podcasts/services/audio_player_service.dart';
import 'package:podcasts/source.dart';

class AudioProgressWidget extends StatefulWidget {
  const AudioProgressWidget({key}) : super(key: key);

  @override
  State<AudioProgressWidget> createState() => _AudioProgressWidgetState();
}

class _AudioProgressWidgetState extends State<AudioProgressWidget> {
  double startValue = 0;
  double endValue = 0;
  double maxTopGlobalOffset = 255;
  static double initialOffset = 796.3;
  final referenceHeight = 866.3;
  final referenceWidth = 411.4;
  ValueNotifier<double> positionValueNotifier = ValueNotifier(initialOffset);
  ValueNotifier<bool> isShowInitialWidgetNotifier = ValueNotifier<bool>(true);

  @override
  void didChangeDependencies() {
    final size = MediaQuery.of(context).size;
    initialOffset = 796.3 * size.height / referenceHeight;
    maxTopGlobalOffset = 255 * size.height / referenceHeight;
    positionValueNotifier = ValueNotifier(initialOffset);
    super.didChangeDependencies();
  }

  late final AudioPlayerService service;

  @override
  void initState() {
    service = Provider.of<AudioPlayerService>(context, listen: false);
    service.isIndicatorExpandedStream.listen((isExpanded) {
      _handleExpandedStatusChanges(isExpanded);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
        valueListenable: positionValueNotifier,
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
      service.changeIndicatorExpandedStatusTo(true);
      return;
    }

    service.changeIndicatorExpandedStatusTo(false);
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) async {
    endValue = details.globalPosition.dy;
    final isDraggingDownwards = endValue > startValue;

    if (isDraggingDownwards && endValue > initialOffset) {
      service.changeIndicatorExpandedStatusTo(false);

      return;
    }

    if (endValue < maxTopGlobalOffset) {
      positionValueNotifier.value = maxTopGlobalOffset;
      return;
    }
    if (endValue < initialOffset) {
      isShowInitialWidgetNotifier.value = false;
    }

    positionValueNotifier.value = details.globalPosition.dy - 80;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    startValue = details.globalPosition.dy;
    isShowInitialWidgetNotifier.value = false;
  }

  void _onVerticalDragEnd(DragEndDetails details) async {
    final isDraggingUpwards = endValue < startValue;

    if (isDraggingUpwards) {
      service.changeIndicatorExpandedStatusTo(true);
      return;
    }

    service.changeIndicatorExpandedStatusTo(false);
  }

  Future<void> _handleExpandedStatusChanges(bool isExpanded) async {
    if (isExpanded) {
      positionValueNotifier.value = maxTopGlobalOffset;
      isShowInitialWidgetNotifier.value = false;
      return;
    }
    positionValueNotifier.value = initialOffset;
    await Future.delayed(const Duration(milliseconds: 400))
        .then((value) => isShowInitialWidgetNotifier.value = true);
  }
}
