import 'package:json_annotation/json_annotation.dart';
part 'all_luggagetype.g.dart';

@JsonSerializable()
class AllLuggageType{
  bool? success;
  String? message;
  List<Data>? data;


  AllLuggageType({this.success, this.message, this.data});

  factory AllLuggageType.fromJson(Map<String, dynamic> json) => _$AllLuggageTypeFromJson(json);
  Map<String, dynamic> toJson() => _$AllLuggageTypeToJson(this);

}

@JsonSerializable()
class Data {
  int? id;
  String? name;
  String? created_at;
  String? updated_at;
  Object? deleted_at;

  Data({this.id, this.name, this.created_at, this.updated_at, this.deleted_at});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}