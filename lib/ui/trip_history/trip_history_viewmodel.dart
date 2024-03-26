


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';

class TripHistoryViewModel extends BaseViewModel   {

 // final TickerProvider tickerProvider;
  late TabController tabController;
  final service = locator<RestService>();
  List<String> imageList = [ImageConstant.imgThumbsUpOnprimarycontainer , ImageConstant.imgAirplaneGreenA700 ,ImageConstant.imgAirplane];

  /*TripHistoryViewModel(this.tickerProvider) {

    initializeTabController();
  }*/

  /*void initializeTabController() {
    tabController = TabController(length: 3, vsync: tickerProvider);
  }*/

  int _currentTabIndex = 0;

  // List of tab titles
  final List<String> tabTitles = ['Home', 'Explore', 'Settings'];

  // Getter for current tab index
  int get currentTabIndex => _currentTabIndex;

  // Setter for current tab index
  void setTabIndex(int newIndex) {
    _currentTabIndex = newIndex;
    notifyListeners();
  }

  // Function to handle tab tap
  void onTabTapped(int index) {
    setTabIndex(index);
  }


  Future<TripHistoryModel>  getRecentTrips( int userID ) async {

    TripHistoryModel responseModel = await service.getAllTrips(userID);

    return  responseModel;

  }

}