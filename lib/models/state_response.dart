import 'package:json_annotation/json_annotation.dart';
part 'state_response.g.dart';

@JsonSerializable()
class StateResponse{
  bool? success;
  String? message;
  List<Data>? data;

  StateResponse(this.success, this.message, this.data);

  factory StateResponse.fromJson(Map<String, dynamic> json) => _$StateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StateResponseToJson(this);
}

@JsonSerializable()
class Data {
  List<States>? states;

  Data({this.states});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class States {
  String? state_name;

  States({this.state_name});

  factory States.fromJson(Map<String, dynamic> json) => _$StatesFromJson(json);
  Map<String, dynamic> toJson() => _$StatesToJson(this);
}