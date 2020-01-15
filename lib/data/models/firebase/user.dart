import 'dart:convert';

class User {
  String uid;
  String name;
  String email;
  bool isAnonymous;
  DateTime createdAt;

  User({
    this.uid,
    this.name,
    this.email,
    this.isAnonymous,
    this.createdAt,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
