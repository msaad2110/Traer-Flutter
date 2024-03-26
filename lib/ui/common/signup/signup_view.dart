


import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/signup/signup_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_one.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';


class SignUpView extends StackedView<SignupViewModel>{

  @override
  Widget builder(BuildContext context, SignupViewModel viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (pro){
                return customProgessBar();
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Form(
                    // autovalidateMode: AutovalidateMode.disabled,
                      child: Builder(
                        builder: (context){
                          viewModel.formContext = context;
                          return Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(13),
                              child: Column(children: [
                                _buildNameRow(context,viewModel),
                                SizedBox(height: 16),
                                _buildEmailField(context,viewModel),
                                SizedBox(height: 16),
                                _buildStatusFillTypeDefaultColumn(context,viewModel),
                                SizedBox(height: 16),
                                _buildPhoneNumberField(context,viewModel),
                                SizedBox(height: 16),
                                _buildStatusFillTypeDefault(context,viewModel),
                                SizedBox(height: 16),
                                _buildPassword(context,viewModel),
                                SizedBox(height: 16),
                                _buildCreateAnAccountButton(context,viewModel),
                                SizedBox(height: 0),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    checkColor: ColorsField.whiteColor,
                                    activeColor: theme.colorScheme.primary,
                                    title: Text(
                                        "msg_join_as_a_traveler".tr,
                                        style: CustomTextStyles
                                            .titleSmallBlack900_1),
                                    value: viewModel.isJoinTraveler,
                                    onChanged: (newValue) {
                                      viewModel.updateJoinTraveler(newValue!);
                                    },
                                    controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      "msg_get_commission_on"
                                          .tr,
                                      style: CustomTextStyles
                                          .bodySmallGray600),
                                ),

                                /*Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 3, right: 82),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CheckboxListTile(
                                                title: Text(
                                                    "msg_join_as_a_traveler".tr,
                                                    style: CustomTextStyles
                                                        .titleSmallBlack900_1),
                                                value: true,
                                                onChanged: (newValue) {
                                                  print(newValue);
                                                },
                                                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                                              ),
                                              Text(
                                                  "msg_get_commission_on"
                                                      .tr,
                                                  style: CustomTextStyles
                                                      .bodySmallGray600),

                                              CustomImageView(
                                                  imagePath:
                                                  ImageConstant.imgThumbsUpPrimary,
                                                  height: 18,
                                                  width: 16,
                                                  margin: EdgeInsets.only(bottom: 22)),


                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, top: 2),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                            "msg_join_as_a_traveler".tr,
                                                            style: CustomTextStyles
                                                                .titleSmallBlack900_1),
                                                        SizedBox(height: 6),
                                                        Text(
                                                            "msg_get_commission_on"
                                                                .tr,
                                                            style: CustomTextStyles
                                                                .bodySmallGray600)
                                                      ]))
                                            ]))),*/
                                SizedBox(height: 10),
                                GestureDetector(
                                    onTap: () {
                                      onTapTxtAlreadyhavean(context);
                                    },
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "msg_already_have_an2".tr,
                                              style: CustomTextStyles.titleSmallBlack900),
                                          TextSpan(text: " "),
                                          TextSpan(
                                              text: "lbl_sign_in2".tr,
                                              style: CustomTextStyles.titleSmallPrimary)
                                        ]),
                                        textAlign: TextAlign.left)),
                                SizedBox(height: 5),

                              ]));
                        },
                      )),
                ),
              ),
            )));
  }

  @override
  SignupViewModel viewModelBuilder(BuildContext context) {
    return SignupViewModel();
  }

  @override
  void onViewModelReady(SignupViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }


  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;


  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 32,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeftPrimary,
            margin: EdgeInsets.only(left: 9, top: 18, bottom: 21),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleOne(text: "lbl_sign_up".tr));
  }

  /// Section Widget
  Widget _buildFirstNameField(BuildContext context , SignupViewModel viewModel) {

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
  Widget _buildLastNameField(BuildContext context, SignupViewModel viewModel) {
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
  Widget _buildNameRow(BuildContext context, SignupViewModel viewModel) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _buildFirstNameField(context,viewModel),
      _buildLastNameField(context,viewModel)
    ]);
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context , SignupViewModel viewModel) {
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

  /// Section Widget
  Widget _buildCountrySelectionrField(BuildContext context,SignupViewModel viewModel) {
    return  Container(
      width: MediaQuery.sizeOf(context).width,

      child: CountryCodePicker(
        padding: EdgeInsets.only(right: 0),
        showDropDownButton: true,
        flagWidth: 30,
        onChanged: (c){
          viewModel.setCountry(c.name ?? "");
        },
        onInit: (c){
          viewModel.selectedCountry = c!.name ?? "";
          //viewModel.setCountry(c?.name ?? "");
        },
        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
        initialSelection: 'PK',
        favorite: ['+39','FR'],
        // optional. Shows only country name and flag
        showCountryOnly: true,
        // optional. Shows only country name and flag when popup is closed.
        showOnlyCountryWhenClosed: true,
        // optional. aligns the flag and the Text left
        alignLeft: true,

      ),
    );
    CustomFloatingTextField(

        controller: viewModel.phoneNumberFieldController,
        labelText: "lbl_phone_number".tr,
        labelStyle: CustomTextStyles.titleMediumPrimaryContainer_1,
        hintText: "lbl_phone_number".tr,
        textInputType: TextInputType.phone,
        validator: (value) {
          /*if (!isValidPhone(value)) {
                  return "err_msg_please_enter_valid_phone_number".tr;
                }*/
          return null;
        },
        contentPadding: EdgeInsets.only(top: 18),
        borderDecoration: FloatingTextFormFieldStyleHelper.custom,
        filled: false);
    ;
  }

  /// Section Widget
  Widget _buildStatusFillTypeDefaultColumn(BuildContext context , SignupViewModel signupViewModel) {
    return Container(
        padding: EdgeInsets.only(left: 0, top: 5,bottom: 5,right: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: _buildCountrySelectionrField(context , signupViewModel));
  }

  /// Section Widget
  Widget _buildPhoneNumberField(BuildContext context,SignupViewModel viewModel) {
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

  /// Section Widget
  Widget _buildPasswordField(BuildContext context , SignupViewModel viewModel) {
    return  Container(
      child: CustomFloatingTextField(
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

  /// Section Widget
  Widget _buildStatusFillTypeDefault(BuildContext context, SignupViewModel viewModel) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: _buildPasswordField(context,viewModel));
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context , SignupViewModel viewModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: AppDecoration.fillGray10001
          .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
      child: CustomFloatingTextField(
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

  /// Section Widget
  Widget _buildCreateAnAccountButton(BuildContext context , SignupViewModel viewModel) {
    return CustomOutlinedButton(
        height: 48,
        text: "msg_create_an_account".tr,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles.titleMediumOnErrorContainerSemiBold,
        onPressed: () {
          if(viewModel.validateForm(viewModel.formContext) && (viewModel.isValidPhoneNumver ?? false)){
            onTapCreateAnAccountButton(context,viewModel);
          }else{
            print("form is not validated");
          }
        });
  }

  /// Navigates to the previous screen.
  onTapArrowLeft(BuildContext context) {
    // NavigatorService.goBack();
  }

  /// Navigates to the idVerificationScreen when the action is triggered.
  onTapCreateAnAccountButton(BuildContext context , SignupViewModel viewModel) {

    print(viewModel.firstNameFieldController.text);
    print(viewModel.lastNameFieldController.text);
    print(viewModel.selectedCountry);
    print(viewModel.phoneNumberFieldController.text);
    print(viewModel.emailFieldController.text);
    print(viewModel.passwordConfirmController.text);
    print(viewModel.passwordFieldController.text);
    print(viewModel.isJoinTraveler == true ? "1" : "0");
    CustomLoader.showLoader(context);
    viewModel.userRegister(viewModel.firstNameFieldController.text, viewModel.lastNameFieldController.text,
        viewModel.selectedCountry,viewModel.phoneNumberFieldController.text,viewModel.emailFieldController.text,
        viewModel.passwordFieldController.text,viewModel.passwordConfirmController.text , viewModel.isJoinTraveler == true ? "1" : "0").then((value){
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



  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtAlreadyhavean(BuildContext context) {
   locator<NavigationService>().navigateTo(Routes.loginView);
  }


}