import 'dart:convert';

import 'package:peacock_and_quill/domain/entities/interfaces/i_question_entity.dart';

class QuestionModel implements IQuestionEntity {
  ISelectionEntity selection;
  String presentationId;
  String uid;

  QuestionModel({
    this.selection,
    this.presentationId,
    this.uid,
  });

  factory QuestionModel.fromRawJson(String str) =>
      QuestionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        selection:
            SelectionModel.fromJson(json["selection"].cast<String, dynamic>()),
        presentationId: json["presentationId"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "selection": (selection as SelectionModel).toJson(),
        "presentationId": presentationId,
        "uid": uid,
      };
}

class SelectionModel implements ISelectionEntity {
  int paragraph;
  int slide;

  SelectionModel({
    this.paragraph,
    this.slide,
  });

  factory SelectionModel.fromRawJson(String str) =>
      SelectionModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SelectionModel.fromJson(Map<String, dynamic> json) => SelectionModel(
        paragraph: json["paragraph"],
        slide: json["slide"],
      );

  Map<String, dynamic> toJson() => {
        "paragraph": paragraph,
        "slide": slide,
      };
}
