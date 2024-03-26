


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/ui/common/forgotpassword/fg_verify_otp_viewmodel.dart';
import 'package:traer/ui/common/forgotpassword/forgot_password_viewmodel.dart';
import 'package:traer/ui/common/forgotpassword/fp_send_otp_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../provider/theme_helper.dart';

class ForgotPaswordView extends StackedView<ForgotPasswordViewModel>{

  @override
  Widget builder(BuildContext context, ForgotPasswordViewModel viewModel, Widget? child) {
   return mainView(context, viewModel);
  }

  @override
  ForgotPasswordViewModel viewModelBuilder(BuildContext context) {
    return ForgotPasswordViewModel();
  }

  @override
  void onViewModelReady(ForgotPasswordViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  @override
  void onDispose(ForgotPasswordViewModel viewModel) {
    super.onDispose(viewModel);
  }

  Widget mainView(BuildContext context, ForgotPasswordViewModel viewModel) {
    return PageView.builder(
      controller: viewModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2, // Number of screens
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return SendOTPScreen(viewModel);
          case 1:
            return VerifyOTPScreen(viewModel);
          default:
            return SendOTPScreen(viewModel); // Handle unexpected indices
        }
      },
    );
  }


}

class SendOTPScreen extends StackedView<ForgotPasswordSendOTPViewModel>{
  ForgotPasswordViewModel parentViewModel;


  SendOTPScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, ForgotPasswordSendOTPViewModel viewModel, Widget? child) {
    return sendOTPView(context, viewModel);
  }

  @override
  ForgotPasswordSendOTPViewModel viewModelBuilder(BuildContext context) {
    return ForgotPasswordSendOTPViewModel();
  }

  @override
  void onDispose(ForgotPasswordSendOTPViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(ForgotPasswordSendOTPViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  onTapClose() {
    locator<NavigationService>().back();
  }

  Widget sendOTPView(BuildContext context, ForgotPasswordSendOTPViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: true,
        onPopInvoked: (value){
          print(value);
        //  onTapClose();
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Forgot Password", onBackClicked: () {
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
                          SizedBox(height: 7),
                          //_buildEmailField(context, viewModel),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TypeWriterText.builder(
                                "Recover Your Password: Get a secure OTP sent to your email to reset your password.",
                                duration: Duration(milliseconds: 50),
                                builder: (context , value){
                                  return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme.colorScheme.onSecondaryContainer));
                                }),
                          ),
                          SizedBox(height: 7),
                          _buildEmailField(context, viewModel),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomButton("Send OTP", context, onButtonPress: () {
              if(viewModel.validateForm(viewModel.formContext)){
                onTapSendOTPButton(context,viewModel);
              }else{
                print("form is not validated");
              }
            }),
          ),
        ),
      ),
    );
  }


  onTapSendOTPButton(BuildContext context , ForgotPasswordSendOTPViewModel viewModel) {

    print(viewModel.emailFieldController.text);

    CustomLoader.showLoader(context);
    viewModel.sendOTP(viewModel.emailFieldController.text).then((value){
      print(value);
      CustomLoader.hideLoader(context);
      if(value.success ?? false){
        parentViewModel.email = viewModel.emailFieldController.text;
        parentViewModel.setCurrentIndex(1);

        /*CustomDialog.showSuccessDialog(context,message: value.message ?? "" , onPressedDialog: (){
          locator<NavigationService>().navigateTo(Routes.loginView);
        });*/
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


  PreferredSizeWidget _buildAppBar(BuildContext context, String title, {required Function() onBackClicked}) {
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


  Widget _buildEmailField(BuildContext context , ForgotPasswordSendOTPViewModel viewModel) {
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



}


class VerifyOTPScreen extends StackedView<ForgotPasswordVerifyOTPViewModel>{

  ForgotPasswordViewModel parentViewModel;


  VerifyOTPScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, ForgotPasswordVerifyOTPViewModel viewModel, Widget? child) {
    return verifyOTPView(context, viewModel);
  }

  @override
  ForgotPasswordVerifyOTPViewModel viewModelBuilder(BuildContext context) {
    return ForgotPasswordVerifyOTPViewModel();
  }

  @override
  void onDispose(ForgotPasswordVerifyOTPViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(ForgotPasswordVerifyOTPViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget verifyOTPView(BuildContext context, ForgotPasswordVerifyOTPViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          print(value);
          onTapClose();
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Forgot Password", onBackClicked: () {
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
                          SizedBox(height: 7),
                      //_buildEmailField(context, viewModel),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TypeWriterText.builder(
                            "One step away: Enter the code to create a new password and secure your account.",
                            duration: Duration(milliseconds: 50),
                            builder: (context , value){
                              return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                                  color: theme.colorScheme.onSecondaryContainer));
                            }),
                      ),
                      SizedBox(height: 7),
                            _buildOTPField(context, viewModel)
                      ],
                    ),
                  ),
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomButton("Verify OTP", context, onButtonPress: () {

              if(viewModel.otpFieldController.text.length < 6){
                CustomDialog.showErrorDialog(context,message: "please enter OTP" ?? "", onPressedDialog: (){
                  Navigator.pop(context);
                });
              }else{
                onTapVerifyOTPButton(context, viewModel);
              }
            }),
          ),
        ),
      ),
    );
  }




  onTapVerifyOTPButton(BuildContext context , ForgotPasswordVerifyOTPViewModel viewModel) {
    CustomLoader.showLoader(context);
    viewModel.verifyOTP(parentViewModel.email , viewModel.otpFieldController.text ).then((value){
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

  PreferredSizeWidget _buildAppBar(BuildContext context, String title, {required Function() onBackClicked}) {
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


  Widget _buildOTPField(BuildContext context , ForgotPasswordVerifyOTPViewModel viewModel) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20, top: 20,bottom: 10),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child: PinCodeTextField(
        appContext: context,
        length: 6,
        obscureText: false,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
        ),
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: Colors.blue.shade50,
        enableActiveFill: false,
        controller: viewModel.otpFieldController,
        keyboardType: TextInputType.number,
        onCompleted: (v) {
          print("Completed");
          print(v);
          print(viewModel.otpFieldController);
        },
        onChanged: (value) {
          print(value);
        /*  print(value);
          setState(() {
            currentText = value;
          });*/
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
          //but you can show anything you want here, like your pop up saying wrong paste format or etc
          return true;
        },
      )

    );
  }

  onTapClose() {
    parentViewModel.setCurrentIndex(0);
  }

}