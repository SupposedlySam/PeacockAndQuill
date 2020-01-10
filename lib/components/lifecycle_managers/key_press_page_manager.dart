import 'package:flutter/material.dart';
import 'package:peacock_and_quill/locator.dart';
import 'package:peacock_and_quill/view_models/key_press_notifier.dart';

typedef PageBuilder = Widget Function(BuildContext, PageController);

class KeyPressPageManager extends StatefulWidget {
  const KeyPressPageManager({@required this.builder});

  final PageBuilder builder;

  @override
  _KeyPressPageManagerState createState() => _KeyPressPageManagerState();
}

class _KeyPressPageManagerState extends State<KeyPressPageManager> {
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.ease;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    locator<KeyPressNotifier>()..onNext.add(handleNext)..onPrev.add(handlePrev);
  }

  void handleNext() {
    _pageController.nextPage(
      duration: duration,
      curve: curve,
    );
  }

  void handlePrev() {
    _pageController.previousPage(
      duration: duration,
      curve: curve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _pageController);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
