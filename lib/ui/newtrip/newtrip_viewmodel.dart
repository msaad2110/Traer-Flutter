import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/LoginItemModel.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/newtripdata.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/image_constant.dart';


class NewTripViewModel extends BaseViewModel{
  final service = locator<RestService>();

  PageController pageController  = PageController(initialPage: 0);

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    //notifyListeners();
  }


  Future<GeneralResponse>  newTrip( int user_id ,  int luggage_type_id,   String travelling_from, String travelling_to,  String start_date,   String end_date,  int luggage_space , int commission) async {

    GeneralResponse responseModel = await service.newTrip(user_id,luggage_type_id,travelling_from,travelling_to,start_date,end_date,luggage_space , commission);

    return  responseModel;

  }

   (bool,String) validateNewTripData(){
    if(NewTripData.getInstance().destinationCity == null){
       return (false,"Please Select Destination");
    }else if(NewTripData.getInstance().originCity == null){
      return (false,"Please Select Origin");
    }else if(NewTripData.getInstance().startDate == null){
      return (false,"Please Select Date");
    } else if(NewTripData.getInstance().endDateDate == null){
      return (false,"Please Select Date");
    } else if(NewTripData.getInstance().luggageSpace == null){
      return (false,"Please enter luggage space");
    }else if(NewTripData.getInstance().luggageType == null){
      return (false,"Please enter luggage Type");
    }else if(NewTripData.getInstance().commission == null){
      return (false,"Please enter Commission");
    }else{
      return (true,"");
    }
  }
}