import 'package:flutter/material.dart';

mixin Interaction {
  /// Sync the presenter slide changes with all devices.
  int syncToDevices(PageController pageController) {
    final page = pageController.page;

    final indexFromStep = page ~/ .5;

    print(indexFromStep);

    // Divide, returning an integer result
    return indexFromStep;
  }
}
