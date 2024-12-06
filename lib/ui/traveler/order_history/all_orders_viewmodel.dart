


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/order_history_model.dart' as orderModel;
import 'package:traer/network/restservice.dart';

class AllOrdersViewModel extends BaseViewModel{

  final service = locator<RestService>();
  final allOrdersSearchController =  TextEditingController();
  List<orderModel.Data> allOrdersList = [];
  ValueNotifier<List<orderModel.Data>> allFoundOrders = ValueNotifier<List<orderModel.Data>>([]);

  Future<orderModel.OrderHistoryModel>  getAllOrders( int userID , int is_traveller) async {

    orderModel.OrderHistoryModel responseModel = await service.getAllOrders(userID,is_traveller);

    return  responseModel;

  }

  void setOrders(List<orderModel.Data> order) {
    allFoundOrders.value = order;
  }
}