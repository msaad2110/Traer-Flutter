

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/network/restservice.dart';

class NewTripOriginCityViewModel extends BaseViewModel{
  final originCitySearchController =  TextEditingController();
  final service = locator<RestService>();
  List<Cities> originAllCities = [];
  ValueNotifier<List<Cities>> originFoundCities = ValueNotifier<List<Cities>>([]);

  void setOriginCities(List<Cities> cities) {
    originFoundCities.value = cities;
  }

  Future<CityResponse>  getCities( String name  , String stateName ) async {

    CityResponse responseModel = await service.getCities(name , stateName);

    return  responseModel;

  }
}