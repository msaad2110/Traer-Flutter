


import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/all_luggagetype.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/neworder/new_order_form_viewmodel.dart';
import 'package:traer/ui/neworder/new_order_trips_viewmodel.dart';
import 'package:traer/ui/neworder/neworder_viewmodel.dart';
import 'package:traer/ui/order_history/order_history_view.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:traer/widgets/custom_text_form_field.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class NewOrderView extends StackedView<NewOrderViewModel> {


  @override
  Widget builder(BuildContext context, NewOrderViewModel viewModel,
      Widget? child) {
    return mainView(context, viewModel);
  }

  @override
  NewOrderViewModel viewModelBuilder(BuildContext context) {
    return NewOrderViewModel();
  }

  @override
  void onViewModelReady(NewOrderViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;


  Widget mainView(BuildContext context, NewOrderViewModel viewModel) {
    return PageView.builder(
      controller: viewModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2, // Number of screens
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return NewOrderTripsView(viewModel);
          case 1:
            return NewOrderFormView(viewModel);
          default:
            return NewOrderTripsView(viewModel); // Handle unexpected indices
        }
      },
    );
  }

}

class NewOrderTripsView extends StackedView<NewOrderTripsViewModel>{
    NewOrderViewModel parentViewModel;


    NewOrderTripsView(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewOrderTripsViewModel viewModel, Widget? child) {
    return tripSelectionScreen(context, viewModel);
  }

  @override
  NewOrderTripsViewModel viewModelBuilder(BuildContext context) {
   return NewOrderTripsViewModel();
  }

  @override
  void onViewModelReady(NewOrderTripsViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(NewOrderTripsViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;


    Widget tripSelectionScreen(BuildContext context , NewOrderTripsViewModel viewModel) {

    return  PopScope(
      canPop: true,
      onPopInvoked: (value){
        print(value);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Trips", onBackClicked: (){
              print("object");
             onTapClose();
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select trip to continue....",
                        duration: Duration(milliseconds: 50),
                        builder: (context , value){
                          return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.onSecondaryContainer));
                        }),
                  ),
                ),
                SizedBox(height: 7),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: CustomSearchView(
                      controller: viewModel.tripSearchController,
                      onChanged: (v){
                        filtertripSearchResults(v,viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getAllTrips(viewModel , UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0))

              ],
            ),
          )),
    );

  }

    void filtertripSearchResults(String query , NewOrderTripsViewModel viewModel) {

    List<tripModel.Data> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.allTrips;
    }else{
      for(tripModel.Data trip in viewModel.allTrips){
        if(trip.travelling_to!.toLowerCase().contains(query.toLowerCase()) || trip.travelling_from!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(trip);
        }
      }
    }

    viewModel.settrips(searchList);


  }

    onTapClose() {
      locator<NavigationService>().back();
    }


    FutureBuilder<tripModel.TripHistoryModel> getAllTrips(NewOrderTripsViewModel viewModel , int userID){
      return FutureBuilder(
          future: viewModel.getAllTrips(userID),
          builder: (context , snapshot){
            if (snapshot.hasData) {
              print("destination countries call");
              viewModel.foundTrips.value = (snapshot.data!.data ?? []);
              viewModel.allTrips = (snapshot.data!.data! ?? []);
              //return buildCountryListView(viewModel, context, viewModel.foundCountries);
              return ValueListenableBuilder<List<tripModel.Data>>(
                  valueListenable: viewModel.foundTrips,
                  builder: (context , snapshot,_){
                    return snapshot.isEmpty ? Container() : buildTripsListView(viewModel, context, viewModel.foundTrips.value);
                  }
              );
              return Text("data");
            }else if(snapshot.hasError){
              return(Text(snapshot.error.toString()));
            } else {
              return showShimmer(context);

            }
          });
    }

    Widget buildTripsListView(NewOrderTripsViewModel viewModel , BuildContext context , List<tripModel.Data> data){
      print(data.length);
      return data.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
            return triplistItem(viewModel, data[index] , context);
          }
      ) :   const Text(
          'No results found',
          style: TextStyle(fontSize: 24));
    }

    Widget triplistItem(NewOrderTripsViewModel ViewModel , tripModel.Data dataSource , BuildContext context){

      return InkWell(

        onTap: () {
          print( dataSource.travelling_from);
          parentViewModel.tripData = dataSource;
          parentViewModel.setCurrentIndex(1);
        },

        child: Container(
            margin: EdgeInsets.symmetric(vertical: 5 , horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
            decoration: AppDecoration.fillGray10001
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomIconButton(
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(8),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgThumbsUpOnprimarycontainer)),
              Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(("${dataSource.travelling_from} -  ${dataSource.travelling_to}"),
                            style: theme.textTheme.titleMedium!.copyWith(
                                color: theme.colorScheme.onSecondaryContainer)),
                        SizedBox(height: 6),
                        Text(("${formatDate(dataSource.start_date ?? "")} -  ${formatDate(dataSource.end_date ?? "")}"),
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: appTheme.gray80002))
                      ])),
              Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightBlack900,
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.symmetric(vertical: 9))
            ])),
      );

    }

    String formatDate(String dateStr) {
      final dateFormat = DateFormat("yyyy-MM-dd");
      final formattedDate = DateFormat("dd MMM, yyyy").format(dateFormat.parse(dateStr));
      return formattedDate;
    }

    Widget showShimmer(BuildContext context) {
      return Shimmer.fromColors(
          baseColor: appTheme.gray10001,
          highlightColor: appTheme.whiteA700,
          enabled: true,
          child:  SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: skeletonBuildListView(context),
          ));
    }

    Widget skeletonListItem(BuildContext context){

      return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 11),
          decoration: AppDecoration.fillGray10001
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomIconButton(
                height: 42,
                width: 42,
                padding: EdgeInsets.all(8),
                child: CustomImageView(
                    color: appTheme.whiteA700,
                    imagePath: ImageConstant.imgThumbsUpOnprimarycontainer)),
            Padding(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text("",
                          style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.onSecondaryContainer)),
                      SizedBox(height: 6),
                      Text("",
                          style: theme.textTheme.bodySmall!
                              .copyWith(color: appTheme.gray80002))
                    ])),
            Spacer(),
            CustomImageView(
                imagePath: ImageConstant.imgArrowRightBlack900,
                height: 24,
                width: 24,
                color: appTheme.whiteA700,
                margin: EdgeInsets.symmetric(vertical: 9))
          ]));

    }

    Widget skeletonBuildListView(BuildContext context){

      return ListView.builder(
          shrinkWrap: true,
          itemCount: 10,
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
            return skeletonListItem(context);
          }
      );
    }

    PreferredSizeWidget _buildAppBar(BuildContext context ,String title, {required Function() onBackClicked} ) {
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

}


