import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/lifecycle_managers/focus_node_manager.dart';
import 'package:peacock_and_quill/config.dart';
import 'package:peacock_and_quill/models/navigation_entity.dart';
import 'package:peacock_and_quill/routing/router.dart';
import 'package:peacock_and_quill/views/layout_template/layout_template.dart';
import 'package:peacock_and_quill/components/keyboard_navigator.dart';

import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusNodeManager(
      builder: (context, focusNode) {
        return KeyboardNavigator(
          focusNode: focusNode,
          child: mainApp(context),
        );
      },
    );
  }

  MaterialApp mainApp(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [locator<NavigationEntity>()],
      title: 'Peacock and Quill',
      theme: Config.defaultTheme(context),
      onGenerateRoute: onGenerateRouteHandler,
      builder: (context, navigator) {
        return LayoutTemplate(
          navigator: navigator as Navigator,
        );
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
