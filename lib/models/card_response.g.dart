// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardResponse _$CardResponseFromJson(Map<String, dynamic> json) => CardResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CardResponseToJson(CardResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      object: json['object'] as String?,
      allow_redisplay: json['allow_redisplay'] as String?,
      billing_details: json['billing_details'] == null
          ? null
          : BillingDetails.fromJson(
              json['billing_details'] as Map<String, dynamic>),
      card: json['card'] == null
          ? null
          : CardModel.fromJson(json['card'] as Map<String, dynamic>),
      created: json['created'] as int?,
      customer: json['customer'] as String?,
      livemode: json['livemode'] as bool?,
      metadata: (json['metadata'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'allow_redisplay': instance.allow_redisplay,
      'billing_details': instance.billing_details,
      'card': instance.card,
      'created': instance.created,
      'customer': instance.customer,
      'livemode': instance.livemode,
      'metadata': instance.metadata,
      'type': instance.type,
    };

BillingDetails _$BillingDetailsFromJson(Map<String, dynamic> json) =>
    BillingDetails(
      address: json['address'] == null
          ? null
          : Address.fromJson(json['address'] as Map<String, dynamic>),
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$BillingDetailsToJson(BillingDetails instance) =>
    <String, dynamic>{
      'address': instance.address,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      city: json['city'] as String?,
      country: json['country'] as String?,
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      postal_code: json['postal_code'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'city': instance.city,
      'country': instance.country,
      'line1': instance.line1,
      'line2': instance.line2,
      'postal_code': instance.postal_code,
      'state': instance.state,
    };

CardModel _$CardModelFromJson(Map<String, dynamic> json) => CardModel(
      brand: json['brand'] as String?,
      checks: json['checks'] == null
          ? null
          : Checks.fromJson(json['checks'] as Map<String, dynamic>),
      country: json['country'] as String?,
      display_brand: json['display_brand'] as String?,
      exp_month: json['exp_month'] as int?,
      exp_year: json['exp_year'] as int?,
      fingerprint: json['fingerprint'] as String?,
      funding: json['funding'] as String?,
      generated_from: json['generated_from'],
      last4: json['last4'] as String?,
      networks: json['networks'] == null
          ? null
          : Networks.fromJson(json['networks'] as Map<String, dynamic>),
      three_d_secure_usage: json['three_d_secure_usage'] == null
          ? null
          : ThreeDSecureUsage.fromJson(
              json['three_d_secure_usage'] as Map<String, dynamic>),
      wallet: json['wallet'],
    );

Map<String, dynamic> _$CardModelToJson(CardModel instance) => <String, dynamic>{
      'brand': instance.brand,
      'checks': instance.checks,
      'country': instance.country,
      'display_brand': instance.display_brand,
      'exp_month': instance.exp_month,
      'exp_year': instance.exp_year,
      'fingerprint': instance.fingerprint,
      'funding': instance.funding,
      'generated_from': instance.generated_from,
      'last4': instance.last4,
      'networks': instance.networks,
      'three_d_secure_usage': instance.three_d_secure_usage,
      'wallet': instance.wallet,
    };

Checks _$ChecksFromJson(Map<String, dynamic> json) => Checks(
      address_line1_check: json['address_line1_check'] as String?,
      address_postal_code_check: json['address_postal_code_check'] as String?,
      cvc_check: json['cvc_check'] as String?,
    );

Map<String, dynamic> _$ChecksToJson(Checks instance) => <String, dynamic>{
      'address_line1_check': instance.address_line1_check,
      'address_postal_code_check': instance.address_postal_code_check,
      'cvc_check': instance.cvc_check,
    };

Networks _$NetworksFromJson(Map<String, dynamic> json) => Networks(
      available: (json['available'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferred: json['preferred'],
    );

Map<String, dynamic> _$NetworksToJson(Networks instance) => <String, dynamic>{
      'available': instance.available,
      'preferred': instance.preferred,
    };

ThreeDSecureUsage _$ThreeDSecureUsageFromJson(Map<String, dynamic> json) =>
    ThreeDSecureUsage(
      supported: json['supported'] as bool?,
    );

Map<String, dynamic> _$ThreeDSecureUsageToJson(ThreeDSecureUsage instance) =>
    <String, dynamic>{
      'supported': instance.supported,
    };
