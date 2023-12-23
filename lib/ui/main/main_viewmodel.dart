

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/account/account_view.dart';
import 'package:traer/ui/chat/chat_view.dart';
import 'package:traer/ui/fund/fund_view.dart';
import 'package:traer/ui/home/home_view.dart';
import 'package:traer/ui/order/order_view.dart';

class MainViewModel extends BaseViewModel{

  int currentIndex = 0;

  final List<Widget> pages = [
    HomeView(),
    OrderView(),
    ChatView(),
    FundView(),
    AccountView(),
  ];


  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}