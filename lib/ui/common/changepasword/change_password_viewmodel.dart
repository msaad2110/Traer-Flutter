


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class ChangePasswordViewModel extends BaseViewModel{

  late BuildContext formContext;
  TextEditingController emailFieldController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController oldpasswordController = TextEditingController();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPasword = FocusNode();
  FocusNode focusNodeoldPasword = FocusNode();
  bool showPassword = false;
  bool showOldPassword = false;
  bool showPasswordConfirm = false;
  final service = locator<RestService>();




  void togglevisibilityPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }


  void togglevisibilityOldPassword() {
    showOldPassword = !showOldPassword;
    notifyListeners();
  }
  void togglevisibilityConfirmPassword() {
    showPasswordConfirm = !showPasswordConfirm;
    notifyListeners();
  }

  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  String? validatePassword(String? value){

    if(value!.isEmpty){
      return "please enter password";
    }
    return null;
  }

  String? validateOldPassword(String? value){

    if(value!.isEmpty){
      return "please enter old password";
    }
    return null;
  }

  String? validateConfirmPassword(String? value){

    if(value!.isEmpty){
      return "please enter confirm password";
    }

    return null;
  }

  String? validateEmail(String? value){

    if(value!.isEmpty){
      return "please enter email";
    }
    return null;
  }

  Future<GeneralResponse>  changePassword(int userID ,String action , String password , String passwordConfirmation , String oldPassword) async {

    GeneralResponse responseModel = await service.changePassword(userID,action,password,passwordConfirmation,oldPassword);

    return  responseModel;

  }
}