class NewOrderFormView extends StackedView<NewOrderFormViewModel>{

  NewOrderViewModel parentViewModel;


  NewOrderFormView(this.parentViewModel);


  @override
  Widget builder(BuildContext context, NewOrderFormViewModel viewModel, Widget? child) {
    return createNewOrder(context, viewModel);
  }

  @override
  NewOrderFormViewModel viewModelBuilder(BuildContext context) {
    // TODO: implement viewModelBuilder
    return NewOrderFormViewModel();
  }

  @override
  void onViewModelReady(NewOrderFormViewModel viewModel) {
    // TODO: implement onViewModelReady
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLuggageTypes(StackedService.navigatorKey!.currentContext!, viewModel); // Call API after first build
    });

    super.onViewModelReady(viewModel);
  }


  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

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

  Widget createNewOrder(BuildContext context, NewOrderFormViewModel viewModel) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          print(value);
          parentViewModel.setCurrentIndex(0);
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context, "New Order", onBackClicked: () {
              parentViewModel.setCurrentIndex(0);
            }),
            body: Form(
              child: Builder(
                builder: (context) {
                  viewModel.formContext = context;
                  return SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: 7),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("lbl_product_space".tr,
                                style: CustomTextStyles.titleMediumSemiBold),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 13),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: AppDecoration.fillGray10001.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder12),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 9, top: 6, bottom: 6),
                                      child: CustomFloatingTextField(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.4,
                                          controller:
                                              viewModel.productSpaceController,
                                          hintText: "please enter space",
                                          hintStyle: CustomTextStyles
                                              .bodyMediumBluegray4000115,
                                          textInputType: TextInputType.number,
                                          focusNode: viewModel.focusNodeProductSpace,
                                          textInputFormater: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r"^\d*\.?\d*$"))
                                          ],
                                          borderDecoration:
                                              FloatingTextFormFieldStyleHelper
                                                  .custom,
                                          contentPadding: EdgeInsets.only(top: 5),
                                          validator:
                                              viewModel.validateProductSpace)),
                                  Expanded(
                                      child: _buildKilogramsButton(
                                          context, viewModel))
                                ])),
                        SizedBox(height: 7),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("lbl_type_of_product".tr,
                                style: CustomTextStyles.titleMediumSemiBold),
                          ),
                        ),
                        Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 13),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: AppDecoration.fillGray10001.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder12),
                            child:  ValueListenableBuilder<List<luggageModel.Data>?>(
                               valueListenable: viewModel.luggageDataList,
                              builder: (context , snapshot ,_){
                                 return snapshot!.isNotEmpty ? _buildPackageTypeButton(context, viewModel) : Container();
                              },
                        )
                  ),
                        SizedBox(height: 7),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 14),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("msg_estimated_value".tr,
                                style: CustomTextStyles.titleMediumSemiBold),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 13),
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: AppDecoration.fillGray10001.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder12),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 9, top: 6, bottom: 6),
                                      child: CustomFloatingTextField(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.5,
                                          controller:
                                              viewModel.productValueController,
                                          hintText: "please enter value",
                                          focusNode: viewModel.focusNodeProductValue,
                                          textInputFormater: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r"^\d*\.?\d*$"))
                                          ],
                                          hintStyle: CustomTextStyles
                                              .bodyMediumBluegray4000115,
                                          textInputType: TextInputType.number,
                                          borderDecoration:
                                              FloatingTextFormFieldStyleHelper
                                                  .custom,
                                          contentPadding: EdgeInsets.only(top: 5),
                                          validator:
                                              viewModel.validateProductValue)),
                                  SizedBox(
                                      width: 100,
                                      child: _buildProductValueButton(
                                          context, viewModel))
                                ])),
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("lbl_description".tr,
                                style: CustomTextStyles.titleMediumSemiBold),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 13),
                            margin:
                                EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                            child: _buildDescriptionTextEditText(
                                context, viewModel)),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: ValueListenableBuilder(
                              valueListenable: viewModel.isInsured,
                              builder: (cont, snapshot, _) {
                                return CheckboxListTile(
                                  visualDensity:
                                      VisualDensity(horizontal: -3, vertical: -4),
                                  checkColor: ColorsField.whiteColor,
                                  activeColor: theme.colorScheme.primary,
                                  title: Text(
                                      "The Product needs to be insured".tr,
                                      style:
                                          CustomTextStyles.titleSmallBlack900_1),
                                  value: snapshot,
                                  onChanged: (newValue) {
                                    viewModel.updateInsured(newValue ?? false);
                                  },
                                  controlAffinity: ListTileControlAffinity
                                      .leading, //  <-- leading Checkbox
                                );
                              },
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                                "The product will be insured for 2% of the product value"
                                    .tr,
                                style: CustomTextStyles.bodySmallGray600),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            bottomNavigationBar:
                bottomButton("Continue", context, onButtonPress: () {

              if (viewModel.validateForm(viewModel.formContext)) {
                print(viewModel.productSpaceController.text);
                print(viewModel.productValueController.text);
                print(viewModel.descriptionTextEditTextController.text);
                print(viewModel.luggageData.value == null
                    ? viewModel.luggageDataList.value?.first.name
                    : viewModel.luggageData.value?.name);

                onTapnewOrder(context, viewModel);
              }
            }),
          ),
        ),
      ),
    );
  }

  onTapnewOrder(BuildContext context , NewOrderFormViewModel viewModel) {
    CustomLoader.showLoader(context);
    //  viewModel.login("shaheerzaeem26@gmail.com", "test_password").then((value){
    viewModel.newOrder(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0 ,
        viewModel.luggageData.value == null
            ? viewModel.luggageDataList.value?.first.id ?? 0
            : viewModel.luggageData.value?.id  ?? 0 ,
        parentViewModel.tripData.id ?? 0 ,
        viewModel.descriptionTextEditTextController.text  ?? "" ,
        int.parse(viewModel.productSpaceController.text),
        int.parse(viewModel.productValueController.text)
    ).then((value){
      CustomLoader.hideLoader(context);

      if(value.success ?? false){
        CustomDialog.showSuccessDialog(context , message : value.data ?? "" , onPressedDialog: (){
          Navigator.pop(context);
          onTapClose(context);
        });
      }else{
        CustomDialog.showErrorDialog(context,message: value.message ?? "", onPressedDialog: (){
          Navigator.pop(context);
        });
      }
      print(value.toJson());
    }).catchError((onError){
      CustomLoader.hideLoader(context);
      CustomDialog.showErrorDialog(context, onPressedDialog: (){
        Navigator.pop(context);
      });
      print(onError.toString());
    });
    // locator<NavigationService>().navigateTo(Routes.splashView);
  }

  onTapClose(BuildContext context) {
    locator<NavigationService>().clearStackAndShow(Routes.mainView);
  }

  Widget _buildDescriptionTextEditText(BuildContext context, NewOrderFormViewModel viewModel) {
    return CustomTextFormField(
        controller: viewModel.descriptionTextEditTextController,
        hintText: "msg_tell_us_about_what".tr,
        hintStyle: CustomTextStyles.titleMediumGray80002,
        textInputAction: TextInputAction.done,
        textStyle: CustomTextStyles.bodyLargeBlack900,
        maxLines: 6,
        focusNode: viewModel.focusNodeProductDescription,
        validator: viewModel.validateProductDestription,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        borderDecoration: TextFormFieldStyleHelper.fillGray);
  }

  Widget _buildProductValueButton(BuildContext context, NewOrderFormViewModel viewModel) {
    return ValueListenableBuilder<String?>(
      valueListenable: viewModel.productValueSelectedValue,
      builder: (con, snapshot, _) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: theme.cardColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                viewModel.currencyList[0],
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: viewModel.currencyList
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: snapshot,
              onChanged: (String? value) {
                print(value);
                viewModel.setProductValue(value!);
                /*setState(() {
                selectedValue = value;
              });*/
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
            ),
          ),
        );
      },
    );
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

  Widget _buildKilogramsButton(BuildContext context, NewOrderFormViewModel viewModel) {
    return ValueListenableBuilder<String?>(
      valueListenable: viewModel.selectedValue,
      builder: (cont, snapshot, _) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: theme.cardColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                viewModel.unitList[0],
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: viewModel.unitList
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ))
                  .toList(),
              value: snapshot,
              onChanged: (String? value) {
                print(value);
                viewModel.setUnitValue(value!);
                /*setState(() {
                selectedValue = value;
              });*/
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: 140,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPackageTypeButton(BuildContext context, NewOrderFormViewModel viewModel) {
    return ValueListenableBuilder<luggageModel.Data?>(
        valueListenable: viewModel.luggageData,
        builder: (context, snapshot, _) {
          // print(snapshot?.name ?? "pooo");
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: theme.cardColor),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<luggageModel.Data>(
                isExpanded: true,
                hint: Text(
                  viewModel.luggageDataList.value?.first.name ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: viewModel.luggageDataList.value!.map((luggageModel.Data item) =>
                        DropdownMenuItem<luggageModel.Data>(
                          value: item,
                          child: Text(
                            item.name ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: viewModel.luggageData.value,
                onChanged: (luggageModel.Data? value) {
                  // print(value!.name ?? "");
                  viewModel.setPackageType(value);
                  /*setState(() {
              selectedValue = value;
            });*/
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 140,
                ),
              ),
            ),
          );
        });
  }

  fetchLuggageTypes(BuildContext context, NewOrderFormViewModel viewModel) {
    CustomLoader.showLoader(context);
    viewModel.getLuggageTypes().then((value) {
      CustomLoader.hideLoader(context);
      print(value.toString());
      if (value.success ?? false) {
        viewModel.luggageDataList.value = value.data ?? [];
      } else {
        CustomDialog.showErrorDialog(context,message: value.message ?? "", onPressedDialog: (){
          Navigator.pop(context);
          parentViewModel.setCurrentIndex(0);
        });
      }
      print("value");
    }).catchError((onError) {
      print(onError.toString());
       CustomLoader.hideLoader(context);
      CustomDialog.showErrorDialog(context, onPressedDialog: (){
        Navigator.pop(context);
        parentViewModel.setCurrentIndex(0);
      });
      print(onError.toString());
    });
    // locator<NavigationService>().navigateTo(Routes.splashView);
  }
}

