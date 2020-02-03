import 'package:flutter/material.dart';

class Style {
  static ThemeData defaultTheme(BuildContext context) {
    const brightness = Brightness.dark;
    const brandColor = Color(0xFF3FA9F5);
    const dark = Color(0xFF222222);

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: Colors.transparent,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      textSelectionColor: brandColor,
      textSelectionHandleColor: Colors.white,
      splashColor: brandColor,
      backgroundColor: dark,
      cardColor: dark,
      buttonColor: brandColor,
      errorColor: Colors.deepOrange,
      canvasColor: dark,
      cursorColor: brandColor,
      accentColor: brandColor,
      dividerColor: Colors.white,
    );
  }
}
