import 'package:flutter/widgets.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

class PresentationEntity implements IPresentationEntity {
  int currentSlide;
  int initialSlide;
  bool isActive;
  String title;
  String refId;

  PresentationEntity({
    @required this.currentSlide,
    @required this.initialSlide,
    @required this.title,
    @required this.refId,
    this.isActive = false,
  });
}
