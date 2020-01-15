import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/domain/providers/provider.dart';
import 'package:peacock_and_quill/domain/routing/navigation_entity.dart';
import 'package:peacock_and_quill/domain/routing/router.dart';
import 'package:peacock_and_quill/presentation/components/keyboard_navigator.dart';
import 'package:peacock_and_quill/presentation/components/lifecycle_managers/focus_node_manager.dart';
import 'package:peacock_and_quill/presentation/style.dart';
import 'package:peacock_and_quill/presentation/views/layout_template/layout_template.dart';
import 'package:provider/provider.dart';

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
