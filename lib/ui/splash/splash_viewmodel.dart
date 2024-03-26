


import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/utils/pref_utils.dart';

import '../../models/login_response.dart';

class SplashViewModel extends BaseViewModel{

   init() async{
    await Future.delayed(Duration(seconds: 2));

    if(PrefUtils().getFirstRun()){
      if(PrefUtils().isContainKey(PrefUtils.userData)){
        getUserData();
        locator<NavigationService>().pushNamedAndRemoveUntil(Routes.mainView);
      }else{
        locator<NavigationService>().pushNamedAndRemoveUntil(Routes.loginView);
      }
    }else{
      PrefUtils().setFirstRun(true);
      PrefUtils().isRememberUser(true);
      locator<NavigationService>().pushNamedAndRemoveUntil(Routes.introView);

    }

    /*if(PrefUtils().isContainKey(PrefUtils.loginKey)){
      locator<NavigationService>().pushNamedAndRemoveUntil(Routes.homeView);
    }else{
      locator<NavigationService>().pushNamedAndRemoveUntil(Routes.introView);
    }*/
  }



  getUserData() async{
  LoginResponse  loginResponse = await LoginResponse.fromJson(await PrefUtils().read(PrefUtils.userData));
  UserDataHolder.getInstance().loginData = loginResponse;
  }

}