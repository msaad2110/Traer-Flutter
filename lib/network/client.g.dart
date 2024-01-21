// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://app.traer.pk/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<LoginResponse> userLogin(
    String email,
    String password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<LoginResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = LoginResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RegisterResponse> userRegister(
    String first_name,
    String last_name,
    String country,
    String phone,
    String email,
    String password,
    String password_confirmation,
    String is_traveller,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'first_name',
      first_name,
    ));
    _data.fields.add(MapEntry(
      'last_name',
      last_name,
    ));
    _data.fields.add(MapEntry(
      'country',
      country,
    ));
    _data.fields.add(MapEntry(
      'phone',
      phone,
    ));
    _data.fields.add(MapEntry(
      'email',
      email,
    ));
    _data.fields.add(MapEntry(
      'password',
      password,
    ));
    _data.fields.add(MapEntry(
      'password_confirmation',
      password_confirmation,
    ));
    _data.fields.add(MapEntry(
      'is_traveller',
      is_traveller,
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RegisterResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = RegisterResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CountryResponse> getCountries(String name) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'dropdown_names': name};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CountryResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/dropdowns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CountryResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StateResponse> getStates(
    String name,
    String countryName,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'dropdown_names': name,
      r'country_name': countryName,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StateResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/dropdowns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = StateResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<CityResponse> getCities(
    String name,
    String stateName,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'dropdown_names': name,
      r'state_name': stateName,
    };
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<CityResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/dropdowns',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = CityResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AllLuggageType> getLuggageTypes() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<AllLuggageType>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/luggage-types',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = AllLuggageType.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GeneralResponse> newTrip(
    int user_id,
    int luggage_type_id,
    String travelling_from,
    String travelling_to,
    String start_date,
    String end_date,
    int luggage_space,
    int commission,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'user_id',
      user_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'luggage_type_id',
      luggage_type_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'travelling_from',
      travelling_from,
    ));
    _data.fields.add(MapEntry(
      'travelling_to',
      travelling_to,
    ));
    _data.fields.add(MapEntry(
      'start_date',
      start_date,
    ));
    _data.fields.add(MapEntry(
      'end_date',
      end_date,
    ));
    _data.fields.add(MapEntry(
      'luggage_space',
      luggage_space.toString(),
    ));
    _data.fields.add(MapEntry(
      'commission',
      commission.toString(),
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GeneralResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/trips',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GeneralResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GeneralResponse> newOrder(
    int user_id,
    int luggage_type_id,
    int trip_id,
    String description,
    int product_value,
    int product_space,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.fields.add(MapEntry(
      'user_id',
      user_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'luggage_type_id',
      luggage_type_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'trip_id',
      trip_id.toString(),
    ));
    _data.fields.add(MapEntry(
      'description',
      description,
    ));
    _data.fields.add(MapEntry(
      'product_value',
      product_value.toString(),
    ));
    _data.fields.add(MapEntry(
      'product_space',
      product_space.toString(),
    ));
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<GeneralResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/orders',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = GeneralResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderHistoryModel> getAllOrders(int userid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userid};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<OrderHistoryModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/orders',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = OrderHistoryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TripHistoryModel> getAllTrips(int userid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userid};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<TripHistoryModel>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/trips',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = TripHistoryModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<StripeCreateIntent> getPaymentIntent(int userid) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'user_id': userid};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<StripeCreateIntent>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/stripe',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = StripeCreateIntent.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
