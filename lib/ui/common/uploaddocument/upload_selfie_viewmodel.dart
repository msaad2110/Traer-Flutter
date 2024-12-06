import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/dialog.dart';
import 'dart:io';
import 'package:traer/widgets/custom_loader.dart';

class UploadSelfieViewModel extends BaseViewModel{
  final service = locator<RestService>();


  Future<GeneralResponse>  uploadDocuments(int userID ,List<int> documentTypeId,List<File> documentArray) async {

    GeneralResponse responseModel = await service.uploadDocuments(userID,documentTypeId,documentArray);

    return  responseModel;

  }


  uploadDocumentsAPI(BuildContext context , List<int> documentTypeId,List<File> documentArray) {

    documentTypeId.forEach((element) {
      print("element");
      print(element);
    });

    documentArray.forEach((element) {
      print("element1");
      print(element);
    });

    CustomLoader.showLoader(context);
    uploadDocuments(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,documentTypeId,documentArray).then((value){
      print(value);
      CustomLoader.hideLoader(context);
      if(value.success ?? false){
        CustomDialog.showSuccessDialog(context,message: value.message ?? "" , onPressedDialog: (){
          locator<NavigationService>().navigateTo(Routes.loginView);
        });
      }else{
        CustomDialog.showErrorDialog(context,message: value.message ?? "", onPressedDialog: (){
          Navigator.pop(context);
        });
      }
    }).catchError((onError){
      CustomLoader.hideLoader(context);
      CustomDialog.showErrorDialog(context, onPressedDialog: (){
        Navigator.pop(context);
      });
      print("onError.toString()");
      print(onError.toString());
    });
  }
}