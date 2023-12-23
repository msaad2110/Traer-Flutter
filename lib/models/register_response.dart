import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse{
  bool? success;
  String? message;
  Data? data;

  RegisterResponse({this.success, this.message, this.data});


  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

@JsonSerializable()
class Data {
  User? user;
  String? token;

  Data({this.user, this.token});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class User {
  String? firstName;
  String? lastName;
  String? country;
  String? phone;
  String? email;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.firstName,
        this.lastName,
        this.country,
        this.phone,
        this.email,
        this.updatedAt,
        this.createdAt,
        this.id});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}