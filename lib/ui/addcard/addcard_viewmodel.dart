

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/stripe_create_intent.dart';
import 'package:traer/network/restservice.dart';
import 'package:stacked/stacked.dart';

class AddCardViewModel extends BaseViewModel{
  final service = locator<RestService>();
  final controller = CardFormEditController();
  late StripeCreateIntent clientSecretModel;
  CardFieldInputDetails? card;
  Future<StripeCreateIntent>  getClientSecret(int userID ) async {

    StripeCreateIntent responseModel = await service.getPaymentIntent(userID);

    return  responseModel;

  }
}