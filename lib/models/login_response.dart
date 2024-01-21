import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable(includeIfNull: true )
class LoginResponse{
  bool? success;
  String? message;
  Data? data;

  LoginResponse({this.success, this.message, this.data});


  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Data {
  String? token;
  User? user;

  Data({ this.token,  this.user});


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable(includeIfNull: true)
class User {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? country;
  Object? email_verified_at;
  String? created_at;
  String? updated_at;
  int? is_traveller;

  User(
      { this.id,
         this.first_name,
          this.last_name,
         this.email,
         this.phone,
         this.country,
         this.email_verified_at,
         this.created_at,
         this.updated_at,
         this.is_traveller});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}