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
      json['end_date'] as String?,
      json['luggage_space'] as String?,
      json['commission'] as int?,
      json['created_by_id'] as int?,
      json['updated_by_id'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_by_id'] as String?,
      json['deleted_at'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'luggage_type_id': instance.luggage_type_id,
      'travelling_from': instance.travelling_from,
      'travelling_to': instance.travelling_to,
      'start_date': instance.start_date,
      'end_date': instance.end_date,
      'luggage_space': instance.luggage_space,
      'commission': instance.commission,
      'created_by_id': instance.created_by_id,
      'updated_by_id': instance.updated_by_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_by_id': instance.deleted_by_id,
      'deleted_at': instance.deleted_at,
    };
