import 'package:json_annotation/json_annotation.dart';
part 'user_profile.g.dart';

@JsonSerializable()
class UserProfile {
  bool? success;
  String? message;
  List<Data>? data;

  UserProfile({this.success, this.message, this.data});

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}

@JsonSerializable()
class Data {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? country;
  int? is_traveller;
  int? is_verified;
  Object? email_verified_at;
  String? created_at;
  Object? deleted_by_id;
  Object? deleted_at;
  String? updated_at;
  Object? stripe_id;
  Object? pm_type;
  Object? pm_last_four;
  Object? trial_ends_at;
  Object? verified_at;


  Data(
      this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.country,
      this.is_traveller,
      this.is_verified,
      this.email_verified_at,
      this.created_at,
      this.deleted_by_id,
      this.deleted_at,
      this.updated_at,
      this.stripe_id,
      this.pm_type,
      this.pm_last_four,
      this.trial_ends_at,
      this.verified_at);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}