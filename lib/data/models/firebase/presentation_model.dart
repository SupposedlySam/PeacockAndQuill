import 'dart:convert';

class PresentationModel {
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
