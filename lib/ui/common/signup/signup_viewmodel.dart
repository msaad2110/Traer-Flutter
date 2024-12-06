


import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/register_response.dart';
import 'package:traer/network/restservice.dart';

class SignupViewModel extends BaseViewModel{

  TextEditingController firstNameFieldController = TextEditingController();
  TextEditingController lastNameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  TextEditingController countryFieldController = TextEditingController();
  TextEditingController passwordFieldController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  late String selectedCountry;
  bool showPassword = false;
  bool showPasswordConfirm = false;
  FocusNode focusNodeFName = FocusNode();
  FocusNode focusNodeLName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPasword = FocusNode();
  late BuildContext formContext;
  bool? isValidPhoneNumver = false;
  bool isJoinTraveler = true ;

  final service = locator<RestService>();

  Future<RegisterResponse>  userRegister( String firstName ,  String lastName,   String country,
      String phone,  String email,   String password,  String passwordConfirmation , String is_traveller) async {
   print("calling");
   RegisterResponse responseModel = await service.userRegister(firstName,lastName,country,phone,email,password,passwordConfirmation , is_traveller);

    return  responseModel;

  }

  setCountry(String data){
    selectedCountry = data;
    notifyListeners();
  }

  void updateJoinTraveler(bool newValue) {
    isJoinTraveler = newValue;
    notifyListeners();
  }

  void togglevisibilityPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }
  void togglevisibilityConfirmPassword() {
    showPasswordConfirm = !showPasswordConfirm;
    notifyListeners();
  }


  String? validateFirstName(String? value){

    if(value!.isEmpty){
      return "please enter first name";
    }
    return null;
  }

  String? validateLastName(String? value){

    if(value!.isEmpty){
      return "please enter last name";
    }
    return null;
  }

  String? validateEmail(String? value){

    if(value!.isEmpty){
      return "please enter email";
    }
    return null;
  }

  String? validatePassword(String? value){

    if(value!.isEmpty){
      return "please enter password";
    }

    if(value!.length < 6 ){
      return "password should be greater than  6";
    }
    return null;
  }

  String? validateConfirmPassword(String? value){

    if(value!.isEmpty){
      return "please enter confirm password";
    }
    return null;
  }

  String? validatePhoneNumber(){


    /*if (value == null || !isNumeric(value)) {
      return validatorMessage;
    }else{
      return null;
    }*/

    if(phoneNumberFieldController.text.isEmpty){
      return "please enter valid number";
    }
    return null;
  }

  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  void setErrorMessage(String? errorMessage) {
    notifyListeners();
  }

}