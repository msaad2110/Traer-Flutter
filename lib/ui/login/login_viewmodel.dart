


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/models/LoginItemModel.dart';
import 'package:traer/utils/image_constant.dart';

class LoginViewModel extends BaseViewModel{

  List<LoginItemModel> loginItemList = [
    LoginItemModel(rectangle: ImageConstant.imgRectangle11),
    LoginItemModel(rectangle: ImageConstant.imgRectangle12),
    LoginItemModel(rectangle: ImageConstant.imgRectangle15),
    LoginItemModel(rectangle: ImageConstant.imgRectangle16)
  ];

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

}