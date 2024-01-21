

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/ui/fund/fund_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/loading_button.dart';

class FundView extends StackedView<FundViewModel>{

  @override
  Widget builder(BuildContext context, FundViewModel viewModel, Widget? child) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          print(value);

        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Add Funds", onBackClicked: () {
            }),
            body: Container(
              child: Center(
                child: CustomOutlinedButton(
                    height: 48,
                    text: "Add Card".tr,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
                    buttonTextStyle: CustomTextStyles
                        .titleMediumOnErrorContainerSemiBold,
                    onPressed: () {
                     locator<NavigationService>().navigateTo(Routes.addCardView);
                    }),
              ),

            ),
          ),
        ),
      ),
    );



  }



  PreferredSizeWidget _buildAppBar(BuildContext context, String title,
      {required Function() onBackClicked}) {
    return CustomAppBar(
        title: AppbarSubtitleThree(
            text: title, margin: EdgeInsets.only(left: 14)));
  }

  @override
  FundViewModel viewModelBuilder(BuildContext context) {
    return FundViewModel();
  }

  @override
  void onViewModelReady(FundViewModel viewModel) {
    // TODO: implement onViewModelReady


    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;




}