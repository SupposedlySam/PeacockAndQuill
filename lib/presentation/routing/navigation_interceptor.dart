import 'package:flutter/material.dart';

class NavigationInterceptor extends NavigatorObserver {
  @override
  void didPop(Route route, Route previousRoute) {
    // Your code to run in this callback
  }

  @override
  void didPush(Route route, Route previousRoute) {
    // Your code to run in this callback
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    // Your code to run in this callback
  }

  @override
  void didReplace({Route newRoute, Route oldRoute}) {
    // Your code to run in this callback
  }

  @override
  void didStartUserGesture(Route route, Route previousRoute) {
    // Your code to run in this callback
  }

  @override
  void didStopUserGesture() {
    // Your code to run in this callback
  }
}
