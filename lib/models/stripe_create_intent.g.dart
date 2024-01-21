// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stripe_create_intent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StripeCreateIntent _$StripeCreateIntentFromJson(Map<String, dynamic> json) =>
    StripeCreateIntent(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StripeCreateIntentToJson(StripeCreateIntent instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['id'] as String?,
      object: json['object'] as String?,
      application: json['application'],
      automatic_payment_methods: json['automatic_payment_methods'],
      cancellation_reason: json['cancellation_reason'],
      client_secret: json['client_secret'] as String?,
      created: json['created'] as int?,
      customer: json['customer'] as String?,
      description: json['description'],
      flow_directions: json['flow_directions'],
      last_setup_error: json['last_setup_error'],
      latestAttempt: json['latestAttempt'],
      livemode: json['livemode'] as bool?,
      mandate: json['mandate'],
      metadata: (json['metadata'] as List<dynamic>?)
          ?.map((e) => e as Object)
          .toList(),
      next_action: json['next_action'],
      on_behalf_of: json['on_behalf_of'],
      payment_method: json['payment_method'],
      payment_method_configuration_details:
          json['payment_method_configuration_details'],
      payment_method_options: json['payment_method_options'] == null
          ? null
          : PaymentMethodOptions.fromJson(
              json['payment_method_options'] as Map<String, dynamic>),
      payment_method_types: (json['payment_method_types'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      single_use_mandate: json['single_use_mandate'],
      status: json['status'] as String?,
      usage: json['usage'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'application': instance.application,
      'automatic_payment_methods': instance.automatic_payment_methods,
      'cancellation_reason': instance.cancellation_reason,
      'client_secret': instance.client_secret,
      'created': instance.created,
      'customer': instance.customer,
      'description': instance.description,
      'flow_directions': instance.flow_directions,
      'last_setup_error': instance.last_setup_error,
      'latestAttempt': instance.latestAttempt,
      'livemode': instance.livemode,
      'mandate': instance.mandate,
      'metadata': instance.metadata,
      'next_action': instance.next_action,
      'on_behalf_of': instance.on_behalf_of,
      'payment_method': instance.payment_method,
      'payment_method_configuration_details':
          instance.payment_method_configuration_details,
      'payment_method_options': instance.payment_method_options,
      'payment_method_types': instance.payment_method_types,
      'single_use_mandate': instance.single_use_mandate,
      'status': instance.status,
      'usage': instance.usage,
    };

PaymentMethodOptions _$PaymentMethodOptionsFromJson(
        Map<String, dynamic> json) =>
    PaymentMethodOptions(
      card: json['card'] == null
          ? null
          : Card.fromJson(json['card'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaymentMethodOptionsToJson(
        PaymentMethodOptions instance) =>
    <String, dynamic>{
      'card': instance.card,
    };

Card _$CardFromJson(Map<String, dynamic> json) => Card(
      mandate_options: json['mandate_options'],
      network: json['network'],
      request_three_d_secure: json['request_three_d_secure'] as String?,
    );

Map<String, dynamic> _$CardToJson(Card instance) => <String, dynamic>{
      'mandate_options': instance.mandate_options,
      'network': instance.network,
      'request_three_d_secure': instance.request_three_d_secure,
    };
