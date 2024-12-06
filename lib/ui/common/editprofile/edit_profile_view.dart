


import 'dart:io';

import 'package:dio/src/multipart_file.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/ui/common/editprofile/edit_profile_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edit_trip_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:typewritertext/typewritertext.dart';

class EditProfileView extends StackedView<EditProfileViewModel>{


  @override
  Widget builder(BuildContext context, EditProfileViewModel viewModel, Widget? child) {
   return editProfileView(context, viewModel);
  }

  @override
  EditProfileViewModel viewModelBuilder(BuildContext context) {
    return EditProfileViewModel();
  }

  @override
  void onDispose(EditProfileViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(EditProfileViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget editProfileView(BuildContext context, EditProfileViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: true,
        onPopInvoked: (value){
          print(value);
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Edit Profile", onBackClicked: () {
              onTapClose();
            }),
            body: Form(
              child: Builder(
                builder: (context) {
                  viewModel.formContext = context;
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(13),
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          GestureDetector(
                            onTap: (){

                            /*  SmartFaceCamera(
                                  autoCapture: true,
                                  defaultCameraLens: CameraLens.front,
                                  message: 'Center your face in the square',
                                  onCapture: (File? image){

                                  });*/
                              showOptions(context,viewModel);
                            },
                            child: SizedBox(
                              height: 77,
                              width: 77,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ValueListenableBuilder<File?>(
                                    valueListenable: viewModel.image,
                                    builder: (context , snapshot , _){
                                      if (snapshot != null) {
                                        return CustomImageView(
                                          imagePath: snapshot.uri.path,
                                          height: 77,
                                          width: 77,
                                          radius: BorderRadius.circular(
                                            38,
                                          ),
                                          alignment: Alignment.center,
                                        ); // Display the image if it's available
                                      } else {
                                       return CustomImageView(
                                          imagePath: UserDataHolder.getInstance().loginData?.data?.user?.profile_picture?.file_preview_path == null ?  ImageConstant.imgUnsplash3jmfencl24m77x77 : UserDataHolder.getInstance().loginData?.data?.user?.profile_picture?.file_preview_path ,
                                          height: 77,
                                          width: 77,
                                          radius: BorderRadius.circular(
                                            38,
                                          ),
                                          alignment: Alignment.center,
                                        ); // Show a placeholder if no image is set
                                      }
                                    },
                                  ),
                                  CustomImageView(
                                    imagePath: ImageConstant.imgTelevisionWhiteA70024x24,
                                    height: 24,
                                    width: 24,
                                    alignment: Alignment.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildNameRow(context,viewModel),
                          SizedBox(height: 16),
                          _buildEmailField(context,viewModel),
                          SizedBox(height: 16),
                          _buildPhoneNumberField(context,viewModel),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomButton("Update Profile", context, onButtonPress: () {
              if(viewModel.validateForm(viewModel.formContext) && (viewModel.isValidPhoneNumver ?? false)){
                onTapUpdateProfileButton(context,viewModel);
              }else{
                print("form is not validated");
              }
            }),
          ),
        ),
      ),
    );
  }

  onTapUpdateProfileButton(BuildContext context , EditProfileViewModel viewModel) {

    print(viewModel.firstNameFieldController.text);
    print(viewModel.lastNameFieldController.text);
    print(viewModel.phoneNumberFieldController.text);
    print(viewModel.emailFieldController.text);
    CustomLoader.showLoader(context);
    viewModel.updateProfile(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,viewModel.firstNameFieldController.text, viewModel.lastNameFieldController.text,
        viewModel.emailFieldController.text, viewModel.phoneNumberFieldController.text,"update_profile").then((value){
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




  Widget _buildFirstNameField(BuildContext context , EditProfileViewModel viewModel) {

    return Container(
      width: MediaQuery.sizeOf(context).width * 0.45,
      margin: EdgeInsets.only( right: 9),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child: CustomFloatingTextField(
        focusNode: viewModel.focusNodeFName,
        width: 172,
        controller: viewModel.firstNameFieldController,
        labelText: "lbl_first_name".tr,
        labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
        hintText: "lbl_first_name".tr,
        validator: viewModel.validateFirstName,
        contentPadding: EdgeInsets.only(top: 18),
        borderDecoration: FloatingTextFormFieldStyleHelper.custom,),
    );
    ;
  }

  /// Section Widget
  Widget _buildLastNameField(BuildContext context, EditProfileViewModel viewModel) {
    return Container(
        width: MediaQuery.sizeOf(context).width * 0.45,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: CustomFloatingTextField(
            width: 172,
            focusNode: viewModel.focusNodeLName,
            controller: viewModel.lastNameFieldController,
            labelText: "lbl_last_name".tr,
            labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
            hintText: "lbl_last_name".tr,
            contentPadding: EdgeInsets.only(top: 18),
            borderDecoration: FloatingTextFormFieldStyleHelper.custom,
            validator: viewModel.validateLastName
        )
    );
  }

  /// Section Widget
  Widget _buildNameRow(BuildContext context, EditProfileViewModel viewModel) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildFirstNameField(context,viewModel),
      _buildLastNameField(context,viewModel)
    ]);
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context , EditProfileViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child: CustomFloatingTextField(
          focusNode: viewModel.focusNodeEmail,
          controller: viewModel.emailFieldController,
          labelText: "lbl_email".tr,
          labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
          hintText: "lbl_email".tr,
          textInputType: TextInputType.emailAddress,
          contentPadding: EdgeInsets.only(top: 18),
          borderDecoration: FloatingTextFormFieldStyleHelper.custom,
          validator: viewModel.validateEmail
      ),

    );
  }

  Widget _buildPhoneNumberField(BuildContext context,EditProfileViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child:  IntlPhoneField(
        focusNode: viewModel.focusNodePhone,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 18),
          labelText: "lbl_phone_number".tr,
          labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
          hintText: "lbl_phone_number".tr,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        initialCountryCode: 'PK',
        initialValue: "1234567",
        languageCode: "en",
        controller: viewModel.phoneNumberFieldController,
        onChanged: (phone) {
          print(phone.completeNumber);
        },
        onCountryChanged: (country) {
          print('Country  to: ' + country.name);
        },
        onSaved: (num){
          print('Country changed to: ' +num!.completeNumber);
        },
        onSubmitted: (num){
        },
        validator: (number){
          if(number!.isValidNumber()) {
            viewModel.isValidPhoneNumver = true;
          }else{
            viewModel.isValidPhoneNumver = false;
          }
        },
        // validator: viewModel.validatePhoneNumber,
      ),


      /*     CustomFloatingTextField(
                controller: viewModel.countryFieldController,
                labelText: "lbl_country".tr,
                labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
                hintText: "lbl_country".tr,
          contentPadding: EdgeInsets.only(top: 18),
          borderDecoration: FloatingTextFormFieldStyleHelper.custom,
                suffix: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomImageView(
                        imagePath: ImageConstant.imgFrame1000001861,
                        height: 24,
                        width: 24)),
                suffixConstraints: BoxConstraints(maxHeight: 60)),*/
    );
  }



