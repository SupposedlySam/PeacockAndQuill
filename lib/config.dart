import 'package:flutter/material.dart';

class Config {
  static ThemeData defaultTheme(context) {
    const Brightness brightness = Brightness.dark;
    return ThemeData(
      brightness: brightness,
    );
  }
}
