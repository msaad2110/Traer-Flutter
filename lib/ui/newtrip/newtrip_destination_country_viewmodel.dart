


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/network/restservice.dart';

class NewTripDestinationCountryViewModel extends BaseViewModel{

  final service = locator<RestService>();
  final destinationCountrySearchController =  TextEditingController();
  List<Countries> destinationAllCountries = [];
  ValueNotifier<List<Countries>> destinationFoundCountries = ValueNotifier<List<Countries>>([]);

  Future<CountryResponse>  getCountries( String name ) async {

    CountryResponse responseModel = await service.getCountries(name);

    return  responseModel;

  }

  void setDestinationCountries(List<Countries> countries) {
    destinationFoundCountries.value = countries;
  }
}