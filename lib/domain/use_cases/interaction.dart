import 'package:flutter/material.dart';
import 'package:peacock_and_quill/data/repositories/firestore/i_presentation_repository.dart';
import 'package:peacock_and_quill/domain/providers/locator.dart';

enum SlideDirection { left, right }

mixin Interaction {
  final IPresentationRepository presentationRepository =
      locator<IPresentationRepository>();
  int lastSlide = -1;
  double lastStep = 0;
  SlideDirection slideDirection = SlideDirection.right;

  /// Sync the presenter slide changes with all devices.
  void syncToDevices(PageController pageController) {
    final page = pageController.page;

    _setSlideDirection(page);

    final currentSlide = _eagerlyDecidePageNumber(page);

    if (lastSlide != currentSlide) {
      lastSlide = currentSlide;

      // Divide, returning an integer result
      presentationRepository.updateSlide(currentSlide);
    }
  }

  /// Decide whether they're moving left or right.
  void _setSlideDirection(double page) {
    slideDirection =
        (lastStep < page) ? SlideDirection.right : SlideDirection.left;
    lastStep = page;
  }

  /// Get the next whole number in the direction the user's moving.
  int _eagerlyDecidePageNumber(double page) =>
      (slideDirection == SlideDirection.right) ? page.ceil() : page.floor();
}
