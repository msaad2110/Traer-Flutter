

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/appsettings/appsetting_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/appbar_title_button_one.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_image_view.dart';

class AppSettingView extends StackedView<AppSettingViewModel>{


  @override
  Widget builder(BuildContext context, AppSettingViewModel viewModel, Widget? child) {
    return PopScope(
      canPop: true,
      onPopInvoked: (value){

      },
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 9,
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                _buildFrameFortySeven(context),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  AppSettingViewModel viewModelBuilder(BuildContext context) {
   return AppSettingViewModel();
  }

  @override
  void onDispose(AppSettingViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(AppSettingViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 26,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgUserPrimary,
            margin: EdgeInsets.only(left: 20, top: 22, bottom: 23),
            onTap: () {
              onTapClose(context);
            }),
        title: AppbarSubtitleThree(
            text: "msg_personal_account".tr,
            margin: EdgeInsets.only(left: 14)));
  }

  onTapClose(BuildContext context) {
    locator<NavigationService>().back();
  }

  /// Section Widget
  Widget _buildFrameFortySix(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_face_id".tr,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 5),
                Text(
                  "lbl_on".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMdiCaret,
            height: 24,
            width: 24,
            margin: EdgeInsets.symmetric(vertical: 9),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameFortyFive(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_notifications".tr,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 6),
                Text(
                  "lbl_on".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMdiCaret,
            height: 24,
            width: 24,
            margin: EdgeInsets.symmetric(vertical: 9),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameThirtyFour(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "lbl_language".tr,
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 5),
              Text(
                "lbl_english".tr,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMdiCaret,
            height: 24,
            width: 24,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFrameFortySeven(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "msg_remember_login_details".tr,
                  style: theme.textTheme.titleMedium,
                ),
                SizedBox(height: 4),
                Text(
                  "lbl_on".tr,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgMdiCaret,
            height: 24,
            width: 24,
            margin: EdgeInsets.symmetric(vertical: 8),
          ),
        ],
      ),
    );
  }
}