// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryResponse _$CountryResponseFromJson(Map<String, dynamic> json) =>
    CountryResponse(
      json['success'] as bool?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountryResponseToJson(CountryResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Countries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'countries': instance.countries,
    };

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      country_name: json['country_name'] as String?,
      country_short_name: json['country_short_name'] as String?,
      country_phone_code: json['country_phone_code'] as int?,
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'country_name': instance.country_name,
      'country_short_name': instance.country_short_name,
      'country_phone_code': instance.country_phone_code,
    };
