


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/network/restservice.dart';

class FilterCountryViewModel extends BaseViewModel{

  final service = locator<RestService>();
  final filterCountrySearchController =  TextEditingController();
  FocusNode focusNode =  FocusNode();
  List<Countries> filterAllCountries = [];
  ValueNotifier<List<Countries>> filterFoundCountries = ValueNotifier<List<Countries>>([]);

  Future<CountryResponse>  getCountries( String name ) async {
    CountryResponse responseModel = await service.getCountries(name);

    return  responseModel;

  }

  void setDestinationCountries(List<Countries> countries) {
    filterFoundCountries.value = countries;
  }

  void hideKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(StackedService.navigatorKey!.currentContext!);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      print("hide keyboard");
      FocusManager.instance.primaryFocus?.unfocus();
    }else{
      print("keyboard not shown");
    }
  }
}