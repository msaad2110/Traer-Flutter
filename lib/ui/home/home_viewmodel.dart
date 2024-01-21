

import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';

class HomeViewModel extends BaseViewModel{

  bool isSelected = UserDataHolder.getInstance().loginData?.data?.user?.is_traveller  == 1  ? true : false;
  final service = locator<RestService>();
  List<String> imageList = [ImageConstant.imgThumbsUpOnprimarycontainer , ImageConstant.imgAirplaneGreenA700 ,ImageConstant.imgAirplane];


  updateSlected(bool selected){
    isSelected = selected;
    notifyListeners();
  }


  Future<TripHistoryModel>  getRecentTrips( int userID ) async {

    TripHistoryModel responseModel = await service.getAllTrips(userID);

    return  responseModel;

  }
}