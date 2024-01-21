import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:traer/models/all_luggagetype.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/order_history_model.dart';
import 'package:traer/models/register_response.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/models/stripe_create_intent.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/network/TokenInterceptor.dart';
part 'client.g.dart';


@RestApi(baseUrl: "https://app.traer.pk/")
abstract class ApiService {

  //factory ApiService(Dio dio,{String baseUrl}) = _ApiService;

  factory ApiService(Dio dio, {String? baseUrl, String? token}) {
    print("token");
    print(token);
    dio.interceptors.add(TokenInterceptor(token ?? "")); // Add the interceptor
    print(token);
    print("musadiq");
    return _ApiService(dio);
  }
  @POST("api/login")
  Future<LoginResponse> userLogin( @Part() String email ,  @Part() String password);

  @POST("api/register")
  Future<RegisterResponse> userRegister( @Part() String first_name ,  @Part() String last_name,  @Part() String country, @Part() String phone,  @Part() String email,  @Part() String password,  @Part() String password_confirmation , @Part() String is_traveller);

  @GET("api/dropdowns")
  Future<CountryResponse> getCountries( @Query("dropdown_names") String name);

  @GET("api/dropdowns")
  Future<StateResponse> getStates( @Query("dropdown_names") String name ,  @Query("country_name") String countryName );

  @GET("api/dropdowns")
  Future<CityResponse> getCities( @Query("dropdown_names") String name ,  @Query("state_name") String stateName);

  @GET("api/luggage-types")
  Future<AllLuggageType> getLuggageTypes();

  @POST("api/trips")
  Future<GeneralResponse> newTrip( @Part() int user_id ,  @Part() int luggage_type_id,  @Part() String travelling_from, @Part() String travelling_to,  @Part() String start_date,  @Part() String end_date,  @Part() int luggage_space , @Part() int commission);

  @POST("api/orders")
  Future<GeneralResponse> newOrder( @Part() int user_id ,  @Part() int luggage_type_id,  @Part() int trip_id, @Part() String description,  @Part() int product_value,  @Part() int product_space);

  @GET("api/orders")
  Future<OrderHistoryModel> getAllOrders( @Query("user_id") int userid);

  @GET("api/trips")
  Future<TripHistoryModel> getAllTrips( @Query("user_id") int userid);

  @GET("api/stripe")
  Future<StripeCreateIntent> getPaymentIntent( @Query("user_id") int userid);

 // http://127.0.0.1:8000/api/stripe?user_id=2

 // https://app.traer.pk/api/login
}

