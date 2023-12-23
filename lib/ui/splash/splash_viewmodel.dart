


import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';

class SplashViewModel extends BaseViewModel{

   init() async{
    await Future.delayed(Duration(seconds: 2));
    locator<NavigationService>().pushNamedAndRemoveUntil(Routes.introView);
  }

}