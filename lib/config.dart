import 'package:flutter/material.dart';

class Config {
  static ThemeData defaultTheme(context) => ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      );
}
