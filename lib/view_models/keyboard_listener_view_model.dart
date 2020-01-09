import 'package:flutter/material.dart';

class KeyboardListenerViewModel extends ChangeNotifier {
  List<VoidCallback> onNext;
  List<VoidCallback> onPrev;
  bool _isFullscreen = false;

  bool get isFullscreen => _isFullscreen;

  void setFullscreen({bool value}) {
    _isFullscreen = value;
    notifyListeners();
  }

  void triggerNext() => onNext.forEach((callback) => callback());
  void triggerPrev() => onPrev.forEach((callback) => callback());
}
