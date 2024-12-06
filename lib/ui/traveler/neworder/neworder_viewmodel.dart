


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/models/user_profile.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class NewOrderViewModel extends BaseViewModel{


  PageController pageController  = PageController(initialPage: 0);
  int currentIndex = 0;
  late tripModel.Data tripData;
  late UserProfile userProfile;


  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }





}