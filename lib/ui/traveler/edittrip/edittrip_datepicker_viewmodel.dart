


import 'package:stacked/stacked.dart';
import 'package:traer/models/edittripdata.dart';

class EditTripDatePickerViewModel extends BaseViewModel{
  var defaultStartDate = EditTripData.getInstance().startDate;
  var defaultEndDate = EditTripData.getInstance().endDateDate;



  void updateDate(){
    defaultStartDate = isTimePassed(EditTripData.getInstance().startDate ?? DateTime.now()) ? DateTime.now() : EditTripData.getInstance().startDate;
    defaultEndDate = isTimePassed(EditTripData.getInstance().endDateDate ?? DateTime.now()) ? DateTime.now().add(const Duration(days: 10)) : defaultStartDate?.add(const Duration(days: 10));

   /* if(isTimePassed(EditTripData.getInstance().endDateDate ?? DateTime.now())){
      defaultEndDate  = DateTime.now().add(const Duration(days: 10));
      print("first one");
    }else{
      defaultEndDate =  defaultStartDate?.add(const Duration(days: 10));
      print("second one");
    }*/

  }

  bool isTimePassed(DateTime time) {
    final now = DateTime.now();
    return time.isBefore(now);
  }
}