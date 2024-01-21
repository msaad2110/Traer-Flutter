import 'package:json_annotation/json_annotation.dart';
part 'trip_history_model.g.dart';

@JsonSerializable()
class TripHistoryModel {
  bool? success;
  String? message;
  List<Data>? data;

  TripHistoryModel({this.success, this.message, this.data});


  factory TripHistoryModel.fromJson(Map<String, dynamic> json) => _$TripHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$TripHistoryModelToJson(this);
}

@JsonSerializable()
class Data {
  int? id;
  int? luggage_type_id;
  String? travelling_from;
  String? travelling_to;
  String? start_date;
  String? end_date;
  String? luggage_space;
  int? commission;
  int? created_by_id;
  int? updated_by_id;
  String? created_at;
  String? updated_at;
  String? deleted_by_id;
  String? deleted_at;

  Data(
      this.id,
      this.luggage_type_id,
      this.travelling_from,
      this.travelling_to,
      this.start_date,
      this.end_date,
      this.luggage_space,
      this.commission,
      this.created_by_id,
      this.updated_by_id,
      this.created_at,
      this.updated_at,
      this.deleted_by_id,
      this.deleted_at);

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}