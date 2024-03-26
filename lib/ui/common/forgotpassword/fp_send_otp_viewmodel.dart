


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class ForgotPasswordSendOTPViewModel extends BaseViewModel{

  late BuildContext formContext;
  TextEditingController emailFieldController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  final service = locator<RestService>();


  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  String? validateEmail(String? value){

    if(value!.isEmpty){
      return "please enter email";
    }
    return null;
  }

  Future<GeneralResponse>  sendOTP(String email ) async {

    GeneralResponse responseModel = await service.sendOTP(email);

    return  responseModel;

  }
}