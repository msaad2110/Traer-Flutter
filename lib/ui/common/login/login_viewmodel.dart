


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/LoginItemModel.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/network/client.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/utils/pref_utils.dart';

class LoginViewModel extends BaseViewModel{

  List<LoginItemModel> loginItemList = [
    LoginItemModel(rectangle: ImageConstant.imgRectangle11),
    LoginItemModel(rectangle: ImageConstant.imgRectangle12),
    LoginItemModel(rectangle: ImageConstant.imgRectangle15),
    LoginItemModel(rectangle: ImageConstant.imgRectangle16)
  ];
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  late BuildContext formContext;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final service = locator<RestService>();


  Future<LoginResponse>  login(String email , String password) async {

    LoginResponse responseModel = await service.login(email,password);

    return  responseModel;

  }

  String? validateEmail(String? value){


    if(value!.isEmpty){
      return "Please Enter Email";
    }

    return null;

  }


  String? validatePassword(String? value){


    if(value!.isEmpty){
      return "Please Enter Password";
    }

    return null;

  }


  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  void updateToken(){
    locator<RestService>().client = ApiService(Dio(),token:  PrefUtils().getToken(PrefUtils.token));
    print( "PrefUtils().getToken(PrefUtils.token)");
    print( PrefUtils().getToken(PrefUtils.token));
  }

}