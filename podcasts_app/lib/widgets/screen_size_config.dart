import 'package:flutter/material.dart';

class ScreenSizeConfig {
  static Size _designSize = const Size(0, 0);
  static Size _screenSize = const Size(0, 0);

  static void init(Size designSize, Size screenSize) {
    _designSize = designSize;
    _screenSize = screenSize;
  }

  static final screenWidth = _screenSize.width;
  static final designWidth = _designSize.width;
  static final screenHeight = _screenSize.height;
  static final designHeight = _designSize.height;

  static int getIntWidth(num width) => ((width * screenWidth) ~/ designWidth);
  static int getIntHeight(num height) =>
      ((height * screenHeight) ~/ designHeight);

  static double getDoubleWidth(num width) => ((width * screenWidth) / designWidth);
  static double getDoubleHeight(num height) =>
      ((height * screenHeight) / designHeight);
}
