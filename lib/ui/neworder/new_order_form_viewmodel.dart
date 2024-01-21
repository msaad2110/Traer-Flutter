


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class NewOrderFormViewModel extends BaseViewModel{

  final descriptionTextEditTextController =  TextEditingController();
  final service = locator<RestService>();
  final productSpaceController =  TextEditingController();
  final productValueController =  TextEditingController();
  ValueNotifier<luggageModel.Data?> luggageData = ValueNotifier<luggageModel.Data?>(null);
  ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);
  ValueNotifier<String?> productValueSelectedValue = ValueNotifier<String?>(null);
  ValueNotifier<List<luggageModel.Data>?> luggageDataList = ValueNotifier<List<luggageModel.Data>?>([]);
  ValueNotifier<bool> isInsured = ValueNotifier<bool>(true);
  FocusNode focusNodeProductSpace = FocusNode();
  FocusNode focusNodeProductValue = FocusNode();
  FocusNode focusNodeProductDescription = FocusNode();
  //List<luggageModel.Data> luggageDataList = [];
  final List<String> unitList = [
    'KILOGRAMS'
  ];
  late BuildContext formContext;


  final List<String> currencyList = [
    'PKR',
  ];

  void setUnitValue(String value) {
    selectedValue.value = value;
    //  notifyListeners();
  }

  void setPackageType(luggageModel.Data? value) {
    luggageData.value = value;
    // notifyListeners();
  }


  void setProductValue(String value) {
    productValueSelectedValue.value = value;
    // notifyListeners();
  }
  void updateInsured(bool newValue) {
    isInsured.value = newValue;
  }

  String? validateProductSpace(String? value){


    if(value!.isEmpty){
      return "Please Enter Product Space";
    }

    return null;

  }


  String? validateProductValue(String? value){


    if(value!.isEmpty){
      return "Please Enter Product Value";
    }

    return null;

  }


  String? validateProductDestription(String? value){


    if(value!.isEmpty){
      return "Please Enter Product Description";
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

  Future<GeneralResponse>  newOrder( int user_id ,  int luggage_type_id,   int tripid,
      String description,  int productSpace,   int productValue) async {

    GeneralResponse responseModel = await service.newOrder(user_id,luggage_type_id,tripid,description,productSpace,productValue);

    return  responseModel;

  }

}