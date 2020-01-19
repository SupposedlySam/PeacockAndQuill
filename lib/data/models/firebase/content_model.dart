// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

class ContentModel extends IContentEntity {
  List<IContentDataEntity> data;
  int order;
  String presentationId;
  String uid;

  ContentModel({
    this.data,
    this.order,
    this.presentationId,
    this.uid,
  });

  factory ContentModel.fromRawJson(String str) =>
      ContentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      data: json["data"].map((x) {
        return ContentData.fromJson(x);
      }),
      order: json["order"],
      presentationId: json["presentationId"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data":
            List<dynamic>.from(data.map((x) => (x as ContentData).toJson())),
        "order": order,
        "presentationId": presentationId,
        "uid": uid,
      };
}

class ContentData extends IContentDataEntity {
  String type;
  String value;

  ContentData({
    this.type,
    this.value,
  });

  factory ContentData.fromRawJson(String str) =>
      ContentData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
