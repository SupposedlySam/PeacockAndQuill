import 'dart:convert';

import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

class PresentationModel implements IPresentationEntity {
  int currentSlide;
  int initialSlide;
  bool isActive;

  PresentationModel({
    this.currentSlide,
    this.initialSlide,
    this.isActive = false,
  });

  factory PresentationModel.fromRawJson(String str) =>
      PresentationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PresentationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PresentationModel(
      currentSlide: json["currentSlide"],
      initialSlide: json["initialSlide"],
      isActive: json["isActive"],
    );
  }

  Map<String, dynamic> toJson() => {
        "currentSlide": currentSlide,
        "initialSlide": initialSlide,
        "isActive": isActive,
      };
}