  PreferredSizeWidget _buildAppBar(BuildContext context, String title,
      {required Function() onBackClicked}) {
    return CustomAppBar(
        leadingWidth: 26,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgUserPrimary,
            margin: EdgeInsets.only(left: 20, top: 21, bottom: 24),
            onTap: () {
              //onTapClose(context);
              onBackClicked();
            }),
        title: AppbarSubtitleThree(
            text: title, margin: EdgeInsets.only(left: 14)));
  }

  Widget bottomButton(String buttonText, BuildContext context, {required Function() onButtonPress}) {
    return CustomOutlinedButton(
        height: 48,
        text: buttonText,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 34),
        onPressed: () {
          onButtonPress();
          //  onTapPostTrip(context);
        });
  }



  onTapClose() {
    locator<NavigationService>().back();
  }


Future showOptions(BuildContext context , EditProfileViewModel viewModel) async {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      actions: [
        CupertinoActionSheetAction(
          child: Text('Photo Gallery'),
          onPressed: () {
            // close the options modal
            Navigator.of(context).pop();
            // get image from gallery
            viewModel.getImageFromGallery();
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Camera'),
          onPressed: () {
            // close the options modal
            Navigator.of(context).pop();
            // get image from camera
            viewModel.getImageFromCamera();
          },
        ),
      ],
    ),
  );
}

/*
  onTapChangePasswordButton(BuildContext context , EditProfileViewModel viewModel) {

    print(viewModel.emailFieldController.text);
    print(viewModel.passwordConfirmController.text);
    print(viewModel.passwordFieldController.text);
    CustomLoader.showLoader(context);
    viewModel.changePassword(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,"change_password",
        viewModel.passwordFieldController.text,viewModel.passwordConfirmController.text).then((value){
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
*/

}