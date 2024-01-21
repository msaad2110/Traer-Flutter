// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponse _$RegisterResponseFromJson(Map<String, dynamic> json) =>
    RegisterResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseToJson(RegisterResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['country'] as String?,
      json['phone'] as String?,
      json['email'] as String?,
      json['updated_at'] as String?,
      json['created_at'] as String?,
      json['id'] as int?,
      json['is_traveller'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'country': instance.country,
      'phone': instance.phone,
      'email': instance.email,
      'updated_at': instance.updated_at,
      'created_at': instance.created_at,
      'id': instance.id,
      'is_traveller': instance.is_traveller,
    };
