

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/network/restservice.dart';

class NewTripDestinationCityViewModel extends BaseViewModel{
  final service = locator<RestService>();
  final destinationCitySearchController =  TextEditingController();
  List<Cities> destinationAllCities = [];
  ValueNotifier<List<Cities>> destinationFoundCities = ValueNotifier<List<Cities>>([]);

  void setDestinationCities(List<Cities> cities) {
    destinationFoundCities.value = cities;
  }

  Future<CityResponse>  getCities( String name  , String stateName ) async {

    CityResponse responseModel = await service.getCities(name , stateName);

    return  responseModel;

  }
}