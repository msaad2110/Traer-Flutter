
import 'package:json_annotation/json_annotation.dart';
part 'order_history_model.g.dart';

@JsonSerializable()
class OrderHistoryModel {
  bool? success;
  String? message;
  List<Data>? data;

  OrderHistoryModel({this.success, this.message, this.data});


  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) => _$OrderHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderHistoryModelToJson(this);

}

@JsonSerializable()
class Data {
  int? id;
  int? trip_id;
  int? luggage_type_id;
  int? product_space;
  int? product_value;
  String? description;
  int? is_insured;
  int? created_by_id;
  int? updated_by_id;
  String? created_at;
  String? updated_at;
  String? deleted_by_id;
  String? deleted_at;
  Trip? trip;

  Data(
      this.id,
      this.trip_id,
      this.luggage_type_id,
      this.product_space,
      this.product_value,
      this.description,
      this.is_insured,
      this.created_by_id,
      this.updated_by_id,
      this.created_at,
      this.updated_at,
      this.deleted_by_id,
      this.deleted_at,
      this.trip);


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class Trip {
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
  Object? deleted_by_id;
  Object? deleted_at;

  Trip(
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

  factory Trip.fromJson(Map<String, dynamic> json) => _$TripFromJson(json);
  Map<String, dynamic> toJson() => _$TripToJson(this);
}