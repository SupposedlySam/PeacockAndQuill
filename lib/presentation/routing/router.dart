import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_view.dart';
import 'package:peacock_and_quill/presentation/views/public_view/public_view.dart';
import 'package:provider/provider.dart';

Route<dynamic> onGenerateRouteHandler(RouteSettings settings) {
  switch (settings.name) {
    default:
      return _getPageRoute(Consumer<FirebaseUser>(builder: (context, user, __) {
        return user != null || kIsWeb ? PresenterView() : PublicView();
      }), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return FadeRoute(child: child, routeName: settings.name);
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            context,
            animation,
            secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            context,
            animation,
            secondaryAnimation,
            child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
