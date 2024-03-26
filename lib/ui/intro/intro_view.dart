

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/ui/intro/intro_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/custom_elevated_button.dart';
import 'package:traer/widgets/custom_outlined_button.dart';

class IntroView extends StackedView<IntroViewModel>{

  @override
  Widget builder(BuildContext context, IntroViewModel viewModel, Widget? child) {
    return Scaffold(
      body: parentView(context),
    );
  }

  @override
  IntroViewModel viewModelBuilder(BuildContext context) {
    return IntroViewModel();
  }

  @override
  void onViewModelReady(IntroViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget parentView(BuildContext context) {

    var  bodyStyle = TextStyle(fontSize: 19.0);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      infiniteAutoScroll: true,
      /*globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: _buildImage('flutter.png'),
          ),
        ),
      ),*/
      globalFooter: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: 60,
        child: buildBottomButton(context),
      ),
      pages: [
        firstPage(pageDecoration,context),
        secondPage(pageDecoration,context),
        firstPage(pageDecoration,context),
        secondPage(pageDecoration,context),

      ],
      onDone: () => _onIntroEnd(),
      onSkip: () => _onIntroEnd(),
      // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600 , color: ColorsField.blackColor,)),
      next: const Icon(Icons.arrow_forward , color: ColorsField.blackColor,),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600 , color: ColorsField.blackColor,)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeColor: ColorsField.blackColor,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),

    );
  }


  PageViewModel firstPage(PageDecoration pageDecoration , BuildContext context){

    return PageViewModel(
      title: "lbl_send_anywhere".tr,
      body: "msg_lorem_ipsum_dolor".tr,
      image: _buildImage(ImageConstant.imglogin,MediaQuery.sizeOf(context).width),
      decoration: pageDecoration,
    );
  }

  PageViewModel secondPage(PageDecoration pageDecoration , BuildContext context){

    return PageViewModel(
      title: "lbl_send_anywhere".tr,
      body: "msg_lorem_ipsum_dolor".tr,
      image: _buildImage(ImageConstant.imgIntro,MediaQuery.sizeOf(context).width * 0.8),
      decoration: pageDecoration,
    );
  }


  Widget _buildImage(String assetName,double width) {
    return SafeArea(child: Container(width: width , color : Colors.white,child: Image.asset('$assetName',fit: BoxFit.fill, width: double.infinity,)));
  }

  void _onIntroEnd() {
    locator<NavigationService>().navigateTo(Routes.splashView);
  }


  Widget buildBottomButton(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomOutlinedButton(
                      height: 48,
                      width :MediaQuery.sizeOf(context).width * 0.4,
                      text: "lbl_get_started".tr,
                      margin: EdgeInsets.only(left: 5),
                      buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700SemiBold,
                      onPressed: () {
                        onTapGetStarted(context);
                      }),
              CustomOutlinedButton(
                  height: 48,
                  width :MediaQuery.sizeOf(context).width * 0.4,
                  text: "lbl_sign_in".tr,
                  margin: EdgeInsets.only(left: 5),
                  buttonStyle: CustomButtonStyles.outlinePrimaryTL10,
                  buttonTextStyle: CustomTextStyles.titleMediumPrimarySemiBold,
                  onPressed: () {
                    onTapSignIn(context);
                  })
            ])));
  }


  onTapGetStarted(BuildContext context) {
    locator<NavigationService>().navigateTo(Routes.signUpView);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapSignIn(BuildContext context) {
    locator<NavigationService>().navigateTo(Routes.loginView);

  }
}