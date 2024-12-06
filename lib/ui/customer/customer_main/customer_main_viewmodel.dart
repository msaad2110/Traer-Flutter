


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/ui/common/account/account_view.dart';
import 'package:traer/ui/common/chat/chat_view.dart';
import 'package:traer/ui/common/chat_users/chat_users_view.dart';
import 'package:traer/ui/customer/customer_home/customer_homeview.dart';
import 'package:traer/ui/customer/customer_order/customer_orderview.dart';
import 'package:traer/ui/customer/customer_orderhistory/customer_orderhistory_view.dart';
import 'package:traer/ui/customer/customer_trip_history/customer_triphistory_view.dart';

class CustomerMainViewModel extends BaseViewModel{

  int currentIndex = 0;

  final List<Widget> pages = [
    CustomerHomeView(),
    CustomerOrderHistoryView(),
    ChatUsersView(),
    CustomerTripHistoryView(),
    AccountView(),
  ];


  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}