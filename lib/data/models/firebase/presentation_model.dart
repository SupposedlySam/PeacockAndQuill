import 'dart:convert';

class PresentationModel {
  int currentSlide;

  PresentationModel({
    this.currentSlide,
  });

  factory PresentationModel.fromRawJson(String str) =>
      PresentationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PresentationModel.fromJson(Map<String, dynamic> json) =>
      PresentationModel(
        currentSlide: json["currentSlide"],
      );

  Map<String, dynamic> toJson() => {
        "currentSlide": currentSlide,
      };
}
