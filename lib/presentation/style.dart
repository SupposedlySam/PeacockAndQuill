import 'package:flutter/material.dart';

class Style {
  static ThemeData defaultTheme(BuildContext context) {
    const brightness = Brightness.dark;
    return ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: Colors.transparent,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ));
  }
}
