import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/account/account_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/personal_account_dialog.dart';

class AccountView extends StackedView<AccountViewModel>{


  @override
  Widget builder(BuildContext context, AccountViewModel viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    _buildFrameFifteen(context,viewModel),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context,
                        linearMessagesImage: ImageConstant.imgLinearSettingsFineTuningSettings,
                        supportText: "lbl_app_settings".tr , onTapFrameTwentyEight: (){
                        locator<NavigationService>().navigateTo(Routes.appSettingView);
                        }),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context,
                        linearMessagesImage: ImageConstant.imgLinearMoneyCard,
                        supportText: "lbl_payment".tr,onTapFrameTwentyEight: (){
                          locator<NavigationService>().navigateTo(Routes.addCardView);
                        }),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context,
                        linearMessagesImage: ImageConstant.imgLinearEssentional,
                        supportText: "lbl_faq".tr),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context,
                        linearMessagesImage: ImageConstant.imgLinearMessages,
                        supportText: "lbl_support".tr),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context, linearMessagesImage: ImageConstant.imgLinearArrows, supportText: "lbl_change_passcode".tr, onTapFrameTwentyEight: () {
                      locator<NavigationService>().navigateTo(Routes.changePasswordView);
                    }),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context, linearMessagesImage: ImageConstant.imgLinearArrows, supportText: "Upload Documents".tr, onTapFrameTwentyEight: () {
                      locator<NavigationService>().navigateTo(Routes.uploadDocumentView);
                    }),
                    SizedBox(height: 10),
                    _buildFrameTwentyEight(context, linearMessagesImage: ImageConstant.imgLinearArrows, supportText: "lbl_log_out".tr, onTapFrameTwentyEight: () {
                      onTapFrameThirty(context);
                    }),
                    SizedBox(height: 5),

                  ]),
                )
            )
        )
    );
  }

  @override
  AccountViewModel viewModelBuilder(BuildContext context) {
    return AccountViewModel();
  }

  @override
  void onViewModelReady(AccountViewModel viewModel) {
    viewModel.getUserData();
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 26,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgUserPrimary,
            margin: EdgeInsets.only(left: 20, top: 22, bottom: 23),
            onTap: () {
              //onTapClose(context);
            }),
        title: AppbarSubtitleThree(
            text: "msg_personal_account".tr,
            margin: EdgeInsets.only(left: 14)));
  }

  Widget _buildFrameFifteen(BuildContext context , AccountViewModel viewModel) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Column(children: [
                    CustomImageView(
                        imagePath: ImageConstant.imgUnsplash3jmfencl24m,
                        height: 77,
                        width: 77,
                        radius: BorderRadius.circular(38)),
                    SizedBox(height: 11),
                    Align(
                        alignment: Alignment.center,
                        child: Text((viewModel.loginResponse?.data?.user?.first_name ?? "") + " " +(viewModel.loginResponse?.data?.user!.last_name ?? ""),
                            style: theme.textTheme.titleMedium)),
                    SizedBox(height: 3),
                    Align(
                      alignment: Alignment.center,
                      child: Text(viewModel.loginResponse?.data?.user?.phone ?? "",
                          style: CustomTextStyles.bodyMediumBlack900_1),
                    )
                  ])),
              Padding(
                  padding: EdgeInsets.only(left: 79, bottom: 99),
                  child: CustomIconButton(
                      height: 32,
                      width: 32,
                      padding: EdgeInsets.all(6),
                      decoration: IconButtonStyleHelper.fillBlack,
                      onTap: () {
                        onTapBtnEdit();
                      },
                      child: CustomImageView(imagePath: ImageConstant.imgEdit)))
            ]));
  }

  onTapBtnEdit() {
   locator<NavigationService>().navigateTo(Routes.editProfileView);
  }
  Widget _buildFrameTwentyEight(
      BuildContext context, {
        required String linearMessagesImage,
        required String supportText,
        Function? onTapFrameTwentyEight,
      }) {
    return GestureDetector(
        onTap: () {
          onTapFrameTwentyEight!.call();
        },
        child: Container(
            padding: EdgeInsets.all(14),
            decoration: AppDecoration.outlineBlack9002
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomImageView(
                  imagePath: linearMessagesImage,
                  height: 24,
                  width: 24),
              Padding(
                  padding: EdgeInsets.only(left: 10, top: 3),
                  child: Text(supportText,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer))),
              Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgFrame1000001861Primary,
                  height: 24,
                  width: 24)
            ])));
  }


  /// Displays a dialog with the [PersonalAccountDialog] content.
  onTapFrameThirty(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: PersonalAccountDialog.builder(context),
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.only(left: 0),
        ));
  }
}