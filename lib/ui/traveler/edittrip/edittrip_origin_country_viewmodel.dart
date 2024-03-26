


import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/network/restservice.dart';

class EditTripOriginCountryViewModel extends BaseViewModel{

  final service = locator<RestService>();
  final originCountrySearchController =  TextEditingController();
  List<Countries> originAllCountries = [];
  ValueNotifier<List<Countries>> originFoundCountries = ValueNotifier<List<Countries>>([]);

  Future<CountryResponse>  getCountries( String name ) async {

    CountryResponse responseModel = await service.getCountries(name);

    return  responseModel;

  }

  void setOriginCountries(List<Countries> countries) {
    originFoundCountries.value = countries;
  }
}