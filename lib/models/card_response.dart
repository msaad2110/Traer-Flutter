import 'package:json_annotation/json_annotation.dart';
part 'card_response.g.dart';

@JsonSerializable()
class CardResponse {
  bool? success;
  String? message;
  List<Data>? data;

  CardResponse({this.success, this.message, this.data});

  factory CardResponse.fromJson(Map<String, dynamic> json) => _$CardResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CardResponseToJson(this);

}

@JsonSerializable()
class Data {
  String? id;
  String? object;
  String? allow_redisplay;
  BillingDetails? billing_details;
  CardModel? card;
  int? created;
  String? customer;
  bool? livemode;
  List<Object>? metadata;
  String? type;

  Data(
      {this.id,
        this.object,
        this.allow_redisplay,
        this.billing_details,
        this.card,
        this.created,
        this.customer,
        this.livemode,
        this.metadata,
        this.type});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class BillingDetails {
  Address? address;
  String? email;
  String? name;
  String? phone;

  BillingDetails({this.address, this.email, this.name, this.phone});

  factory BillingDetails.fromJson(Map<String, dynamic> json) => _$BillingDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$BillingDetailsToJson(this);
}

@JsonSerializable()
class Address {
  String? city;
  String? country;
  String? line1;
  String? line2;
  String? postal_code;
  String? state;

  Address(
      {this.city,
        this.country,
        this.line1,
        this.line2,
        this.postal_code,
        this.state});

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

}

@JsonSerializable()
class CardModel {
  String? brand;
  Checks? checks;
  String? country;
  String? display_brand;
  int? exp_month;
  int? exp_year;
  String? fingerprint;
  String? funding;
  Object? generated_from;
  String? last4;
  Networks? networks;
  ThreeDSecureUsage? three_d_secure_usage;
  Object? wallet;

  CardModel(
      {this.brand,
        this.checks,
        this.country,
        this.display_brand,
        this.exp_month,
        this.exp_year,
        this.fingerprint,
        this.funding,
        this.generated_from,
        this.last4,
        this.networks,
        this.three_d_secure_usage,
        this.wallet});

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
  Map<String, dynamic> toJson() => _$CardModelToJson(this);
}

@JsonSerializable()
class Checks {
  String? address_line1_check;
  String? address_postal_code_check;
  String? cvc_check;

  Checks({this.address_line1_check, this.address_postal_code_check, this.cvc_check});

  factory Checks.fromJson(Map<String, dynamic> json) => _$ChecksFromJson(json);
  Map<String, dynamic> toJson() => _$ChecksToJson(this);
}

@JsonSerializable()
class Networks {
  List<String>? available;
  Object? preferred;

  Networks({this.available, this.preferred});

  factory Networks.fromJson(Map<String, dynamic> json) => _$NetworksFromJson(json);
  Map<String, dynamic> toJson() => _$NetworksToJson(this);
}

@JsonSerializable()
class ThreeDSecureUsage {
  bool? supported;

  ThreeDSecureUsage({this.supported});

  factory ThreeDSecureUsage.fromJson(Map<String, dynamic> json) => _$ThreeDSecureUsageFromJson(json);
  Map<String, dynamic> toJson() => _$ThreeDSecureUsageToJson(this);
}