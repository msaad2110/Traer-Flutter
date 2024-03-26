
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/network/restservice.dart';

class FilterCityViewModel extends BaseViewModel{
  final service = locator<RestService>();
  final filterCitySearchController =  TextEditingController();
  List<Cities> filterAllCities = [];
  ValueNotifier<List<Cities>> filterFoundCities = ValueNotifier<List<Cities>>([]);

  void setDestinationCities(List<Cities> cities) {
    filterFoundCities.value = cities;
  }

  Future<CityResponse>  getCities( String name  , String stateName ) async {

    CityResponse responseModel = await service.getCities(name , stateName);

    return  responseModel;

  }
}