
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
  String? tracking_number;
  int? is_insured;
  int? created_by_id;
  int? updated_by_id;
  String? created_at;
  String? updated_at;
  String? deleted_by_id;
  String? deleted_at;
  Trip? trip;
  CreatedBy? created_by;


  Data(
      this.id,
      this.trip_id,
      this.luggage_type_id,
      this.product_space,
      this.product_value,
      this.description,
      this.tracking_number,
      this.is_insured,
      this.created_by_id,
      this.updated_by_id,
      this.created_at,
      this.updated_at,
      this.deleted_by_id,
      this.deleted_at,
      this.trip,
      this.created_by);

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

@JsonSerializable()
class CreatedBy {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? country;
  int? is_traveller;
  int? is_verified;
  String? stripe_id;
  String? pm_type;
  String? pm_last_four;
  ProfilePicture? profile_picture;


  CreatedBy(this.id,
      this.first_name,
      this.last_name,
      this.email,
      this.phone,
      this.country,
      this.is_traveller,
      this.is_verified,
      this.stripe_id,
      this.pm_type,
      this.pm_last_four,
      this.profile_picture);

  factory CreatedBy.fromJson(Map<String, dynamic> json) =>
      _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);

}

@JsonSerializable(includeIfNull: true)
class ProfilePicture {
  int? id;
  int? document_type_id;
  int? user_id;
  String? name;
  String? file_name;
  String? file_path;
  String? file_preview_path;


  ProfilePicture(this.id, this.document_type_id, this.user_id, this.name,
      this.file_name, this.file_path, this.file_preview_path);

  factory ProfilePicture.fromJson(Map<String, dynamic> json) => _$ProfilePictureFromJson(json);
  Map<String, dynamic> toJson() => _$ProfilePictureToJson(this);
}