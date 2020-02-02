import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarDarkMode extends StatelessWidget {
  final Widget child;

  const StatusBarDarkMode({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      child: child,
    );
  }
}
