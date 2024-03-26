import 'package:json_annotation/json_annotation.dart';
part 'city_response.g.dart';

@JsonSerializable()
class CityResponse{
  bool? success;
  String? message;
  List<Data>? data;

  CityResponse(this.success, this.message, this.data);

  factory CityResponse.fromJson(Map<String, dynamic> json) => _$CityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CityResponseToJson(this);

}


@JsonSerializable()
class Data {
  List<Cities>? cities;

  Data({this.cities});


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class Cities {
  String? city_name;

  Cities({this.city_name});


  factory Cities.fromJson(Map<String, dynamic> json) => _$CitiesFromJson(json);
  Map<String, dynamic> toJson() => _$CitiesToJson(this);

}