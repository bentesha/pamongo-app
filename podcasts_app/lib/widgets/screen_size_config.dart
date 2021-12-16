import 'package:flutter/material.dart';

class ScreenSizeConfig {
  static Size _designSize = const Size(0, 0);
  static Size _screenSize = const Size(0, 0);

  static void init(Size designSize, Size screenSize) {
    _designSize = designSize;
    _screenSize = screenSize;
  }

  //s for screen
  //d for design
  static final sWidth = _screenSize.width;
  static final dWidth = _designSize.width;
  static final sHeight = _screenSize.height;
  static final dHeight = _designSize.height;

  static int getIntWidth(num width) => ((width * sWidth) ~/ dWidth);
  static int getIntHeight(num height) => ((height * sHeight) ~/ dHeight);

  static double getDoubleWidth(num width) => ((width * sWidth) / dWidth);
  static double getDoubleHeight(num height) => ((height * sHeight) / dHeight);
}
