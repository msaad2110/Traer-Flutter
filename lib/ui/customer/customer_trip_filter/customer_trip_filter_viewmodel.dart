


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/models/sort_by_model.dart';

class CustomerTripFilterViewModel extends BaseViewModel{

  PageController pageController  = PageController(initialPage: 0);
  FocusNode focusNodeProductSpace = FocusNode();
  int currentIndex = 0;
  ValueNotifier<List<double>> rangeSliderSelectedValue = ValueNotifier<List<double>>([0.0,100.0]);
  ValueNotifier<List<SortByModel>?> sortByList = ValueNotifier<List<SortByModel>?>([]);
  ValueNotifier<SortByModel?> sortByItem= ValueNotifier<SortByModel?>(null);
  var defaultStartDate = DateTime.now();
  var defaultEndDate = DateTime.now().add(const Duration(days: 10));
  final productSpaceController =  TextEditingController();
  ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);
  final List<String> unitList = [
    'KILOGRAMS'
  ];


  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }

  void setUnitValue(String value) {
    selectedValue.value = value;
    //  notifyListeners();
  }

  void setPackageType(SortByModel? value) {
    sortByItem.value = value;
  }
}