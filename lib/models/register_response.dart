import 'package:json_annotation/json_annotation.dart';
part 'register_response.g.dart';

@JsonSerializable(includeIfNull: true)
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
  String? first_name;
  String? last_name;
  String? country;
  String? phone;
  String? email;
  String? updated_at;
  String? created_at;
  int? id;
  String? is_traveller;


  User(this.first_name, this.last_name, this.country, this.phone, this.email,
      this.updated_at, this.created_at, this.id, this.is_traveller);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}