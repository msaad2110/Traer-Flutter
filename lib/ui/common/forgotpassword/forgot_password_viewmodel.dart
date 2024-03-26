

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ForgotPasswordViewModel extends BaseViewModel{

  PageController pageController  = PageController(initialPage: 0);
  int currentIndex = 0;
  late String email;


  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    notifyListeners();
  }
}