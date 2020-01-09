import 'package:flutter/material.dart';
import 'package:peacock_and_quill/config.dart';
import 'package:peacock_and_quill/models/navigation_entity.dart';
import 'package:peacock_and_quill/routing/router.dart';
import 'package:peacock_and_quill/view_models/keyboard_listener_view_model.dart';
import 'package:peacock_and_quill/views/layout_template/layout_template.dart';
import 'package:peacock_and_quill/widgets/keyboard_navigator.dart';
import 'package:provider/provider.dart';

import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: KeyboardListenerViewModel()),
      ],
      child: KeyboardNavigator(
        child: MaterialApp(
          navigatorObservers: [locator<NavigationEntity>()],
          title: 'Peacock and Quill',
          theme: Config.defaultTheme(context),
          onGenerateRoute: onGenerateRouteHandler,
          builder: (context, navigator) => LayoutTemplate(navigator: navigator),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
