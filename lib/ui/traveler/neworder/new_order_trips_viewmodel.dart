


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class NewOrderTripsViewModel extends BaseViewModel{

  List<tripModel.Data> allTrips = [];
  ValueNotifier<List<tripModel.Data>> foundTrips = ValueNotifier<List<tripModel.Data>>([]);
  final tripSearchController =  TextEditingController();
  final service = locator<RestService>();



  void settrips(List<tripModel.Data> trips) {
    foundTrips.value = trips;
  }


  Future<TripHistoryModel>  getAllTrips( int userid ,String? startDate , String? endDate ,
      int? luggageSpace , String? from , int? commissionStart , int? commissionEnd , int? is_traveler) async {

    TripHistoryModel responseModel = await service.getAllTrips(userid,startDate,endDate,luggageSpace,from,commissionStart,commissionEnd,is_traveler);

    return  responseModel;

  }
}