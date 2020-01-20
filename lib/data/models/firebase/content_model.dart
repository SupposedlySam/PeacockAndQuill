// To parse this JSON data, do
//
//     final contentModel = contentModelFromJson(jsonString);

import 'dart:convert';

import 'package:peacock_and_quill/domain/entities/interfaces/i_content_entity.dart';

class ContentModel implements IContentEntity {
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

  factory ContentModel.fromRawJson(String str) {
    return ContentModel.fromJson(json.decode(str));
  }

  String toRawJson() => json.encode(toJson());

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    final dynamic data = json["data"];
    final List<ContentData> contentData = data.map<ContentData>((x) {
      return ContentData.fromJson(x.cast<String, dynamic>());
    }).toList();
    final dataList = List<ContentData>.from(contentData);

    return ContentModel(
      data: dataList,
      order: json["order"],
      presentationId: json["presentationId"],
      uid: json["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": (data as ContentData).toJson(),
        "order": order,
        "presentationId": presentationId,
        "uid": uid,
      };
}

class ContentData implements IContentDataEntity {
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
