



import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/models/user_profile.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/dialog.dart';

class NewOrderFindUserViewModel extends BaseViewModel{


  late BuildContext formContext;
  TextEditingController emailFieldController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  final service = locator<RestService>();

  Future<UserProfile>  getUser(String email ) async {

    UserProfile responseModel = await service.getUser(email);

    return  responseModel;

  }


  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }

  String? validateEmail(String? value){

    if(value!.isEmpty){
      return "please enter email";
    }
    return null;
  }


  bool isEmailSame(String? value , BuildContext c){

    if(value == UserDataHolder.getInstance().loginData?.data?.user?.email){
      CustomDialog.showErrorDialog(c,message: "You cannot assign order yourself...", onPressedDialog: (){
        Navigator.pop(c);
      });
      return true;
    }
    return false;
  }
}