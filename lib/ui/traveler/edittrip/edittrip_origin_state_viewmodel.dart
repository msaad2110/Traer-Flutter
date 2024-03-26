


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/network/restservice.dart';

class EditTripOriginStateViewModel extends BaseViewModel{
  final originStateSearchController =  TextEditingController();
  final service = locator<RestService>();
  List<States> originAllStates = [];
  ValueNotifier<List<States>> originFoundStates = ValueNotifier<List<States>>([]);

  void setOriginStates(List<States> states) {
    originFoundStates.value = states;
  }

  Future<StateResponse>  getStates( String name  , String countryName ) async {

    StateResponse responseModel = await service.getStates(name , countryName);

    return  responseModel;

  }
}