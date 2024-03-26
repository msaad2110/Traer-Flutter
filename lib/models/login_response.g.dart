// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      token: json['token'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['country'] as String?,
      json['email_verified_at'],
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['is_traveller'] as int?,
      json['is_verified'] as int?,
      json['stripe_id'] as String?,
      json['pm_type'] as String?,
      json['pm_last_four'] as String?,
      json['trial_ends_at'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'country': instance.country,
      'email_verified_at': instance.email_verified_at,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'is_traveller': instance.is_traveller,
      'is_verified': instance.is_verified,
      'stripe_id': instance.stripe_id,
      'pm_type': instance.pm_type,
      'pm_last_four': instance.pm_last_four,
      'trial_ends_at': instance.trial_ends_at,
    };
