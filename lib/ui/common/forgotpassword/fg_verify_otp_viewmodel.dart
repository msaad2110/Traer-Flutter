

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class ForgotPasswordVerifyOTPViewModel extends BaseViewModel{

  final service = locator<RestService>();
  TextEditingController otpFieldController = TextEditingController();
  late BuildContext formContext;

  Future<GeneralResponse>  verifyOTP(String email , String otp) async {

    GeneralResponse responseModel = await service.verifyOTP(email,otp);

    return  responseModel;

  }
}