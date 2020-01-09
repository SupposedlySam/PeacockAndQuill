import 'package:flutter/material.dart';

class Config {
  static ThemeData defaultTheme(BuildContext context) {
    const brightness = Brightness.dark;
    return ThemeData(
      brightness: brightness,
    );
  }
}
