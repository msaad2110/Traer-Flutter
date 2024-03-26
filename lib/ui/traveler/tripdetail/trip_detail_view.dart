import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/edittripdata.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/tripdetail/trip_detail_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/appbar_title_button_two.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;

class TripDetailView extends StackedView<TripDetailViewModel>{

   tripModel.Data dataSource;


  TripDetailView(this.dataSource);

  @override
  Widget builder(BuildContext context, TripDetailViewModel viewModel, Widget? child) {


    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context, "Trip Detail", onBackClicked: () {

            }),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 11),
                child: Column(children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("lbl_trip_details".tr,
                          style: CustomTextStyles.titleMediumSemiBold)),
                  SizedBox(height: 10),
                  _buildTripDetailsColumn(context,viewModel),
                  SizedBox(height: 12),
                  _buildDateDetailsRow(context,
                      dynamicText1: "lbl_departure".tr,
                      dynamicText2: DateFormat('MMM dd').format(DateFormat('yyyy-MM-dd').parse(viewModel.dataSource.start_date ?? "")),
                      dynamicText3: "lbl_return".tr,
                      dynamicText4: DateFormat('MMM dd').format(DateFormat('yyyy-MM-dd').parse(viewModel.dataSource.end_date ?? "")),
                      dynamicText5: "lbl_packages".tr,
                      dynamicText6: "lbl_1".tr),
                  SizedBox(height: 50),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("lbl_product_details".tr,
                          style: CustomTextStyles.titleMediumSemiBold)),
                  SizedBox(height: 11),
                  _buildProductDetailsRow(context,
                      dynamicText1: "Space".tr,
                      dynamicText2: (viewModel.dataSource.luggage_space  ?? "") + "KG",
                      dynamicText3: "lbl_commission".tr,
                      dynamicText4: (viewModel.dataSource.commission ?? 0).toString() + "%"),
                  SizedBox(height: 5)
                ])),
            bottomNavigationBar: bottomButton("Edit Trip", context, onButtonPress: () {
              mapEditTripModel();
           locator<NavigationService>().navigateTo(Routes.editTripView);

            })));

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

  /// Section Widget
  Widget _buildTripDetailsColumn(BuildContext context , TripDetailViewModel viewModel) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 83,
                  width: MediaQuery.sizeOf(context).width,
                  child: Stack(alignment: Alignment.bottomRight, children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                            padding: EdgeInsets.only(top: 9, bottom: 8),
                            decoration: AppDecoration.outlineBlack9001,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 1),
                                  Text("lbl_from".tr,
                                      style: theme.textTheme.bodySmall),
                                  SizedBox(height: 6),
                                  Text(viewModel.dataSource.travelling_from ?? "",
                                      style: theme.textTheme.titleMedium)
                                ]))),
                    Padding(
                        padding: EdgeInsets.only(right: 36),
                        child: CustomIconButton(
                            height: 42,
                            width: 42,
                            padding: EdgeInsets.all(8),
                            decoration: IconButtonStyleHelper.outlineGrayTL21,
                            alignment: Alignment.bottomRight,
                            child: CustomImageView(
                                imagePath: ImageConstant.imgAirplane)))
                  ])),
              Text("lbl_to".tr, style: theme.textTheme.bodySmall),
              SizedBox(height: 6),
              Text(viewModel.dataSource.travelling_to ?? "",
                  style: theme.textTheme.titleMedium),
              SizedBox(height: 4)
            ]));
  }


  /// Common widget
  Widget _buildDateDetailsRow(
      BuildContext context, {
        required String dynamicText1,
        required String dynamicText2,
        required String dynamicText3,
        required String dynamicText4,
        required String dynamicText5,
        required String dynamicText6,
      }) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2),
                    Text(dynamicText1,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 4),
                    Text(dynamicText2,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
      Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 2),
                    Text(dynamicText3,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 5),
                    Text(dynamicText4,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    Text(dynamicText5,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 3),
                    Text(dynamicText6,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ])))
    ]);
  }


   Widget _buildProductDetailsRow(
       BuildContext context, {
         required String dynamicText1,
         required String dynamicText2,
         required String dynamicText3,
         required String dynamicText4,
       }) {
     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
       Expanded(
           child: Container(
               margin: EdgeInsets.only(right: 6),
               padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
               decoration: AppDecoration.fillGray10001
                   .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
               child: Column(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(height: 2),
                     Text(dynamicText1,
                         style: theme.textTheme.bodySmall!
                             .copyWith(color: appTheme.gray80002)),
                     SizedBox(height: 4),
                     Text(dynamicText2,
                         style: theme.textTheme.titleMedium!.copyWith(
                             color: theme.colorScheme.onSecondaryContainer))
                   ]))),
       Expanded(
           child: Container(
               margin: EdgeInsets.only(left: 6),
               padding: EdgeInsets.only(left: 21, top: 10,bottom: 10),
               decoration: AppDecoration.fillGray10001
                   .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
               child: Column(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(height: 2),
                     Text(dynamicText3,
                         style: theme.textTheme.bodySmall!
                             .copyWith(color: appTheme.gray80002)),
                     SizedBox(height: 5),
                     Text(dynamicText4,
                         style: theme.textTheme.titleMedium!.copyWith(
                             color: theme.colorScheme.onSecondaryContainer))
                   ]))),

     ]);
   }


   @override
  TripDetailViewModel viewModelBuilder(BuildContext context) {
     return TripDetailViewModel();
  }

  @override
  void onViewModelReady(TripDetailViewModel viewModel) {
    viewModel.dataSource = dataSource;
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(TripDetailViewModel viewModel) {
    super.onDispose(viewModel);
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
  @override
  bool get reactive => super.reactive;



  mapEditTripModel(){
    EditTripData.getInstance().id = dataSource.id;
    EditTripData.getInstance().destinationCity = Cities(city_name: dataSource.travelling_to);
    EditTripData.getInstance().originCity = Cities(city_name: dataSource.travelling_from);
    EditTripData.getInstance().startDate = DateFormat('yyyy-MM-dd').parse(dataSource.start_date ?? "");
    EditTripData.getInstance().endDateDate = DateFormat('yyyy-MM-dd').parse(dataSource.end_date ?? "");
    EditTripData.getInstance().luggageType = dataSource.luggage_type;
    EditTripData.getInstance().luggageSpace = dataSource.luggage_space;
    EditTripData.getInstance().commission = dataSource.commission.toString();
  }

}