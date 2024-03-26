

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/main/main_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/custom_image_view.dart';

class MainView extends StackedView<MainViewModel>{

  @override
  Widget builder(BuildContext context, MainViewModel viewModel, Widget? child) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  SafeArea(
          child: Column(
            children: [
              Expanded(
                child: viewModel.pages[viewModel.currentIndex],
              ),
            ],
          )),
      bottomNavigationBar: SafeArea(child: buildBottomBar(viewModel)),
    );
  }

  @override
  MainViewModel viewModelBuilder(BuildContext context) {
     return MainViewModel();
  }

  @override
  void onViewModelReady(MainViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;



  Widget buildBottomBar(MainViewModel viewModel){
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              -5,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: viewModel.currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavHome,
                  height: 32,
                  width: 32,
                  color: appTheme.gray80001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_home".tr ,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.gray80001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavHomePrimary,
                  height: 32,
                  width: 32,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_home".tr ,
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavOrders,
                  height: 32,
                  width: 32,
                  color: appTheme.gray80001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_orders".tr,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.gray80001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavOrdersPrimary,
                  height: 32,
                  width: 32,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_orders".tr ,
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavChats,
                  height: 32,
                  width: 32,
                  color: appTheme.gray80001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_chats".tr,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.gray80001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavChatsPrimary,
                  height: 32,
                  width: 32,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_chats".tr ,
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavFunds,
                  height: 32,
                  width: 32,
                  color: appTheme.gray80001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_funds".tr,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.gray80001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavFundsPrimary,
                  height: 32,
                  width: 32,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_funds".tr ,
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavAccount,
                  height: 32,
                  width: 32,
                  color: appTheme.gray80001,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_account".tr,
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.gray80001,
                    ),
                  ),
                ),
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgNavAccountPrimary,
                  height: 32,
                  width: 32,
                  color: theme.colorScheme.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text(
                    "lbl_account".tr ,
                    style: CustomTextStyles.labelLargePrimary.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          ),
        ],
        onTap: (index) {
          viewModel.setCurrentIndex(index);
        },
      ),
    );

  }
}