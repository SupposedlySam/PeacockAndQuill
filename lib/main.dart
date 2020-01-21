import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/domain/providers/provider.dart';
import 'package:peacock_and_quill/domain/routing/navigation_interceptor.dart';
import 'package:peacock_and_quill/domain/routing/router.dart';
import 'package:peacock_and_quill/presentation/components/keyboard_navigator.dart';
import 'package:peacock_and_quill/presentation/style.dart';

void main() {
  setupLocator();
  runApp(PeacockAndQuill());
}

class PeacockAndQuill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
      child: enableKeyboardForWeb(context),
    );
  }

  Widget enableKeyboardForWeb(BuildContext context) {
    return (kIsWeb)
        ? KeyboardNavigator(child: mainApp(context))
        : mainApp(context);
  }

  Widget mainApp(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [locator<NavigationInterceptor>()],
      title: 'Peacock and Quill',
      theme: kIsWeb ? Style.webTheme(context) : Style.defaultTheme(context),
      onGenerateRoute: onGenerateRouteHandler,
      debugShowCheckedModeBanner: false,
    );
  }
}
