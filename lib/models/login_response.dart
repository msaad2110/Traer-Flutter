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
  int? is_verified;
  String? stripe_id;
  String? pm_type;
  String? pm_last_four;
  String? trial_ends_at;
  ProfilePicture? profile_picture;


  User(
      this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.country,
      this.email_verified_at,
      this.created_at,
      this.updated_at,
      this.is_traveller,
      this.is_verified,
      this.stripe_id,
      this.pm_type,
      this.pm_last_four,
      this.trial_ends_at,
      this.profile_picture);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}


@JsonSerializable(includeIfNull: true)
class ProfilePicture {
  final int id;
  final int document_type_id;
  final int user_id;
  final String name;
  final String file_name;
  final String file_path;
  final String file_preview_path;
  final String created_at;
  final String updated_at;
  final String? deleted_at;


  ProfilePicture(
      this.id,
      this.document_type_id,
      this.user_id,
      this.name,
      this.file_name,
      this.file_path,
      this.file_preview_path,
      this.created_at,
      this.updated_at,
      this.deleted_at);

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => _$ProfilePictureFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}