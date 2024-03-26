import 'package:json_annotation/json_annotation.dart';
part 'country_response.g.dart';

@JsonSerializable()
class CountryResponse{
  bool? success;
  String? message;
  List<Data>? data;


  CountryResponse(this.success, this.message, this.data);

  factory CountryResponse.fromJson(Map<String, dynamic> json) => _$CountryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);
}


@JsonSerializable()
class Data {
  List<Countries>? countries;

  Data({this.countries});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);

}

@JsonSerializable()
class Countries {
  String? country_name;
  String? country_short_name;
  int? country_phone_code;

  Countries({this.country_name, this.country_short_name, this.country_phone_code});

  factory Countries.fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);
  Map<String, dynamic> toJson() => _$CountriesToJson(this);


}