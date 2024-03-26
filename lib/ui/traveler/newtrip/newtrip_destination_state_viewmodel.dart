

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/network/restservice.dart';

class NewTripDestinationStateViewModel extends BaseViewModel{
  final service = locator<RestService>();
  final destinationStateSearchController =  TextEditingController();
  List<States> destinationAllStates = [];
  ValueNotifier<List<States>> destinationFoundStates = ValueNotifier<List<States>>([]);



  void setDestinationStates(List<States> states) {
    destinationFoundStates.value = states;
  }

  Future<StateResponse>  getStates( String name  , String countryName ) async {

    StateResponse responseModel = await service.getStates(name , countryName);

    return  responseModel;

  }
}