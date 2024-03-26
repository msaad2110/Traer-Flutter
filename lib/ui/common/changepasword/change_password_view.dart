



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
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
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/changepasword/change_password_viewmodel.dart';
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

class ChangePasswordView extends StackedView<ChangePasswordViewModel>{


  @override
  Widget builder(BuildContext context, ChangePasswordViewModel viewModel, Widget? child) {
   return changePasswordView(context, viewModel);
  }

  @override
  ChangePasswordViewModel viewModelBuilder(BuildContext context) {
    return ChangePasswordViewModel();
  }


  @override
  void onDispose(ChangePasswordViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(ChangePasswordViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }


  @override
  bool get reactive => super.reactive;


  Widget changePasswordView(BuildContext context, ChangePasswordViewModel viewModel) {
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
            appBar: _buildAppBar(context, "Chnage Password", onBackClicked: () {
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
                                "Upgrade Security: Boost your account's safety with a new password.",
                                duration: Duration(milliseconds: 50),
                                builder: (context , value){
                                  return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme.colorScheme.onSecondaryContainer));
                                }),
                          ),
                          SizedBox(height: 7),
                          _builOldPasswordDefault(context, viewModel),
                           SizedBox(height: 7),
                          _buildStatusFillTypeDefault(context, viewModel),
                          SizedBox(height: 7),
                          _buildPassword(context, viewModel)
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomButton("Change Password", context, onButtonPress: () {
              if(viewModel.validateForm(viewModel.formContext)){
                onTapChangePasswordButton(context,viewModel);
              }else{
                print("form is not validated");
              }
            }),
          ),
        ),
      ),
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


  Widget _buildEmailField(BuildContext context , ChangePasswordViewModel viewModel) {
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

  onTapClose() {
    locator<NavigationService>().back();
  }

  Widget _buildPasswordField(BuildContext context , ChangePasswordViewModel viewModel) {
    return  Container(
      child: CustomFloatingTextField(
        autofocus: false,
          focusNode: viewModel.focusNodePassword,
          controller: viewModel.passwordFieldController,
          labelText: "lbl_password".tr,
          labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
          hintText: "lbl_password".tr,
          suffix: GestureDetector(
              onTap: () {
                viewModel.togglevisibilityPassword();
              },
              child: Icon(viewModel.showPassword ?  Icons.visibility : Icons.visibility_off )
          ),
          textInputType: TextInputType.visiblePassword,
          obscureText: !viewModel.showPassword,
          validator: viewModel.validatePassword,
          contentPadding: EdgeInsets.only(top: 18),
          borderDecoration: FloatingTextFormFieldStyleHelper.custom,
          filled: false),
    );

  }


  Widget _buildStatusFillTypeDefault(BuildContext context, ChangePasswordViewModel viewModel) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: _buildPasswordField(context,viewModel));
  }


  Widget _buildoldPasswordField(BuildContext context , ChangePasswordViewModel viewModel) {
    return  Container(
      child: CustomFloatingTextField(
          autofocus: false,
          focusNode: viewModel.focusNodeoldPasword,
          controller: viewModel.oldpasswordController,
          labelText: "lbl_old_password".tr,
          labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
          hintText: "lbl_old_password".tr,
          suffix: GestureDetector(
              onTap: () {
                viewModel.togglevisibilityOldPassword();
              },
              child: Icon(viewModel.showOldPassword ?  Icons.visibility : Icons.visibility_off )
          ),
          textInputType: TextInputType.visiblePassword,
          obscureText: !viewModel.showOldPassword,
          validator: viewModel.validateOldPassword,
          contentPadding: EdgeInsets.only(top: 18),
          borderDecoration: FloatingTextFormFieldStyleHelper.custom,
          filled: false),
    );

  }


  Widget _builOldPasswordDefault(BuildContext context, ChangePasswordViewModel viewModel) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: _buildoldPasswordField(context,viewModel));
  }


  Widget _buildPassword(BuildContext context , ChangePasswordViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child: CustomFloatingTextField(
          autofocus: false,
          focusNode: viewModel.focusNodeConfirmPasword,
          controller: viewModel.passwordConfirmController,
          labelText: "msg_re_enter_password".tr,
          labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
          hintText: "msg_re_enter_password".tr,
          suffix: GestureDetector(
              onTap: () {
                viewModel.togglevisibilityConfirmPassword();
              },
              child: Icon(viewModel.showPasswordConfirm ?  Icons.visibility : Icons.visibility_off )
          ),
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: !viewModel.showPasswordConfirm,
          contentPadding: EdgeInsets.only(top: 18),
          borderDecoration: FloatingTextFormFieldStyleHelper.custom,
          validator: viewModel.validateConfirmPassword),
    );
  }



  onTapChangePasswordButton(BuildContext context , ChangePasswordViewModel viewModel) {

    print(viewModel.emailFieldController.text);
    print(viewModel.passwordConfirmController.text);
    print(viewModel.passwordFieldController.text);
    CustomLoader.showLoader(context);
    viewModel.changePassword(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,"change_password",
        viewModel.passwordFieldController.text,viewModel.passwordConfirmController.text ,viewModel.oldpasswordController.text).then((value){
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