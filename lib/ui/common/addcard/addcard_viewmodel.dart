

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localdb/app_database.dart';
import 'package:traer/localdb/payment_dao.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/stripe_create_intent.dart';
import 'package:traer/network/restservice.dart';
import 'package:stacked/stacked.dart';

class AddCardViewModel extends BaseViewModel{
  final service = locator<RestService>();
  final controller = CardFormEditController();
  late StripeCreateIntent clientSecretModel;
  CardFieldInputDetails? card;
  PaymentDao? paymentDao = null;
  Future<StripeCreateIntent>  getClientSecret(int userID ) async {

    StripeCreateIntent responseModel = await service.getPaymentIntent(userID);

    return  responseModel;

  }

  AddCardViewModel() {
    controller.addListener(() {
      // Perform necessary actions based on controller changes
      notifyListeners(); // Notify the UI of changes
    });
  }

  @override
  void dispose() {
    controller.removeListener((){
      notifyListeners();
    });
    controller.dispose();
  }

  Future<PaymentDao> getDatabase() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return database.personDao;
  }


  Future<GeneralResponse>  addCard(String paymentID , int userID) async {

    GeneralResponse responseModel = await service.addCard(paymentID,userID);

    return  responseModel;

  }
}