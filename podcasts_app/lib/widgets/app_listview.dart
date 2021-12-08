import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/themes/app_colors.dart';
import 'package:podcasts/utils/utils.dart';
import 'package:podcasts/widgets/widgets_source.dart';

class AppListView extends StatefulWidget {
  const AppListView(
      {required this.header,
      required this.children,
      this.backArrowCallback,
      this.thresholdOffset,
      this.appBarColor,
      Key? key})
      : super(key: key);

  final String header;
  final List<Widget> children;
  final Color? appBarColor;
  final double? thresholdOffset;
  final VoidCallback? backArrowCallback;

  @override
  _AppListViewState createState() => _AppListViewState();
}

class _AppListViewState extends State<AppListView> {
  final topOffsetNotifier = ValueNotifier<double>(0);
  static const thresholdOffset = 28.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NotificationListener(
          onNotification: (ScrollNotification n) {
            topOffsetNotifier.value = n.metrics.pixels;
            return true;
          },
          child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: widget.children),
        ));
  }

  _buildAppBar() {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: ValueListenableBuilder<double>(
            valueListenable: topOffsetNotifier,
            builder: (context, topOffset, child) {
              if (topOffset > thresholdOffset) topOffset = thresholdOffset;
              return AppBar(
                elevation: topOffset >= thresholdOffset ? 3 : 0,
                backgroundColor:
                    widget.appBarColor ?? AppColors.backgroundColor,
                leading: AppIconButton(
                  onPressed:
                      widget.backArrowCallback ?? () => Navigator.pop(context),
                  icon: EvaIcons.arrowBackOutline,
                  spreadRadius: 22.dw,
                  iconSize: 26.dw,
                  iconColor: AppColors.secondaryColor,
                ),
                title: AppText(widget.header,
                    size: 18.w,
                    weight: FontWeight.bold,
                    color:
                        Colors.black.withOpacity(topOffset / thresholdOffset)),
              );
            }));
  }
}
