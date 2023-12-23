import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/register_response.dart';
part 'client.g.dart';


@RestApi(baseUrl: "https://app.traer.pk")
abstract class ApiService {

  factory ApiService(Dio dio,{String baseUrl}) = _ApiService;


  @POST("/api/login")
  Future<LoginResponse> userLogin( @Field("email") String email ,  @Field("password") String password);

  @POST("/api/register")
  Future<RegisterResponse> userRegister( @Field("first_name") String firstName ,  @Field("last_name") String lastName,  @Field("country") String country,
  @Field("phone") String phone,  @Field("email") String email,  @Field("password") String password,  @Field("password_confirmation") String passwordConfirmation);

 // https://app.traer.pk/api/login
}

