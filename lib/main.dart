import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';
import 'package:peacock_and_quill/state/provider.dart';
import 'package:peacock_and_quill/presentation/routing/navigation_interceptor.dart';
import 'package:peacock_and_quill/presentation/routing/router.dart';
import 'package:peacock_and_quill/presentation/components/keyboard_navigator.dart';
import 'package:peacock_and_quill/presentation/style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(PeacockAndQuill());
}

class PeacockAndQuill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
      child: _enableKeyboardForWeb(context),
    );
  }

  Widget _enableKeyboardForWeb(BuildContext context) {
    return Consumer<KeyPressNotifier>(
      builder: (context, keyPressNotifier, __) {
        return (kIsWeb)
            ? KeyboardNavigator(
                keyPressNotifier: keyPressNotifier,
                child: _mainApp(context),
              )
            : _mainApp(context);
      },
    );
  }

  Widget _mainApp(BuildContext context) {
    return Consumer<NavigationInterceptor>(
      builder: (context, navigationInterceptor, _) {
        return MaterialApp(
          navigatorObservers: [
            if (navigationInterceptor?.navigator != null) navigationInterceptor
          ],
          title: 'Peacock and Quill',
          theme: Style.defaultTheme(context),
          onGenerateRoute: (settings) {
            return onGenerateRouteHandler(context, settings);
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
