// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.token,
    required this.uid,
    required this.usertype,
    required this.email,
    required this.mobile,
    required this.name,
    required this.check,
  });

  String token;
  String uid;
  String usertype;
  String email;
  String mobile;
  String name;
  String check;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    token: json["token"],
    uid: json["uid"],
    usertype: json["usertype"],
    email: json["email"],
    mobile: json["mobile"],
    name: json["name"],
    check: json["check"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "uid": uid,
    "usertype": usertype,
    "email": email,
    "mobile": mobile,
    "name": name,
    "check": check,
  };
}
