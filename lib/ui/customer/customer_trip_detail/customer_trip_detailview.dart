import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/customer_trip_detail_model.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_trip_detail/customer_trip_detail_viewmodel.dart';
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';

class CustomerTripDetailView extends StackedView<CustomerTripDetailViewModel> {
  CustomerTripDetailModel customerTripDetailModel;

  CustomerTripDetailView(this.customerTripDetailModel);

  @override
  void onViewModelReady(CustomerTripDetailViewModel viewModel) {
    viewModel.customerTripDetailModel = customerTripDetailModel;
    getSingleUserById(customerTripDetailModel.created_by?.email ?? "").then((user) async {
      if (user!.id.isNotEmpty) {
        print("Found user: ${user.firstName} ${user.lastName}");
        final room = await FirebaseChatCore.instance.createRoom(user);
        viewModel.room = room;
      } else {
        print("User with ID  not found");
      }
    });
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  @override
  CustomerTripDetailViewModel viewModelBuilder(BuildContext context) {
    return CustomerTripDetailViewModel();
  }

  @override
  void onDispose(CustomerTripDetailViewModel viewModel) {
    super.onDispose(viewModel);
  }

  Widget mainView(BuildContext context, CustomerTripDetailViewModel viewModel) {
    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        print(value);
        // onTapClose(context);
      },
      child: SafeArea(
          child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (pro) {
          return customProgessBar();
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "Trip Detail", onBackClicked: () {
              print("back--");
              onTapClose(context);
            }),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 35),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Traveler Details",
                              style: CustomTextStyles.titleMediumSemiBold)),
                      SizedBox(height: 11),
                      _buildFrameThirtySix(context,
                          departureLabel: "Rating",
                          aprCounterLabel: "4.8",
                          returnLabel: "Level",
                          aprCounterLabel1: "1",
                          spaceLabel: "Commission",
                          weightLabel:
                              "${customerTripDetailModel.commission}%"),
                      SizedBox(height: 21),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Trip Details",
                              style: CustomTextStyles.titleMediumSemiBold)),
                      SizedBox(height: 10),
                      _buildFrameFifteen(context),
                      SizedBox(height: 12),
                      _buildRow(context,
                          departureLabel: "Departure",
                          aprCounterLabel: getDateTime(
                              customerTripDetailModel.start_date ?? ""),
                          returnLabel: "Return",
                          aprCounterLabel1: getDateTime(
                              customerTripDetailModel.end_date ?? "")),
                      SizedBox(
                        height: 10,
                      ),
                      _buildRow(context,
                          departureLabel: "Space",
                          aprCounterLabel:
                              "${customerTripDetailModel.luggage_space}Kg",
                          returnLabel: "Luggage Type",
                          aprCounterLabel1:
                              customerTripDetailModel.luggage_type?.name ?? ""),
                      Spacer(),
                    ])),
            bottomNavigationBar:
                bottomButton("Chat", context, onButtonPress: () {
                  locator<NavigationService>().navigateTo(Routes.chatView,
                      arguments: ChatViewArguments(room: viewModel.room));
                })),
      )),
    );
  }


  Future<types.User?> getSingleUserById(String email) async {
    types.User? record  = null;
    List<types.User> list = await getAllUsers();
    print(list);
    for (types.User user in list) {
      if(user.metadata!["email"] == email){
        record = user;
      }
    }
    return record == null ?  types.User(id: "") : record;
  }

  Future<List<types.User>> getAllUsers() async {
    Stream<List<types.User>> users = await FirebaseChatCore.instance.users();
    final completer = Completer<List<types.User>>();
    users.forEach((foundList){
      completer.complete(foundList.cast<types.User>()); // Cast and complete
    });
    return completer.future;
  }

  String getDateTime(String date) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final formattedDate =
        DateFormat("yyyy/MM/dd hh:mm:ss a").format(dateFormat.parse(date));
    return formattedDate;
  }

  Widget _buildFrameFifteen(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: AppDecoration.fillGray10001
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 83,
                  width: 330,
                  child: Stack(children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                            padding: EdgeInsets.only(top: 9, bottom: 8),
                            decoration: AppDecoration.outlineBlack9001,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 1),
                                  Text("From",
                                      style: theme.textTheme.bodySmall),
                                  SizedBox(height: 6),
                                  Text(
                                      customerTripDetailModel.travelling_from ??
                                          "",
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
              Text("To", style: theme.textTheme.bodySmall),
              SizedBox(height: 6),
              Text(customerTripDetailModel.travelling_to ?? "",
                  style: theme.textTheme.titleMedium),
              SizedBox(height: 4)
            ]));
  }

  Widget _buildFrameThirtySix(
    BuildContext context, {
    required String departureLabel,
    required String aprCounterLabel,
    required String returnLabel,
    required String aprCounterLabel1,
    required String spaceLabel,
    required String weightLabel,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Text(departureLabel,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 5),
                    Text(aprCounterLabel,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
      Expanded(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 6),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder7),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    Text(returnLabel,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 6),
                    Text(aprCounterLabel1,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Text(spaceLabel,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 5),
                    Text(weightLabel,
                        style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ])))
    ]);
  }

  Widget _buildRow(
    BuildContext context, {
    required String departureLabel,
    required String aprCounterLabel,
    required String returnLabel,
    required String aprCounterLabel1,
  }) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 6),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder4),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 5),
                    Text(departureLabel,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 5),
                    Text(aprCounterLabel,
                        style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
      Expanded(
          child: Container(
              margin: EdgeInsets.only(left: 6),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9),
              decoration: AppDecoration.fillGray10001
                  .copyWith(borderRadius: BorderRadiusStyle.roundedBorder7),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 3),
                    Text(returnLabel,
                        style: theme.textTheme.bodySmall!
                            .copyWith(color: appTheme.gray80002)),
                    SizedBox(height: 6),
                    Text(aprCounterLabel1,
                        style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.onSecondaryContainer))
                  ]))),
    ]);
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

  onTapClose(BuildContext context) {
    locator<NavigationService>().back();
  }

  Widget bottomButton(String buttonText, BuildContext context,
      {required Function() onButtonPress}) {
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

  @override
  Widget builder(BuildContext context, CustomerTripDetailViewModel viewModel,
      Widget? child) {
    return mainView(context, viewModel);
  }
}
