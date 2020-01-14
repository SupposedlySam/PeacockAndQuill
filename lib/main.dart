import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/components/keyboard_navigator.dart';
import 'package:peacock_and_quill/components/lifecycle_managers/focus_node_manager.dart';
import 'package:peacock_and_quill/models/navigation_entity.dart';
import 'package:peacock_and_quill/providers.dart';
import 'package:peacock_and_quill/routing/router.dart';
import 'package:peacock_and_quill/style.dart';
import 'package:peacock_and_quill/views/layout_template/layout_template.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
      child: platformMain(context),
    );
  }

  Widget platformMain(BuildContext context) {
    if (kIsWeb) {
      return FocusNodeManager(
        builder: (context, focusNode) {
          return KeyboardNavigator(
            focusNode: focusNode,
            child: mainApp(context),
          );
        },
      );
    }
    return mainApp(context);
  }

  Widget mainApp(BuildContext context) {
    return Consumer<NavigationEntity>(
      builder: (_, navigationEntity, __) {
        return MaterialApp(
          navigatorObservers: [navigationEntity],
          title: 'Peacock and Quill',
          theme: Style.defaultTheme(context),
          onGenerateRoute: onGenerateRouteHandler,
          builder: (context, navigator) {
            return LayoutTemplate(
              navigator: navigator as Navigator,
            );
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
