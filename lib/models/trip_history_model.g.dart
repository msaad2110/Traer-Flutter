// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TripHistoryModel _$TripHistoryModelFromJson(Map<String, dynamic> json) =>
    TripHistoryModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TripHistoryModelToJson(TripHistoryModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as int?,
      json['luggage_type_id'] as int?,
      json['travelling_from'] as String?,
      json['travelling_to'] as String?,
      json['start_date'] as String?,
      json['start_time'] as String?,
      json['end_date'] as String?,
      json['end_time'] as String?,
      json['luggage_space'] as String?,
      json['commission'] as int?,
      json['created_by_id'] as int?,
      json['updated_by_id'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_by_id'] as String?,
      json['deleted_at'] as String?,
      json['luggage_type'] == null
          ? null
          : LuggageType.fromJson(json['luggage_type'] as Map<String, dynamic>),
      json['created_by'] == null
          ? null
          : CreatedBy.fromJson(json['created_by'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'luggage_type_id': instance.luggage_type_id,
      'travelling_from': instance.travelling_from,
      'travelling_to': instance.travelling_to,
      'start_date': instance.start_date,
      'start_time': instance.start_time,
      'end_date': instance.end_date,
      'end_time': instance.end_time,
      'luggage_space': instance.luggage_space,
      'commission': instance.commission,
      'created_by_id': instance.created_by_id,
      'updated_by_id': instance.updated_by_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_by_id': instance.deleted_by_id,
      'deleted_at': instance.deleted_at,
      'luggage_type': instance.luggage_type,
      'created_by': instance.created_by,
    };

LuggageType _$LuggageTypeFromJson(Map<String, dynamic> json) => LuggageType(
      json['id'] as int?,
      json['name'] as String?,
    );

Map<String, dynamic> _$LuggageTypeToJson(LuggageType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

CreatedBy _$CreatedByFromJson(Map<String, dynamic> json) => CreatedBy(
      json['id'] as int?,
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['phone'] as String?,
      json['country'] as String?,
      json['is_traveller'] as int?,
      json['is_verified'] as int?,
      json['stripe_id'] as String?,
      json['pm_type'] as String?,
      json['pm_last_four'] as String?,
      json['profile_picture'] == null
          ? null
          : ProfilePicture.fromJson(
              json['profile_picture'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatedByToJson(CreatedBy instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'email': instance.email,
      'phone': instance.phone,
      'country': instance.country,
      'is_traveller': instance.is_traveller,
      'is_verified': instance.is_verified,
      'stripe_id': instance.stripe_id,
      'pm_type': instance.pm_type,
      'pm_last_four': instance.pm_last_four,
      'profile_picture': instance.profile_picture,
    };

ProfilePicture _$ProfilePictureFromJson(Map<String, dynamic> json) =>
    ProfilePicture(
      json['id'] as int?,
      json['document_type_id'] as int?,
      json['user_id'] as int?,
      json['name'] as String?,
      json['file_name'] as String?,
      json['file_path'] as String?,
      json['file_preview_path'] as String?,
    );

Map<String, dynamic> _$ProfilePictureToJson(ProfilePicture instance) =>
    <String, dynamic>{
      'id': instance.id,
      'document_type_id': instance.document_type_id,
      'user_id': instance.user_id,
      'name': instance.name,
      'file_name': instance.file_name,
      'file_path': instance.file_path,
      'file_preview_path': instance.file_preview_path,
    };
