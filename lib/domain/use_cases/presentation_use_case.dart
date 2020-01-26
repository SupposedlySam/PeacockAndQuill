import 'package:flutter/material.dart';
import 'package:peacock_and_quill/domain/interfaces/i_presentation_repository.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';
import 'package:peacock_and_quill/presentation/interfaces/use_cases/i_presentation_use_case.dart';

enum SlideDirection { left, right }

class PresentationUseCase implements IPresentationUseCase {
  final IPresentationRepository presentationRepository;
  int lastSlide = -1;
  double lastStep = 0;
  SlideDirection slideDirection = SlideDirection.right;

  PresentationUseCase({@required this.presentationRepository});

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

  @override
  Stream<IPresentationEntity> getPresentationStream() {
    return presentationRepository.getPresentationStream();
  }

  @override
  Future<int> getInitialSlide() {
    return presentationRepository.getInitialSlide();
  }

  @override
  Future<int> getCurrentSlide() {
    return presentationRepository.getCurrentSlide();
  }
}
