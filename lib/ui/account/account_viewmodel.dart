

import 'package:stacked/stacked.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/utils/pref_utils.dart';

class AccountViewModel extends BaseViewModel{

  LoginResponse? loginResponse;

  void getUserData() async{
    //loginResponse = await LoginResponse.fromJson(await PrefUtils().read(PrefUtils.userData));
    loginResponse = await UserDataHolder.getInstance().loginData;
    notifyListeners();
    print(loginResponse?.data?.user?.first_name);
    print(loginResponse?.data?.user?.email);
  }
}