import 'dart:convert';

import 'package:peacock_and_quill/presentation/interfaces/entities/i_user_entity.dart';

class UserModel implements IUserEntity {
  String uid;
  String name;
  String email;
  bool isAnonymous;
  DateTime createdAt;
  String activePresentation;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.isAnonymous,
    this.createdAt,
    this.activePresentation,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
      isAnonymous: json["isAnonymous"] == 'true',
      createdAt: DateTime.parse(json["createdAt"]),
      activePresentation: json['activePresentation']);

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "isAnonymous": isAnonymous,
        "createdAt": createdAt.toString(),
        "activePresentation": activePresentation,
      };
}
