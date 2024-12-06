// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as int?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['country'] as String?,
      json['is_traveller'] as int?,
      json['is_verified'] as int?,
      json['email_verified_at'],
      json['created_at'] as String?,
      json['deleted_by_id'],
      json['deleted_at'],
      json['updated_at'] as String?,
      json['stripe_id'],
      json['pm_type'],
      json['pm_last_four'],
      json['trial_ends_at'],
      json['verified_at'],
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'country': instance.country,
      'is_traveller': instance.is_traveller,
      'is_verified': instance.is_verified,
      'email_verified_at': instance.email_verified_at,
      'created_at': instance.created_at,
      'deleted_by_id': instance.deleted_by_id,
      'deleted_at': instance.deleted_at,
      'updated_at': instance.updated_at,
      'stripe_id': instance.stripe_id,
      'pm_type': instance.pm_type,
      'pm_last_four': instance.pm_last_four,
      'trial_ends_at': instance.trial_ends_at,
      'verified_at': instance.verified_at,
    };
