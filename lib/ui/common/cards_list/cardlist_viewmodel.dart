

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localdb/app_database.dart';
import 'package:traer/localdb/payment_dao.dart';
import 'package:traer/localdb/payment_model.dart';
import 'package:traer/models/card_response.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class CardlistViewmodel extends BaseViewModel{

  final service = locator<RestService>();
  FocusNode focusNode =  FocusNode();
  List<Data> filterAllCards = [];
  ValueNotifier<List<Data>> filterFoundCards = ValueNotifier<List<Data>>([]);
  PaymentModel? paymentModel = null;
  PaymentDao? paymentDao = null;

  Future<CardResponse>  getCards(int userID ) async {

    CardResponse responseModel = await service.getCards(userID);

    return  responseModel;

  }



  void setDestinationCountries(List<Data> countries) {
    filterFoundCards.value = countries;
  }

  Future<GeneralResponse>  deleteCard(String paymentID , int userID ) async {

    GeneralResponse responseModel = await service.deleteCard(paymentID,userID);

    return  responseModel;

  }


  Future<PaymentDao> getDatabase() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.personDao;
  }
}