


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stacked/stacked.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_track_order/customer_track_order_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';

class CustomerTrackOrderView extends StackedView<CustomerTrackOrderViewModel>{

  @override
  Widget builder(BuildContext context, CustomerTrackOrderViewModel viewModel, Widget? child) {
    return SafeArea(
        child: Scaffold(
            body: Column(
              children: [
                Container(
                    width: double.maxFinite,
                    decoration: AppDecoration.fillWhiteA,
                    child: SizedBox(
                        height: 350,
                        width: double.maxFinite,
                        child: Stack(alignment: Alignment.bottomCenter,
                            children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 27),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage(ImageConstant.imgGroup9),
                                          fit: BoxFit.cover)),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        _buildUserStack(context),
                                        SizedBox(height: 30),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                                padding:
                                                EdgeInsets.only(left: 15),
                                                child: Text("Estimated Time",
                                                    style: CustomTextStyles
                                                        .bodyMediumGray70001))),
                                        SizedBox(height: 10),
                                        _buildFrameNinetySixRow(context),
                                        SizedBox(height: 10)
                                      ]))),

                        ]
                        )
                    )
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisSize: MainAxisSize.max,
                      children: [
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                        _buildFrameNinetyFourColumn(context),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ));
  }

  Widget _buildFrameNinetyFourColumn(BuildContext context) {
    return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          decoration: AppDecoration.outlineBlack9005.copyWith(
            borderRadius: BorderRadiusStyle.circleBorder12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgMdiTransitCon,
                height: 20,
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Taken Off",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  "Sep 23",
                  style: CustomTextStyles.bodyMediumGray900,
                ),
              ),
              Container(
                height: 3,
                width: 3,
                margin: EdgeInsets.only(
                  left: 6,
                  top: 8,
                  bottom: 8,
                ),
                decoration: BoxDecoration(
                  color: appTheme.gray900,
                  borderRadius: BorderRadius.circular(
                    1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  "09:32 AM",
                  style: CustomTextStyles.bodyMediumGray900,
                ),
              ),
            ],
          ),
        );
           /*    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 20);
                        },
                        itemCount: provider.customerTrackOrderModelObj.userprofile4ItemList.length,
                        itemBuilder: (context, index) {
                          Userprofile4ItemModel model = provider
                              .customerTrackOrderModelObj
                              .userprofile4ItemList[index];
                          return Userprofile4ItemWidget(model);
                        })*/


  }




  Widget _buildFrameNinetySixRow(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child:
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "lbl_06_30".tr,
                    style:
                    CustomTextStyles.titleLargeOnSecondaryContainerMedium),
                TextSpan(text: " "),
                TextSpan(
                    text: "lbl_pm".tr,
                    style: CustomTextStyles.titleSmallGray70001)
              ]),
              textAlign: TextAlign.left),
          Padding(
              padding: EdgeInsets.only(top: 2),
              child: Text("msg_thu_sep_23_2022".tr,
                  style: CustomTextStyles.titleSmallOnSecondaryContainer))
        ]));
  }


  Widget _buildUserStack(BuildContext context) {
    return SizedBox(
        height: 192,
        width: 350,
        child: Stack(alignment: Alignment.topRight, children: [
          CustomIconButton(
              height: 40,
              width: 40,
              padding: EdgeInsets.all(10),
              decoration: IconButtonStyleHelper.outlineGrayTL21,
              alignment: Alignment.topLeft,
              onTap: () {
               // onTapBtnUser(context);
              },
              child: CustomImageView(imagePath: ImageConstant.imgUserPrimary)),
          /*CustomIconButton(
              height: 36,
              width: 36,
              padding: EdgeInsets.all(8),
              decoration: IconButtonStyleHelper.outlineBlack,
              alignment: Alignment.topRight,
              child: CustomImageView(imagePath: ImageConstant.imgFavorite)),*/
          Align(
              alignment: Alignment.topLeft,
              child: Container(
                  height: 18,
                  width: 18,
                  margin: EdgeInsets.only(left: 10, top: 58),
                  decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                          color: theme.colorScheme.primary, width: 2)))),
          Align(
              alignment: Alignment.bottomRight,
              child: Container(
                  height: 18,
                  width: 18,
                  margin: EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(9)))),
          CustomImageView(
              imagePath: ImageConstant.imgLine2,
              height: 147,
              width: 154,
              alignment: Alignment.bottomLeft,
              margin: EdgeInsets.only(left: 27, bottom: 15)),
          CustomImageView(
              imagePath: ImageConstant.imgLine3,
              height: 147,
              width: 158,
              alignment: Alignment.bottomRight,
              margin: EdgeInsets.only(right: 10, bottom: 15)),
          CustomImageView(
              imagePath: ImageConstant.imgMdiAirplane,
              height: 40,
              width: 40,
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 61))
        ]));
  }


  @override
  CustomerTrackOrderViewModel viewModelBuilder(BuildContext context) {
   return CustomerTrackOrderViewModel();
  }

  @override
  void onViewModelReady(CustomerTrackOrderViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  @override
  void onDispose(CustomerTrackOrderViewModel viewModel) {
    super.onDispose(viewModel);
  }
}