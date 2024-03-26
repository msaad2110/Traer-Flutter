import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';
import 'package:traer/models/all_luggagetype.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/document_types.dart';
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
    dio.interceptors.add(TokenInterceptor(token ?? "")); // Add the interceptor
    dio.interceptors.add(PrettyDioLogger()); // Add the interceptor
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
  Future<TripHistoryModel> getAllTrips( @Query("user_id") int userid , @Query("start_date") String? start_date ,
      @Query("end_date") String? end_date ,@Query("luggage_space") int? luggage_space ,@Query("travelling_from") String? travelling_from ,
      @Query("commission_start") int? commission_start ,@Query("commission_end") int? commission_end );

  @GET("api/stripe")
  Future<StripeCreateIntent> getPaymentIntent( @Query("user_id") int userid);

  @PUT("api/trips/{id}")
  Future<GeneralResponse> updateTrip(@Path() int id,  @Query("user_id") int user_id ,  @Query("luggage_type_id") int luggage_type_id,@Query("travelling_from") String travelling_from, @Query("travelling_to") String travelling_to,
  @Query("start_date") String start_date,  @Query("end_date") String end_date,@Query("commission") int commission , @Query("luggage_space") int luggage_space );

  @DELETE("api/trips/{id}")
  Future<GeneralResponse> deleteTrip(@Path() int id  , @Query("user_id") int user_id );

  @POST("api/reset-password")
  Future<GeneralResponse> resetPassword( @Part() String email ,  @Part() String password   ,@Part() String password_confirmation);


  @POST("api/forgot-password")
  Future<GeneralResponse> sendOTP( @Part() String email);

  @POST("api/verify-otp")
  Future<GeneralResponse> verifyOTP( @Part() String email ,@Part() String otp);

  @PUT("api/users/{id}")
  Future<GeneralResponse> changePassword(@Path() int id,  @Query("action") String action , @Query("password") String password  , @Query("password_confirmation") String password_confirmation , @Query("old_password") String old_password  );

  @PUT("api/users/{id}")
  Future<GeneralResponse> updateProfile(@Path() int id,  @Query("first_name") String first_name , @Query("last_name") String last_name  , @Query("email") String email,
   @Query("phone") String phone , @Query("action") String action );

  @POST("api/media")
  @MultiPart()
  Future<GeneralResponse> uploadProfilePicture(
      @Part() int user_id,
      @Part() String action,
      @Part() int document_type_id,
      @Part() File attachments,
      );

  @GET("api/document-types")
  Future<DocumentType> getAllDocumentTypes();


/*
  http://127.0.0.1:8000/api/users/2?first_name=Shaheer&last_name=zaeem&email=shaheerzaeem26@gmail.com&phone=030000222&action=update_profile
*/
}

