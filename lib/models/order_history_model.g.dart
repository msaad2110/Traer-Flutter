// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderHistoryModel _$OrderHistoryModelFromJson(Map<String, dynamic> json) =>
    OrderHistoryModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderHistoryModelToJson(OrderHistoryModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      json['id'] as int?,
      json['trip_id'] as int?,
      json['luggage_type_id'] as int?,
      json['product_space'] as int?,
      json['product_value'] as int?,
      json['description'] as String?,
      json['is_insured'] as int?,
      json['created_by_id'] as int?,
      json['updated_by_id'] as int?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['deleted_by_id'] as String?,
      json['deleted_at'] as String?,
      json['trip'] == null
          ? null
          : Trip.fromJson(json['trip'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'trip_id': instance.trip_id,
      'luggage_type_id': instance.luggage_type_id,
      'product_space': instance.product_space,
      'product_value': instance.product_value,
      'description': instance.description,
      'is_insured': instance.is_insured,
      'created_by_id': instance.created_by_id,
      'updated_by_id': instance.updated_by_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'deleted_by_id': instance.deleted_by_id,
      'deleted_at': instance.deleted_at,
      'trip': instance.trip,
    };

Trip _$TripFromJson(Map<String, dynamic> json) => Trip(
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
      json['deleted_by_id'],
      json['deleted_at'],
    );

Map<String, dynamic> _$TripToJson(Trip instance) => <String, dynamic>{
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
