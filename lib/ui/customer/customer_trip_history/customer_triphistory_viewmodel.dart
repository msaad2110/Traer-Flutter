


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;

class CustomerTripHistoryViewModel extends BaseViewModel{


  // final TickerProvider tickerProvider;
  late TabController tabController;
  final service = locator<RestService>();
  List<String> imageList = [ImageConstant.imgThumbsUpOnprimarycontainer , ImageConstant.imgAirplaneGreenA700 ,ImageConstant.imgAirplane];

  int _currentTabIndex = 0;

  // List of tab titles
  final List<String> tabTitles = ['Home', 'Explore', 'Settings'];

  // Getter for current tab index
  int get currentTabIndex => _currentTabIndex;

  final filterTripSearchController =  TextEditingController();
  List<tripModel.Data> filterAllTrip = [];
  ValueNotifier<List<tripModel.Data>> filterFoundTrips = ValueNotifier<List<tripModel.Data>>([]);

  void setTrips(List<tripModel.Data> cities) {
    filterFoundTrips.value = cities;
  }

  // Setter for current tab index
  void setTabIndex(int newIndex) {
    _currentTabIndex = newIndex;
    notifyListeners();
  }

  // Function to handle tab tap
  void onTabTapped(int index) {
    setTabIndex(index);
  }


  Future<TripHistoryModel>  getRecentTrips( int userid ,String? startDate , String? endDate ,
      int? luggageSpace , String? from , int? commissionStart , int? commissionEnd , int? is_traveler) async {

    TripHistoryModel responseModel = await service.getAllTrips(userid,startDate,endDate,luggageSpace,from,commissionStart,commissionEnd,is_traveler);

    return  responseModel;

  }


}