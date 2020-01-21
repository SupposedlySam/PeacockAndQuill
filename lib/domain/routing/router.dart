import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';
import 'package:peacock_and_quill/presentation/views/presenter/presenter_view.dart';

Route<dynamic> onGenerateRouteHandler(RouteSettings settings) {
  switch (settings.name) {
    default:
      return _getPageRoute(
        HomeView(
          contentRepository: locator(),
          storageRepository: locator(),
        ),
        settings,
      );
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
