

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;
import 'package:traer/network/restservice.dart';

class NewTripFormViewModel extends BaseViewModel{
  final productSpaceController =  TextEditingController();
  final commissionController =  TextEditingController();
  late BuildContext formContext;
  final service = locator<RestService>();
  FocusNode focusNodeProductSpace = FocusNode();
  FocusNode focusNodeCommission = FocusNode();
  ValueNotifier<List<luggageModel.Data>?> luggageDataList = ValueNotifier<List<luggageModel.Data>?>([]);
  final List<String> unitList = [
    'KILOGRAMS'
  ];

  final List<String> comissionUnitList = [
    '%',
  ];
  ValueNotifier<luggageModel.Data?> luggageData = ValueNotifier<luggageModel.Data?>(null);
  ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);
  ValueNotifier<String?> commissionSelectedValue = ValueNotifier<String?>(null);

  String? validateProductSpace(String? value){


    if(value!.isEmpty){
      return "Please Enter Product Space";
    }

    return null;

  }


  String? validateCommission(String? value){


    if(value!.isEmpty){
      return "Please Enter Commission";
    }

    return null;

  }


  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  Future<luggageModel.AllLuggageType>  getLuggageTypes( ) async {

    luggageModel.AllLuggageType responseModel = await service.getLuggageTypes();

    return  responseModel;

  }


  void setUnitValue(String value) {
    selectedValue.value = value;
  }

  void setPackageType(luggageModel.Data? value) {
    luggageData.value = value;
  }


  void setCommissionUnitValue(String value) {
    commissionSelectedValue.value = value;
  }


}