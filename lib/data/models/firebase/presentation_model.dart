import 'dart:convert';

import 'package:peacock_and_quill/domain/entities/interfaces/i_presentation_entity.dart';

class PresentationModel extends IPresentationEntity {
  int currentSlide;
  int initialSlide;

  PresentationModel({
    this.currentSlide,
    this.initialSlide,
  });

  factory PresentationModel.fromRawJson(String str) =>
      PresentationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PresentationModel.fromJson(Map<String, dynamic> json) =>
      PresentationModel(
        currentSlide: json["currentSlide"],
        initialSlide: json["initialSlide"],
      );

  Map<String, dynamic> toJson() => {
        "currentSlide": currentSlide,
      };
}
