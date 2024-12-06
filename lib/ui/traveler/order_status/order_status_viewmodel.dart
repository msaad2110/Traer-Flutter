
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/order_status.dart';
import 'package:traer/network/restservice.dart';

class OrderStatusViewModel extends BaseViewModel{

  ValueNotifier<List<OrderStatus>> allStatus = ValueNotifier<List<OrderStatus>>([]);
  OrderStatus? orderStatus = null;
  late int orderID ;
  final service = locator<RestService>();

  Future<OrderStatusModel>  getStatus(String status) async {

    OrderStatusModel responseModel = await service.getOrderStatus(status);

    return  responseModel;

  }

  Future<GeneralResponse>  updateOrderStatus(int orderID , int userID , int status) async {

    GeneralResponse responseModel = await service.updateOrderStatus(orderID,userID,status);

    return  responseModel;

  }

  void setStatus(List<OrderStatus> status) {
    allStatus.value = List.of(status);
    status.forEach((element) {
      print(element.toJson());
    });
  }
}