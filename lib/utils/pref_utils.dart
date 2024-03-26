//ignore: unused_import    
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/user_data_holder.dart';

class PrefUtils {
  static SharedPreferences? _sharedPreferences;
  static String token = "Token";
  static String userData = "UserData";
  static String isSeen = "seen";
  static String rememberUser = "rememberUser";

  PrefUtils() {
    // init();
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  Future<void> init() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    print('SharedPreference Initialized');
  }

  ///will clear all the data stored in preference
  void clearPreferencesData() async {
   // _sharedPreferences!.clear();
    _sharedPreferences!.remove(userData);
    _sharedPreferences!.remove(token);
  }

  Future<void> setThemeData(String value) {
    return _sharedPreferences!.setString('themeData', value);
  }

  String getThemeData() {
    try {
      return _sharedPreferences!.getString('themeData')!;
    } catch (e) {
      return 'primary';
    }
  }


  Future<void> setFirstRun(bool value) {
    return _sharedPreferences!.setBool(isSeen, value);
  }

  bool getFirstRun() {
    try {
      return _sharedPreferences!.getBool(isSeen)!;
    } catch (e) {
      return false;
    }
  }


  read(String key) async {
    try {
       if(_sharedPreferences!.containsKey(key)){
         return json.decode(_sharedPreferences!.getString(key)!);
       }else{
         return null;
       }
      return json.decode(_sharedPreferences!.getString(key)!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  String? getToken(String key)  {
    try {
      if(_sharedPreferences!.containsKey(key)){
        return json.decode(_sharedPreferences!.getString(key)!);
      }else{
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }



  save(String key, value) async {
    _sharedPreferences!.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  bool isContainKey(String key) {
    return _sharedPreferences!.containsKey(key);
  }


  Future<void> isRememberUser(bool value) {
    return _sharedPreferences!.setBool(rememberUser, value);
  }

  bool getIsRememberUser() {
    try {
      return _sharedPreferences!.getBool(rememberUser)!;
    } catch (e) {
      return false;
    }
  }

  void  switchUser(){
    if(UserDataHolder.getInstance().loginData?.data?.user?.is_traveller == 0){
      locator<NavigationService>().clearStackAndShow(Routes.mainView);
    }else{
      locator<NavigationService>().clearStackAndShow(Routes.mainView);
    }

  }

}
    