


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localdb/app_database.dart';
import 'package:traer/localdb/payment_dao.dart';
import 'package:traer/localdb/payment_model.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/order_history_model.dart' as orderModel;
import 'package:traer/network/restservice.dart';

class CustomerAllOrdersViewModel extends BaseViewModel{

  final service = locator<RestService>();
  final allOrdersSearchController =  TextEditingController();
  List<orderModel.Data> allOrdersList = [];
  ValueNotifier<List<orderModel.Data>> allFoundOrders = ValueNotifier<List<orderModel.Data>>([]);
  PaymentModel? paymentModel = null;
  PaymentDao? paymentDao = null;

  Future<orderModel.OrderHistoryModel>  getAllOrders( int userID , int is_traveller) async {

    orderModel.OrderHistoryModel responseModel = await service.getAllOrders(userID,is_traveller);

    return  responseModel;

  }

  Future<GeneralResponse>  payment(String paymentID , int userID , int orderID) async {

    GeneralResponse responseModel = await service.payment(paymentID,userID,orderID);

    return  responseModel;

  }

  void setOrders(List<orderModel.Data> order) {
    allFoundOrders.value = order;
  }


  Future<PaymentDao> getDatabase() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.personDao;
  }
}