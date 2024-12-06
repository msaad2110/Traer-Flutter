

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/common/account/account_view.dart';
import 'package:traer/ui/common/chat/chat_view.dart';
import 'package:traer/ui/common/chat_users/chat_users_view.dart';
import 'package:traer/ui/common/fund/fund_view.dart';
import 'package:traer/ui/traveler/home/home_view.dart';
import 'package:traer/ui/traveler/order_history/order_history_view.dart';


class MainViewModel extends BaseViewModel{

  int currentIndex = 0;

  final List<Widget> pages = [
    HomeView(),
    /*OrderView(),*/
    OrderHistoryView(),
    ChatUsersView(),
    FundView(),
    AccountView(),
  ];


  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}