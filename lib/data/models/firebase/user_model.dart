import 'dart:convert';

import 'package:peacock_and_quill/domain/entities/interfaces/i_user_entity.dart';

class UserModel implements IUserEntity {
  String uid;
  String name;
  String email;
  bool isAnonymous;
  DateTime createdAt;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.isAnonymous,
    this.createdAt,
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
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "isAnonymous": isAnonymous,
        "createdAt": createdAt.toString(),
      };
}
