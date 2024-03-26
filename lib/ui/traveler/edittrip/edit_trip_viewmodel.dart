


import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/edittripdata.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/network/restservice.dart';

class EditTripViewModel extends BaseViewModel{


  final service = locator<RestService>();

  PageController pageController  = PageController(initialPage: 0);

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    //notifyListeners();
  }


  Future<GeneralResponse>  updateTrip( int tripID , int user_id ,  int luggage_type_id,   String travelling_from, String travelling_to,  String start_date,   String end_date,  int luggage_space , int commission) async {

    GeneralResponse responseModel = await service.updateTrip(tripID,user_id,luggage_type_id,travelling_from,travelling_to,start_date,end_date,commission,luggage_space);

    return  responseModel;

  }

  (bool,String) validateEditTripData(){
    if(EditTripData.getInstance().destinationCity == null){
      return (false,"Please Select Destination");
    }else if(EditTripData.getInstance().originCity == null){
      return (false,"Please Select Origin");
    }else if(EditTripData.getInstance().startDate == null){
      return (false,"Please Select Date");
    } else if(EditTripData.getInstance().endDateDate == null){
      return (false,"Please Select Date");
    } else if(EditTripData.getInstance().luggageSpace == null){
      return (false,"Please enter luggage space");
    }else if(EditTripData.getInstance().luggageType == null){
      return (false,"Please enter luggage Type");
    }else if(EditTripData.getInstance().commission == null){
      return (false,"Please enter Commission");
    }else{
      return (true,"");
    }
  }

}