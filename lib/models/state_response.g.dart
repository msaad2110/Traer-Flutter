// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateResponse _$StateResponseFromJson(Map<String, dynamic> json) =>
    StateResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StateResponseToJson(StateResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      states: (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'states': instance.states,
    };

States _$StatesFromJson(Map<String, dynamic> json) => States(
      state_name: json['state_name'] as String?,
    );

Map<String, dynamic> _$StatesToJson(States instance) => <String, dynamic>{
      'state_name': instance.state_name,
    };
