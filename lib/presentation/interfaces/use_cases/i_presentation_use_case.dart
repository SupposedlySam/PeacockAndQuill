import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

abstract class IPresentationUseCase {
  void syncToDevices(PageController pageController);
  Future<int> getInitialSlide();
  Future<int> getCurrentSlide();
  Stream<IPresentationEntity> getPresentationStream();
}
