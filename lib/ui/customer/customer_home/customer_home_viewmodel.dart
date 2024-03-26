


import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';

class CustomerHomeViewModel extends BaseViewModel{


  bool isSelected = false;
  final service = locator<RestService>();
  List<String> imageList = [ImageConstant.imgThumbsUpOnprimarycontainer , ImageConstant.imgAirplaneGreenA700 ,ImageConstant.imgAirplane];


  updateSlected(bool selected){
    isSelected = selected;
   // notifyListeners();
    locator<NavigationService>().navigateTo(Routes.mainView);
  }


  Future<TripHistoryModel>  getRecentTrips( int userid ,String? startDate , String? endDate ,
      int? luggageSpace , String? from , int? commissionStart , int? commissionEnd ) async {

    TripHistoryModel responseModel = await service.getAllTrips(userid,startDate,endDate,luggageSpace,from,commissionStart,commissionEnd);

    return  responseModel;

  }

}