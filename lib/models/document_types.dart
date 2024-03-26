import 'package:json_annotation/json_annotation.dart';
part 'document_types.g.dart';

@JsonSerializable()
class DocumentType{
  bool? success;
  String? message;
  List<Data>? data;

  DocumentType({this.success, this.message, this.data});

  factory DocumentType.fromJson(Map<String, dynamic> json) => _$DocumentTypeFromJson(json);
  Map<String, dynamic> toJson() => _$DocumentTypeToJson(this);
}
@JsonSerializable()
class Data {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data({this.id, this.name, this.createdAt, this.updatedAt, this.deletedAt});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}



