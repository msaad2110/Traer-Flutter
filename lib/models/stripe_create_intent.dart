
import 'package:json_annotation/json_annotation.dart';
part 'stripe_create_intent.g.dart';

@JsonSerializable()
class StripeCreateIntent{
  bool? success;
  String? message;
  Data? data;


  StripeCreateIntent({this.success, this.message, this.data});

  factory StripeCreateIntent.fromJson(Map<String, dynamic> json) => _$StripeCreateIntentFromJson(json);
  Map<String, dynamic> toJson() => _$StripeCreateIntentToJson(this);
}

@JsonSerializable()
class Data {
  String? id;
  String? object;
  Object? application;
  Object? automatic_payment_methods;
  Object? cancellation_reason;
  String? client_secret;
  int? created;
  String? customer;
  Object? description;
  Object? flow_directions;
  Object? last_setup_error;
  Object? latestAttempt;
  bool? livemode;
  Object? mandate;
  List<Object>? metadata;
  Object? next_action;
  Object? on_behalf_of;
  Object? payment_method;
  Object? payment_method_configuration_details;
  PaymentMethodOptions? payment_method_options;
  List<String>? payment_method_types;
  Object? single_use_mandate;
  String? status;
  String? usage;

  Data(
      {this.id,
        this.object,
        this.application,
        this.automatic_payment_methods,
        this.cancellation_reason,
        this.client_secret,
        this.created,
        this.customer,
        this.description,
        this.flow_directions,
        this.last_setup_error,
        this.latestAttempt,
        this.livemode,
        this.mandate,
        this.metadata,
        this.next_action,
        this.on_behalf_of,
        this.payment_method,
        this.payment_method_configuration_details,
        this.payment_method_options,
        this.payment_method_types,
        this.single_use_mandate,
        this.status,
        this.usage});


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class PaymentMethodOptions {
  Card? card;

  PaymentMethodOptions({this.card});

  factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) => _$PaymentMethodOptionsFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentMethodOptionsToJson(this);
}

@JsonSerializable()
class Card {
  Object? mandate_options;
  Object? network;
  String? request_three_d_secure;

  Card({this.mandate_options, this.network, this.request_three_d_secure});

  factory Card.fromJson(Map<String, dynamic> json) => _$CardFromJson(json);
  Map<String, dynamic> toJson() => _$CardToJson(this);
}