

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/LoginItemModel.dart';
import 'package:traer/models/login_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/ui/common/login/login_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/utils/pref_utils.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';

class LoginView extends StackedView<LoginViewModel>{


  @override
  Widget builder(BuildContext context, LoginViewModel viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (pro){
                return customProgessBar();
              },
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Builder(
                    builder: (context){
                      viewModel.formContext = context;
                      return Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 50),
                          child: Column(children: [
                            SizedBox(height: 17),
                           // _buildLoginSection(context,viewModel),
                            _buildImage(ImageConstant.imglogin,MediaQuery.sizeOf(context).width),
                            SizedBox(height: 36),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: _buildEmailField(context, viewModel)
                                    ),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child:  _buildPasswordField(context, viewModel)
                                    ),
                            SizedBox(height: 10),
                            CustomOutlinedButton(
                                height: 48,
                                text: "lbl_log_in".tr,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
                                buttonTextStyle: CustomTextStyles
                                    .titleMediumOnErrorContainerSemiBold,
                                onPressed: () {
                                  if(viewModel.validateForm(viewModel.formContext)){
                                    print("object");
                                    onTapLogIn(context,viewModel);
                                  }else{
                                    print("form is not validated");
                                  }
              
                                }),
                            SizedBox(height: 8),
                            GestureDetector(
                              onTap: (){
                                locator<NavigationService>().navigateTo(Routes.forgotPaswordView);
                              },
                              child: Text("msg_forgot_password".tr,
                                  style: CustomTextStyles.titleSmallPrimaryContainer),
                            ),
                            // SizedBox(height: 72),
                            // Align(
                            //     alignment: Alignment.centerLeft,
                            //     child: Padding(
                            //         padding: EdgeInsets.only(left: 16),
                            //         child: Text("msg_log_in_with_socials".tr,
                            //             style: CustomTextStyles
                            //                 .titleMediumBluegray400))),
                            // SizedBox(height: 15),
                            // _buildFrameTwoSection(context),
                            SizedBox(height: 31),
                            GestureDetector(
                                onTap: () {
                                  onTapTxtDonthaveanaccount(context);
                                },
                                child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: "msg_don_t_have_an_account2".tr,
                                          style: CustomTextStyles.titleSmallBlack900),
                                      TextSpan(text: " "),
                                      TextSpan(
                                          text: "lbl_become_a_member".tr,
                                          style: CustomTextStyles.titleSmallPrimary)
                                    ]),
                                    textAlign: TextAlign.left))
                          ]));
                    },
                  ) ),
            )));
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) {
   return LoginViewModel();
  }

  @override
  void onViewModelReady(LoginViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

  /// Section Widget
  Widget _buildLoginSection(BuildContext context , LoginViewModel loginViewModel) {
    return SizedBox(
        width: double.maxFinite,
        height: 200,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child:  StaggeredGridView.countBuilder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            primary: false,
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            staggeredTileBuilder: (index) {
                              return StaggeredTile.fit(2);
                            },
                            itemCount: loginViewModel.loginItemList.length,
                            itemBuilder: (context, index) {
                              LoginItemModel model = loginViewModel.loginItemList[index];
                              return buildStrageredItem(model);
                            })
                      ),
             /* Padding(
                  padding: EdgeInsets.only(bottom: 55),
                  child: Column(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle13,
                        height: 100,
                        width: 100,
                        radius: BorderRadius.circular(4)),
                    SizedBox(height: 16),
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle17,
                        height: 100,
                        width: 100,
                        radius: BorderRadius.circular(4))
                  ])),
              Padding(
                  padding: EdgeInsets.only(top: 45, bottom: 10),
                  child: Column(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle14,
                        height: 100,
                        width: 63,
                        radius: BorderRadius.circular(4)),
                    SizedBox(height: 16),
                    CustomImageView(
                        imagePath: ImageConstant.imgRectangle18,
                        height: 100,
                        width: 63,
                        radius: BorderRadius.circular(4))
                  ]))*/
            ]));
  }


  Widget _buildImage(String assetName,double width) {
    return SafeArea(child: Container(width: width , color : Colors.white,child: Image.asset('$assetName',fit: BoxFit.fill, width: double.infinity,)));
  }

  /// Section Widget
  Widget _buildFrameTwoSection(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: 48,
              width: 112,
              padding: EdgeInsets.symmetric(horizontal: 46, vertical: 12),
              decoration: AppDecoration.outlineBlack
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: CustomImageView(
                  imagePath: ImageConstant.imgUser,
                  height: 22,
                  width: 17,
                  alignment: Alignment.center)),
          Container(
              height: 48,
              width: 112,
              margin: EdgeInsets.only(left: 11),
              padding: EdgeInsets.symmetric(horizontal: 45, vertical: 12),
              decoration: AppDecoration.outlineBlack900
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: CustomImageView(
                  imagePath: ImageConstant.imgIcon,
                  height: 22,
                  width: 20,
                  alignment: Alignment.center)),
          Container(
              height: 48,
              width: 112,
              margin: EdgeInsets.only(left: 11),
              padding: EdgeInsets.symmetric(horizontal: 46, vertical: 14),
              decoration: AppDecoration.fillPrimary
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: CustomImageView(
                  imagePath: ImageConstant.imgFacebook,
                  height: 20,
                  width: 20,
                  alignment: Alignment.center))
        ]));
  }

  /// Navigates to the travelerHomepageContainer1Screen when the action is triggered.
  onTapLogIn(BuildContext context , LoginViewModel viewModel) {
    CustomLoader.showLoader(context);
  //  viewModel.login("shaheerzaeem26@gmail.com", "test_password").then((value){
    viewModel.login(viewModel.emailController.text, viewModel.passwordController.text).then((value) async{
      CustomLoader.hideLoader(context);

      if(value.success ?? false){
        await PrefUtils().save(PrefUtils.token, value.data!.token);
        isSaveUserData(value);
        viewModel.updateToken();
        locator<NavigationService>().pushNamedAndRemoveUntil(Routes.mainView);
      }else{
        CustomDialog.showErrorDialog(context,message: value.message ?? "" , onPressedDialog: (){
          Navigator.pop(context);
        });
      }
      print("value");
    }).catchError((onError){
      print(onError.toString());
      CustomLoader.hideLoader(context);
      CustomDialog.showErrorDialog(context, onPressedDialog: (){
        Navigator.pop(context);
      });
      print(onError.toString());
    });
   // locator<NavigationService>().navigateTo(Routes.splashView);
  }

  /// Navigates to the signUpScreen when the action is triggered.
  onTapTxtDonthaveanaccount(BuildContext context) {
    locator<NavigationService>().navigateTo(Routes.signUpView);
  }


  Widget buildStrageredItem(LoginItemModel model){
    return CustomImageView(
      imagePath: model.rectangle,
      height: 100,
      width: 82,
      radius: BorderRadius.circular(
        4,
      ),
    );
  }


  Widget _buildEmailField(BuildContext context , LoginViewModel viewModel) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: CustomFloatingTextField(
            controller: viewModel.emailController,
            labelText: "msg_username_email".tr,
            labelStyle: CustomTextStyles
                .titleMediumPrimaryContainer_1,
            focusNode: viewModel.focusNodeEmail,
            hintText: "msg_username_email".tr,
            textInputType: TextInputType.emailAddress,
            borderDecoration: FloatingTextFormFieldStyleHelper.custom,
            contentPadding: EdgeInsets.only(top: 18),
            validator: viewModel.validateEmail
            ));
  }

  Widget _buildPasswordField(BuildContext context , LoginViewModel viewModel) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        margin: EdgeInsets.symmetric(horizontal: 0),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: CustomFloatingTextField(
            controller: viewModel.passwordController,
            labelText: "lbl_password".tr,
            labelStyle: CustomTextStyles
                .titleMediumPrimaryContainer_1,
            hintText: "lbl_password".tr,
            textInputAction: TextInputAction.done,
            textInputType:
            TextInputType.visiblePassword,
            focusNode: viewModel.focusNodePassword,
            borderDecoration: FloatingTextFormFieldStyleHelper.custom,
            contentPadding: EdgeInsets.only(top: 18),
            obscureText: true,
            validator: viewModel.validatePassword
            ));
  }

  isSaveUserData(LoginResponse loginResponse) async {

    if(PrefUtils().getIsRememberUser()){
      print("remembered");
      await PrefUtils().save(PrefUtils.userData, loginResponse);
      UserDataHolder.getInstance().loginData = await LoginResponse.fromJson(await PrefUtils().read(PrefUtils.userData));

    }else{
      print("not remembered");
      UserDataHolder.getInstance().loginData = loginResponse;
    }


  }

}