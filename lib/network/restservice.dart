import 'dart:io';

import 'package:dio/dio.dart';
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
import 'package:traer/network/client.dart';
import 'package:traer/utils/pref_utils.dart';


 class RestService{

   var client = ApiService(Dio(),token:  PrefUtils().getToken(PrefUtils.token));

  Future<LoginResponse>  login(String email , String password) async {

    LoginResponse responseModel ;

    try {
      responseModel  = await client.userLogin(email,password);
      // Process successful response
    } on DioException catch (error) {
      print(error.toString());
      // Handle errors based on status code
      if (error.response != null) {
        final statusCode = error.response!.statusCode;
        switch (statusCode) {
          case 400:
          // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
            responseModel = LoginResponse(success : false ,message :  "Error Occured"  , data : null);
            //print("Error: ${parsedError.message}");
            break;
          case 401:
          // Handle 401 Unauthorized (e.g., wrong credentials)
            responseModel = LoginResponse(success : false ,message :  "Unauthorized access"  , data : null);
            print("Unauthorized access");
            break;
          case 500:
          // Handle 500 Internal Server Error
            print("Internal server error");
            print(error.response?.data.toString());
            responseModel = LoginResponse.fromJson(error.response!.data);
           // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

            break;
        // ... Handle other status codes as needed
          default:
          // Handle unexpected errors
            responseModel = LoginResponse(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
            print("Unexpected error: ${error.message}");
        }
      } else {
        // Handle network errors or other issues
        print("Network error: ${error.message}");
        responseModel = LoginResponse(success : false , message :  "NetworkError" , data : null);
      }
    }

    return  responseModel;

  }


  Future<RegisterResponse>  userRegister( String firstName ,  String lastName,   String country,
       String phone,  String email,   String password,  String passwordConfirmation , String is_traveller) async {

    RegisterResponse responseModel ;

    try {
      responseModel  = await client.userRegister(firstName,lastName,country,phone,email,password,passwordConfirmation , is_traveller);
      // Process successful response
    } on DioException catch (error) {
      // Handle errors based on status code
      if (error.response != null) {
        final statusCode = error.response!.statusCode;
        switch (statusCode) {
          case 400:
          // Handle 400 Bad Request (e.g., invalid email or password)
          // final parsedError = ErrorResponse.fromJson(error.response!.data);
            responseModel = RegisterResponse(success : false ,message :  "Error Occured"  , data : null);
            //print("Error: ${parsedError.message}");
            break;
          case 401:
          // Handle 401 Unauthorized (e.g., wrong credentials)
            responseModel = RegisterResponse(success : false ,message :  "Unauthorized access"  , data : null);
            print("Unauthorized access");
            break;
          case 500:
          // Handle 500 Internal Server Error
            print("Internal server error");
            responseModel = RegisterResponse.fromJson(error.response!.data);
            // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

            break;
        // ... Handle other status codes as needed
          default:
          // Handle unexpected errors
            responseModel = RegisterResponse(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
            print("Unexpected error: ${error.message}");
        }
      } else {
        // Handle network errors or other issues
        print("Network error: ${error.message}");
        responseModel = RegisterResponse(success : false , message :  "NetworkError" , data : null);
      }
    }




    return  responseModel;

  }


   Future<CountryResponse>  getCountries( String name ) async {

     CountryResponse responseModel = await client.getCountries(name);

     return  responseModel;

   }


   Future<AllLuggageType>  getLuggageTypes() async {

     AllLuggageType responseModel ;

     try {
       responseModel  = await client.getLuggageTypes();
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = AllLuggageType(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = AllLuggageType(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = AllLuggageType.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = AllLuggageType(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = AllLuggageType(success : false , message :  "NetworkError" , data : null);
       }
     }




     return  responseModel;

     return  responseModel;

   }

   Future<StateResponse>  getStates( String name  , String countryName ) async {

     StateResponse responseModel = await client.getStates(name , countryName);

     return  responseModel;

   }


   Future<CityResponse>  getCities( String name  , String stateName ) async {

     CityResponse responseModel = await client.getCities(name , stateName);

     return  responseModel;

   }



   Future<GeneralResponse>  newTrip( int user_id ,  int luggage_type_id,   String travelling_from,
       String travelling_to,  String start_date,   String end_date,  int luggage_space , int commission) async {

     GeneralResponse responseModel;

     try {
       responseModel  = await client.newTrip(user_id,luggage_type_id,travelling_from,travelling_to,start_date,end_date,luggage_space , commission);
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = GeneralResponse(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = GeneralResponse(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = GeneralResponse.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = GeneralResponse(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = GeneralResponse(success : false , message :  "NetworkError" , data : null);
       }
     }


     return  responseModel;

   }

   Future<GeneralResponse>  newOrder( int user_id ,  int luggage_type_id,   int trip_id,
       String description,  int product_value,   int product_space) async {

     GeneralResponse responseModel;

     try {
       responseModel  = await client.newOrder(user_id,luggage_type_id,trip_id,description,product_value,product_space);
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = GeneralResponse(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = GeneralResponse(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = GeneralResponse.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = GeneralResponse(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = GeneralResponse(success : false , message :  "NetworkError" , data : null);
       }
     }



     return  responseModel;

   }


   Future<TripHistoryModel>  getAllTrips( int userid ) async {

     //TripHistoryModel responseModel = await client.getAllTrips(userid);


     TripHistoryModel responseModel ;

     try {
       responseModel = await client.getAllTrips(userid);
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = TripHistoryModel(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = TripHistoryModel(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = TripHistoryModel.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = TripHistoryModel(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = TripHistoryModel(success : false , message :  "NetworkError" , data : null);
       }
     }



     return  responseModel;

   }

   Future<OrderHistoryModel>  getAllOrders(int userid ) async {

     OrderHistoryModel responseModel;

     try {
       responseModel = await client.getAllOrders(userid);
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = OrderHistoryModel(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = OrderHistoryModel(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = OrderHistoryModel.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = OrderHistoryModel(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = OrderHistoryModel(success : false , message :  "NetworkError" , data : null);
       }
     }

     return  responseModel;

   }


   Future<StripeCreateIntent>  getPaymentIntent( int userid ) async {

     //TripHistoryModel responseModel = await client.getAllTrips(userid);


     StripeCreateIntent responseModel ;

     try {
       responseModel = await client.getPaymentIntent(userid);
       // Process successful response
     } on DioException catch (error) {
       // Handle errors based on status code
       if (error.response != null) {
         final statusCode = error.response!.statusCode;
         switch (statusCode) {
           case 400:
           // Handle 400 Bad Request (e.g., invalid email or password)
           // final parsedError = ErrorResponse.fromJson(error.response!.data);
             responseModel = StripeCreateIntent(success : false ,message :  "Error Occured"  , data : null);
             //print("Error: ${parsedError.message}");
             break;
           case 401:
           // Handle 401 Unauthorized (e.g., wrong credentials)
             responseModel = StripeCreateIntent(success : false ,message :  "Unauthorized access"  , data : null);
             print("Unauthorized access");
             break;
           case 500:
           // Handle 500 Internal Server Error
             print("Internal server error");
             responseModel = StripeCreateIntent.fromJson(error.response!.data);
             // responseModel = LoginResponse(success : false ,message :  "Internal server error"  , data : null);

             break;
         // ... Handle other status codes as needed
           default:
           // Handle unexpected errors
             responseModel = StripeCreateIntent(success : false ,message :  "Unexpected error: ${error.message}" , data : null);
             print("Unexpected error: ${error.message}");
         }
       } else {
         // Handle network errors or other issues
         print("Network error: ${error.message}");
         responseModel = StripeCreateIntent(success : false , message :  "NetworkError" , data : null);
       }
     }



     return  responseModel;

   }


 }