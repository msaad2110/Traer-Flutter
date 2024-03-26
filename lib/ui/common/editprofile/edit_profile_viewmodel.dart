


import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/models/general_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/network/restservice.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/widgets/custom_loader.dart';

class EditProfileViewModel extends BaseViewModel{
  final service = locator<RestService>();
  late BuildContext formContext;
  ValueNotifier<File?>  image = ValueNotifier<File?>(null);

  final picker = ImagePicker();

  TextEditingController firstNameFieldController = TextEditingController();
  TextEditingController lastNameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneNumberFieldController = TextEditingController();
  FocusNode focusNodeFName = FocusNode();
  FocusNode focusNodeLName = FocusNode();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePhone = FocusNode();
  bool? isValidPhoneNumver = false;


  Future<GeneralResponse>  updateProfile(int userID ,String fName , String lName , String email , String phone , String action) async {

    GeneralResponse responseModel = await service.updateProfile(userID,fName,lName,email,phone,action);

    return  responseModel;

  }


  Future<GeneralResponse>  uploadProfilePicture(int userID ,String action , int documentTypeID ,File picture) async {

    GeneralResponse responseModel = await service.uploadProfilePicture(userID,action,documentTypeID,picture);

    return  responseModel;

  }


  String? validateFirstName(String? value){

    if(value!.isEmpty){
      return "please enter first name";
    }
    return null;
  }

  String? validateLastName(String? value){

    if(value!.isEmpty){
      return "please enter last name";
    }
    return null;
  }

  String? validateEmail(String? value){

    if(value!.isEmpty){
      return "please enter email";
    }
    return null;
  }

  bool validateForm(BuildContext context){
    return Form.of(context).validate();
  }


  //Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);


      uploadPicture(StackedService.navigatorKey!.currentState!.context);

    }

  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);



      uploadPicture(StackedService.navigatorKey!.currentState!.context);
    }

  }


  uploadPicture(BuildContext context) {

    CustomLoader.showLoader(context);
    uploadProfilePicture(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,"profile-picture" ,1, image.value!).then((value){
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