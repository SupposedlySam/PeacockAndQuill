import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:peacock_and_quill/presentation/interfaces/entities/i_presentation_entity.dart';

class PresentationModel implements IPresentationEntity {
  int currentSlide;
  int initialSlide;
  bool isActive;
  String title;
  String refId;

  PresentationModel({
    @required this.refId,
    this.currentSlide,
    this.initialSlide,
    this.isActive = false,
    this.title,
  });

  factory PresentationModel.fromRawJson(String str) =>
      PresentationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PresentationModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return PresentationModel(
      title: json["title"] ?? 'Mystery Title',
      currentSlide: json["currentSlide"],
      initialSlide: json["initialSlide"],
      isActive: json["isActive"],
      refId: json["refId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "currentSlide": currentSlide,
        "initialSlide": initialSlide,
        "isActive": isActive,
      };
}
