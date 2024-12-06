import 'package:json_annotation/json_annotation.dart';
part 'order_status.g.dart';

@JsonSerializable()
class OrderStatusModel {
  bool? success;
  String? message;
  List<Data>? data;

  OrderStatusModel({this.success, this.message, this.data});

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) => _$OrderStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusModelToJson(this);

}

@JsonSerializable()
class Data {
  List<OrderStatus>? order_status;

  Data({this.order_status});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class OrderStatus {
  int? value;
  String? label;
  bool isSelected = false;

  OrderStatus({this.value, this.label,this.isSelected = false});

  factory OrderStatus.fromJson(Map<String, dynamic> json) => _$OrderStatusFromJson(json);
  Map<String, dynamic> toJson() => _$OrderStatusToJson(this);
}