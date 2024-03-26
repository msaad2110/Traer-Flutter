import 'package:json_annotation/json_annotation.dart';
part 'general_response.g.dart';

@JsonSerializable()
class GeneralResponse{
  bool? success;
  String? message;
  String? data;


  GeneralResponse({this.success, this.message, this.data});

  factory GeneralResponse.fromJson(Map<String, dynamic> json) => _$GeneralResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralResponseToJson(this);

}