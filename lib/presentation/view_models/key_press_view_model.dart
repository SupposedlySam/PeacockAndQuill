import 'package:flutter/material.dart';
import 'package:peacock_and_quill/presentation/view_models/key_press_notifier.dart';

class KeyPressViewModel extends ChangeNotifier {
  static const Duration duration = Duration(milliseconds: 300);
  static const Curve curve = Curves.ease;
  final KeyPressNotifier keyPressNotifier;
  final PageController _pageController = PageController();
  PageController get controller => _pageController;

  KeyPressViewModel({
    @required this.keyPressNotifier,
  });

  void init() {
    keyPressNotifier..onNext.add(handleNext)..onPrev.add(handlePrev);
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

  void navigateToSlide(int slide) {
    _pageController.animateToPage(
      slide,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    keyPressNotifier..onNext.clear()..onPrev.clear();
    _pageController.dispose();
    super.dispose();
  }
}
