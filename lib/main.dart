import 'package:flutter/material.dart';
import 'package:peacock_and_quill/config.dart';
import 'package:peacock_and_quill/routing/router.dart';
import 'package:peacock_and_quill/entities/navigation_entity.dart';
import 'package:peacock_and_quill/views/layout_template/layout_template.dart';

import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [locator<NavigationEntity>()],
      title: 'Peacock and Quill',
      theme: Config.defaultTheme(context),
      onGenerateRoute: onGenerateRouteHandler,
      builder: (context, navigator) => LayoutTemplate(navigator: navigator),
      debugShowCheckedModeBanner: false,
    );
  }
}
