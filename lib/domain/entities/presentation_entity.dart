import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/domain/entities/interfaces/i_presentation_entity.dart';

class PresentationEntity extends IPresentationEntity {
  int currentSlide;
  int initialSlide;

  PresentationEntity({
    @required this.currentSlide,
    @required this.initialSlide,
  });
}
