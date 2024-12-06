

import 'package:traer/models/login_response.dart';

class UserDataHolder{

  LoginResponse? _loginData;
  int? _userCurrentStatus;


  static final UserDataHolder _instance = UserDataHolder._internal();
  UserDataHolder._internal();

  factory UserDataHolder.getInstance() {
    return _instance;
  }

  LoginResponse? get loginData => _loginData;

  set loginData(LoginResponse? value) {
    _loginData = value;
  }


  int? get userCurrentStatus => _userCurrentStatus;

  set userCurrentStatus(int? value) {
    _userCurrentStatus = value;
  } // Clear the login data


  void clearLoginData() {
    _loginData = null;
    _userCurrentStatus = null;
  }
}