

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/edittripdata.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/models/trip_history_model.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/edittrip/edit_trip_form_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edit_trip_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_datepicker_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_destination_city_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_destination_country_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_destination_state_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_origin_city_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_origin_country_viewmodel.dart';
import 'package:traer/ui/traveler/edittrip/edittrip_origin_state_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class EditTripView extends StackedView<EditTripViewModel>{

  @override
  Widget builder(BuildContext context, EditTripViewModel viewModel, Widget? child) {
    return mainView(context, viewModel);
  }

  @override
  EditTripViewModel viewModelBuilder(BuildContext context) {
    return EditTripViewModel();
  }

  @override
  void onDispose(EditTripViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

  @override
  void onViewModelReady(EditTripViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  Widget mainView(BuildContext context , EditTripViewModel viewModel){
    return PageView.builder(
      controller: viewModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9, // Number of screens
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return postEditTripScreen(context, viewModel);
          case 1:
            return EditTripDestinationCountryScreen(viewModel);
          case 2:
            return EditTripDestinationStateScreen(viewModel);
          case 3:
            return EditTripDestinationCityScreen(viewModel);
          case 4:
            return EditTripOriginCountryScreen(viewModel);
          case 5:
            return EditTripOriginStateScreen( viewModel);
          case 6:
            return EditTripOriginCityScreen(viewModel);
          case 7:
            return EditTripDateTimePickerScreen(viewModel);
           // return EditTripDatePickerScreen(viewModel);
          case 8:
            return EditTripFormScreen(viewModel);
        // ... cases for other screens
          default:
            return Container(); // Handle unexpected indices
        }
      },
    );
  }



  Widget postEditTripScreen(BuildContext context , EditTripViewModel viewModel){
    return  PopScope(
      canPop: true,
      onPopInvoked: (value){
        print(value);
        // onTapClose(context);
      },
      child: SafeArea(
          child: LoaderOverlay(
            useDefaultLoading: false,
            overlayWidgetBuilder: (pro){
              return customProgessBar();
            },
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: _buildAppBar(context ,"Edit Trip", onBackClicked: (){
                  print("back--");
                  onTapClose(context);
                }),
                body: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(children: [
                      _buildCustomRow(context,
                          title: "lbl_traveling_to".tr,
                          value: (EditTripData.getInstance().destinationCity == null) ? "" : (EditTripData.getInstance().destinationCity?.city_name ?? ""),onTap: (){
                            print("object");
                            viewModel.setCurrentIndex(1);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_traveling_from".tr,
                          value: (EditTripData.getInstance().originCity == null) ? "" : (EditTripData.getInstance().originCity?.city_name ?? "")  ,onTap: (){
                            viewModel.setCurrentIndex(4);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_traveling_date".tr,
                          value: EditTripData.getInstance().startDate == null ? "" : (DateFormat('MMM dd').format(EditTripData.getInstance().startDate ?? DateTime.now()) + " - " +
                              DateFormat('MMM dd').format(EditTripData.getInstance().endDateDate ?? DateTime.now())),onTap: (){
                            viewModel.setCurrentIndex(7);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_luggage_space".tr,
                          value: EditTripData.getInstance().luggageSpace == null ? "" : (EditTripData.getInstance().luggageSpace!+"KG") ?? "",onTap: (){
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_luggage_type".tr,
                          value: EditTripData.getInstance().luggageType == null ? "" : EditTripData.getInstance().luggageType?.name ?? "",onTap: (){
                            print("object");
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_commission".tr,
                          value: EditTripData.getInstance().commission == null ? "" : EditTripData.getInstance().commission!+"%" ?? "",onTap: (){
                            print("object");
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 5)
                    ])),
                bottomNavigationBar: bottomButton("Update Trip",context,onButtonPress: (){
                  if(viewModel.validateEditTripData().$1){
                    onTapPostTrip(context, viewModel);
                  }else{
                    CustomDialog.showErrorDialog(context,message:viewModel.validateEditTripData().$2, onPressedDialog: (){
                      Navigator.pop(context);
                    });
                  }
                })),
          )),
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

  /// Section Widget
  Widget bottomButton(String buttonText , BuildContext context , {required Function() onButtonPress}) {
    return CustomOutlinedButton(
        height: 48,
        text: buttonText,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles
            .titleMediumOnErrorContainerSemiBold,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 34),
        onPressed: () {
          onButtonPress();
          //  onTapPostTrip(context);
        });


  }

  onTapClose(BuildContext context) {
    locator<NavigationService>().clearStackAndShow(Routes.mainView);
  }

  Widget _buildCustomRow(
      BuildContext context, {
        required String title,
        required String value,
        required Function() onTap,
      }) {
    return GestureDetector(
      onTap:  onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: AppDecoration.outlineBlack9002
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(title,
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onSecondaryContainer))),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(value,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: appTheme.gray70004))),
            CustomImageView(
                imagePath: ImageConstant.imgArrowRightPrimary,
                height: 18,
                width: 7,
                margin: EdgeInsets.only(left: 10, top: 2, bottom: 2))
          ])),
    );
  }


  void backClick(int index , EditTripViewModel viewModel){
    print(index);
    switch (index) {
      case 0:
        locator<NavigationService>().back();
        break;
      case 1:
        viewModel.setCurrentIndex(0);
        break;

      case 2:
        viewModel.setCurrentIndex(1);
        break;

      case 3:
        viewModel.setCurrentIndex(2);
        break;

      case 4:
        viewModel.setCurrentIndex(0);
        break;
      case 5:
        viewModel.setCurrentIndex(4);
        break;

      case 6:
        viewModel.setCurrentIndex(5);
        break;
      case 7:
        viewModel.setCurrentIndex(0);
        break;
      case 8:
        viewModel.setCurrentIndex(0);
        break;
      default:
        viewModel.setCurrentIndex(0);
    }
  }

  onTapPostTrip(BuildContext context , EditTripViewModel viewModel) {
    CustomLoader.showLoader(context);
    //  viewModel.login("shaheerzaeem26@gmail.com", "test_password").then((value){
    viewModel.updateTrip(EditTripData.getInstance().id ?? 0
        ,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0 ,
        EditTripData.getInstance().luggageType?.id  ?? 0 ,
        EditTripData.getInstance().originCity?.city_name  ?? "" ,
        EditTripData.getInstance().destinationCity?.city_name  ?? "" ,
        DateFormat('yyyy-MM-dd').format(EditTripData.getInstance().startDate ?? DateTime.now()),
        DateFormat('yyyy-MM-dd').format(EditTripData.getInstance().endDateDate ?? DateTime.now()),
        int.parse(EditTripData.getInstance().commission ?? "0"),
        int.parse(EditTripData.getInstance().luggageSpace ?? "0")
    ).then((value){
      CustomLoader.hideLoader(context);

      if(value.success ?? false){
        CustomDialog.showSuccessDialog(context , message : value.data ?? "" , onPressedDialog: (){
          Navigator.pop(context);
          onTapClose(context);
          EditTripData.getInstance().clearData();
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

}

class EditTripDestinationCountryScreen extends StackedView<EditTripDestinationCountryViewModel>{
  EditTripViewModel parentViewModel;

  EditTripDestinationCountryScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripDestinationCountryViewModel viewModel, Widget? child) {
    return _destinationCountrySelectionSecreen(context,viewModel);
  }

  @override
  EditTripDestinationCountryViewModel viewModelBuilder(BuildContext context) {
    return EditTripDestinationCountryViewModel();
  }

  @override
  void onViewModelReady(EditTripDestinationCountryViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget _destinationCountrySelectionSecreen(BuildContext context , EditTripDestinationCountryViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select Destination Country", onBackClicked: (){
              print("object");
              parentViewModel.setCurrentIndex(0);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your destination country....",
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
                      autofocus: false,
                      controller: viewModel.destinationCountrySearchController,
                      onChanged: (v){
                        filterDestinationCountrySearchResults(v.trim(),viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getDestinationCountries(viewModel))

              ],
            ),
          )),
    );

  }

  FutureBuilder<CountryResponse> getDestinationCountries(EditTripDestinationCountryViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCountries("countries"),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            viewModel.destinationFoundCountries.value = (snapshot.data!.data!.first.countries ?? []);
            viewModel.destinationAllCountries = (snapshot.data!.data!.first.countries ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Countries>>(
                valueListenable: viewModel.destinationFoundCountries,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationCountryListView(viewModel, context, viewModel.destinationFoundCountries.value);
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

  Widget buildDestinationCountryListView(EditTripDestinationCountryViewModel viewModel , BuildContext context , List<Countries> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return countryDestinationlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget countryDestinationlistItem(EditTripDestinationCountryViewModel homeViewModel , Countries dataSource , BuildContext context){

    return InkWell(

      onTap: () {
        EditTripData.getInstance().destinationCountry = dataSource;
        print( EditTripData.getInstance().destinationCountry);
        parentViewModel.setCurrentIndex(2);
      },

      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.country_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }

  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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

  void filterDestinationCountrySearchResults(String query , EditTripDestinationCountryViewModel viewModel) {

    List<Countries> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.destinationAllCountries;
    }else{
      for(Countries country in viewModel.destinationAllCountries){
        if(country.country_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(country);
        }
      }
    }

    viewModel.setDestinationCountries(searchList);


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

class EditTripOriginCountryScreen extends StackedView<EditTripOriginCountryViewModel>{
  EditTripViewModel parentViewModel;


  EditTripOriginCountryScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripOriginCountryViewModel viewModel, Widget? child) {
    return _originCountrySelectionSecreen(context, viewModel);
  }

  @override
  EditTripOriginCountryViewModel viewModelBuilder(BuildContext context) {
    return EditTripOriginCountryViewModel();
  }

  @override
  void onViewModelReady(EditTripOriginCountryViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originCountrySelectionSecreen(BuildContext context , EditTripOriginCountryViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select Origin Country", onBackClicked: (){
              parentViewModel.setCurrentIndex(0);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your origin country....",
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
                      autofocus: false,
                      controller: viewModel.originCountrySearchController,
                      onChanged: (v){
                        filterOriginCountrySearchResults(v.trim(),viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getOriginCountries(viewModel))

              ],
            ),
          )),
    );

  }
  FutureBuilder<CountryResponse> getOriginCountries(EditTripOriginCountryViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCountries("countries"),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("origin countries call");
            viewModel.originFoundCountries.value = (snapshot.data!.data!.first.countries ?? []);
            viewModel.originAllCountries = (snapshot.data!.data!.first.countries ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Countries>>(
                valueListenable: viewModel.originFoundCountries,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildOriginCountryListView(viewModel, context, viewModel.originFoundCountries.value);
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
  Widget buildOriginCountryListView(EditTripOriginCountryViewModel viewModel , BuildContext context , List<Countries> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return countryOriginlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }
  Widget countryOriginlistItem(EditTripOriginCountryViewModel homeViewModel , Countries dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        EditTripData.getInstance().originCountry = dataSource;
        print( EditTripData.getInstance().originCountry);
        parentViewModel.setCurrentIndex(5);
      },
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.country_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }

  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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

  void filterOriginCountrySearchResults(String query , EditTripOriginCountryViewModel viewModel) {

    List<Countries> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.originAllCountries;
    }else{
      for(Countries country in viewModel.originAllCountries){
        if(country.country_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(country);
        }
      }
    }

    viewModel.setOriginCountries(searchList);


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


class EditTripDestinationStateScreen extends StackedView<EditTripDestinationStateViewModel>{
  EditTripViewModel parentViewModel;


  EditTripDestinationStateScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripDestinationStateViewModel viewModel, Widget? child) {
    return _destinationStateSelectionSecreen(context, viewModel);
  }

  @override
  EditTripDestinationStateViewModel viewModelBuilder(BuildContext context) {
    return EditTripDestinationStateViewModel();
  }


  @override
  void onViewModelReady(EditTripDestinationStateViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationStateSelectionSecreen(BuildContext context , EditTripDestinationStateViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(1);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select Destination State", onBackClicked: (){
              parentViewModel.setCurrentIndex(1);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your destination State....",
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
                      autofocus: false,
                      controller: viewModel.destinationStateSearchController,
                      onChanged: (v){
                        filterDestinationStateSearchResults(v.trim(),viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getDestinationStates(viewModel))

              ],
            ),
          )),
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


  FutureBuilder<StateResponse> getDestinationStates(EditTripDestinationStateViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStates("states",EditTripData.getInstance().destinationCountry?.country_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination state call");
            viewModel.destinationFoundStates.value = (snapshot.data!.data!.first.states ?? []);
            viewModel.destinationAllStates = (snapshot.data!.data!.first.states ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<States>>(
                valueListenable: viewModel.destinationFoundStates,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationStateListView(viewModel, context, viewModel.destinationFoundStates.value);
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


  Widget buildDestinationStateListView(EditTripDestinationStateViewModel viewModel , BuildContext context , List<States> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return stateDestinationlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }


  Widget stateDestinationlistItem(EditTripDestinationStateViewModel homeViewModel , States dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        EditTripData.getInstance().destinationState = dataSource;
        print( EditTripData.getInstance().destinationState);
        parentViewModel.setCurrentIndex(3);
      },
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.state_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }


  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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

  void filterDestinationStateSearchResults(String query , EditTripDestinationStateViewModel viewModel) {

    List<States> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.destinationAllStates;
    }else{
      for(States state in viewModel.destinationAllStates){
        if(state.state_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(state);
        }
      }
    }

    viewModel.setDestinationStates(searchList);

  }

}

class EditTripOriginStateScreen extends StackedView<EditTripOriginStateViewModel>{
  EditTripViewModel parentViewModel;


  EditTripOriginStateScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripOriginStateViewModel viewModel, Widget? child) {
    return _originStateSelectionSecreen(context,viewModel);
  }

  @override
  EditTripOriginStateViewModel viewModelBuilder(BuildContext context) {
    return EditTripOriginStateViewModel();
  }


  @override
  void onViewModelReady(EditTripOriginStateViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originStateSelectionSecreen(BuildContext context , EditTripOriginStateViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(4);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select Origin State", onBackClicked: (){
              parentViewModel.setCurrentIndex(4);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your origin State....",
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
                      autofocus: false,
                      controller: viewModel.originStateSearchController,
                      onChanged: (v){
                        filterOriginStateSearchResults(v.trim(),viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getOriginStates(viewModel))

              ],
            ),
          )),
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

  FutureBuilder<StateResponse> getOriginStates(EditTripOriginStateViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStates("states",EditTripData.getInstance().originCountry?.country_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("origin states call");
            viewModel.originFoundStates.value = (snapshot.data!.data!.first.states ?? []);
            viewModel.originAllStates = (snapshot.data!.data!.first.states ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<States>>(
                valueListenable: viewModel.originFoundStates,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildOriginStateListView(viewModel, context, viewModel.originFoundStates.value);
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


  void filterOriginStateSearchResults(String query , EditTripOriginStateViewModel viewModel) {

    List<States> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.originAllStates;
    }else{
      for(States state in viewModel.originAllStates){
        if(state.state_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(state);
        }
      }
    }

    viewModel.setOriginStates(searchList);

  }

  Widget buildOriginStateListView(EditTripOriginStateViewModel viewModel , BuildContext context , List<States> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return stateOriginlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget stateOriginlistItem(EditTripOriginStateViewModel homeViewModel , States dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        EditTripData.getInstance().originState = dataSource;
        print( EditTripData.getInstance().originState);
        parentViewModel.setCurrentIndex(6);
      },
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.state_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }


  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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
}

class EditTripDestinationCityScreen extends StackedView<EditTripDestinationCityViewModel> {

  EditTripViewModel parentViewModel;

  EditTripDestinationCityScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripDestinationCityViewModel viewModel, Widget? child) {
    return _destinationCitySelectionSecreen(context, viewModel);
  }

  @override
  EditTripDestinationCityViewModel viewModelBuilder(BuildContext context) {
    return EditTripDestinationCityViewModel();
  }

  @override
  void onViewModelReady(EditTripDestinationCityViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationCitySelectionSecreen(BuildContext context , EditTripDestinationCityViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(2);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context,"Select Destination City" , onBackClicked: (){
              parentViewModel.setCurrentIndex(2);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your destination City....",
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
                      autofocus: false,
                      controller: viewModel.destinationCitySearchController,
                      onChanged: (v){
                        filterDestinationCitySearchResults(v.trim(),viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getDestinationCities(viewModel))

              ],
            ),
          )),
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

  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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

  FutureBuilder<CityResponse> getDestinationCities(EditTripDestinationCityViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCities("cities",EditTripData.getInstance().destinationState?.state_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination cities call");
            viewModel.destinationFoundCities.value = (snapshot.data!.data!.first.cities ?? []);
            viewModel.destinationAllCities = (snapshot.data!.data!.first.cities ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Cities>>(
                valueListenable: viewModel.destinationFoundCities,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationCityListView(viewModel, context, viewModel.destinationFoundCities.value);
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


  Widget buildDestinationCityListView(EditTripDestinationCityViewModel viewModel , BuildContext context , List<Cities> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return cityDestinationlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget cityDestinationlistItem(EditTripDestinationCityViewModel homeViewModel , Cities dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        EditTripData.getInstance().destinationCity = dataSource;
        print( EditTripData.getInstance().destinationCity);
        parentViewModel.setCurrentIndex(0);
      },
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.city_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }

  void filterDestinationCitySearchResults(String query , EditTripDestinationCityViewModel viewModel) {

    List<Cities> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.destinationAllCities;
    }else{
      for(Cities city in viewModel.destinationAllCities){
        if(city.city_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(city);
        }
      }
    }

    viewModel.setDestinationCities(searchList);

  }

}

class EditTripOriginCityScreen extends StackedView<EditTripOriginCityViewModel> {

  EditTripViewModel parentViewModel;


  EditTripOriginCityScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripOriginCityViewModel viewModel, Widget? child) {
    return _originCitySelectionSecreen(context,viewModel);
  }

  @override
  EditTripOriginCityViewModel viewModelBuilder(BuildContext context) {
    return EditTripOriginCityViewModel();
  }

  @override
  void onViewModelReady(EditTripOriginCityViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originCitySelectionSecreen(BuildContext context , EditTripOriginCityViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(5);

      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select Origin City", onBackClicked: (){
              parentViewModel.setCurrentIndex(5);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Select your origin City....",
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
                      autofocus: false,
                      controller: viewModel.originCitySearchController,
                      onChanged: (v){
                        filterOriginCitySearchResults(v.trim() ,viewModel);
                      },
                      hintText: "lbl_search".tr,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getOriginCities(viewModel))

              ],
            ),
          )),
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



  FutureBuilder<CityResponse> getOriginCities(EditTripOriginCityViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCities("cities",EditTripData.getInstance().originState?.state_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("origin cities call");
            viewModel.originFoundCities.value = (snapshot.data!.data!.first.cities ?? []);
            viewModel.originAllCities = (snapshot.data!.data!.first.cities ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Cities>>(
                valueListenable: viewModel.originFoundCities,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildOriginCityListView(viewModel, context, viewModel.originFoundCities.value);
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

  Widget buildOriginCityListView(EditTripOriginCityViewModel viewModel , BuildContext context , List<Cities> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return cityOriginlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget cityOriginlistItem(EditTripOriginCityViewModel homeViewModel , Cities dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        EditTripData.getInstance().originCity = dataSource;
        print( EditTripData.getInstance().originCity);
        parentViewModel.setCurrentIndex(0);
      },
      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: appTheme.gray10001,
            ),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              elevation: 0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(dataSource.city_name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer),),
                    ),
                  ),
                  CustomImageView(
                      imagePath: ImageConstant.imgArrowRightPrimary,
                      height: 18,
                      width: 7,
                      margin: EdgeInsets.only(left: 10, top: 2, bottom: 2,right: 5))
                ],
              ),
            ),
          )
        ],
      ),
    );

  }

  void filterOriginCitySearchResults(String query , EditTripOriginCityViewModel viewModel) {

    List<Cities> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.originAllCities;
    }else{
      for(Cities city in viewModel.originAllCities){
        if(city.city_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(city);
        }
      }
    }

    viewModel.setOriginCities(searchList);

  }


  Widget showShimmer(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: appTheme.gray10001,
        highlightColor: ColorsField.whiteColor,
        enabled: true,
        child:  SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: skeletonBuildListView(context),
        ));
  }

  Widget skeletonListItem(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white
            ),
            child: Text(
              "",
              style: CustomTextStyles.titleMediumSemiBold_1,
            ),
          )
        ],
      ),
    );

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
}

class EditTripDatePickerScreen extends StackedView<EditTripDatePickerViewModel> {

  EditTripViewModel parentViewModel;

  EditTripDatePickerScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripDatePickerViewModel viewModel, Widget? child) {
    return datePicker(context, viewModel);
  }

  @override
  EditTripDatePickerViewModel viewModelBuilder(BuildContext context) {
    return EditTripDatePickerViewModel();
  }

  @override
  void onViewModelReady(EditTripDatePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget datePicker(BuildContext context , EditTripDatePickerViewModel viewModel){
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
      },
      child: SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context ,"Select Date", onBackClicked: (){
                parentViewModel.setCurrentIndex(0);
              }),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(children: [
                    SfDateRangePicker(

                      // selectionColor: Colors.grey,
                      onSelectionChanged: (args){
                        print(args.value.startDate);
                        print(viewModel.defaultStartDate);
                        viewModel.defaultStartDate = args.value.startDate;
                        viewModel.defaultEndDate = args.value.endDate;
                        print(DateFormat('dd/MM/yyyy').format(args.value.startDate));
                        print(DateFormat('dd/MM/yyyy').format(args.value.endDate) ?? "hhhhfrt");
                      },
                      selectionMode: DateRangePickerSelectionMode.range,
                      minDate:  DateTime.now(),
                      startRangeSelectionColor: theme.colorScheme.primary,
                      endRangeSelectionColor: theme.colorScheme.primary ,
                      rangeSelectionColor: theme.highlightColor,
                      initialSelectedRange: PickerDateRange(
                        // DateTime.now().subtract(const Duration(days: 4)),
                        viewModel.defaultStartDate,
                        viewModel.defaultEndDate,
                      ),
                    )
                  ])),
              bottomNavigationBar: bottomButton("Continue",context,onButtonPress: (){
                EditTripData.getInstance().startDate = viewModel.defaultStartDate;
                EditTripData.getInstance().endDateDate = viewModel.defaultEndDate;
                parentViewModel.setCurrentIndex(0);
              }))),
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

  Widget bottomButton(String buttonText , BuildContext context , {required Function() onButtonPress}) {
    return CustomOutlinedButton(
        height: 48,
        text: buttonText,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles
            .titleMediumOnErrorContainerSemiBold,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 34),
        onPressed: () {
          onButtonPress();
          //  onTapPostTrip(context);
        });


  }

}

class EditTripDateTimePickerScreen extends StackedView<EditTripDatePickerViewModel>{

  EditTripViewModel parentViewModel;

  EditTripDateTimePickerScreen(this.parentViewModel);



  @override
  Widget builder(BuildContext context, EditTripDatePickerViewModel viewModel, Widget? child) {
    return datePicker(context, viewModel);
  }

  @override
  EditTripDatePickerViewModel viewModelBuilder(BuildContext context) {
    return EditTripDatePickerViewModel();
  }

  @override
  void onViewModelReady(EditTripDatePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget datePicker(BuildContext context , EditTripDatePickerViewModel viewModel){
    return PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
      },
      child: SafeArea(
          child: Scaffold(
              appBar: _buildAppBar(context ,"Select Date", onBackClicked: (){
                parentViewModel.setCurrentIndex(0);
              }),
              body: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(children: [
                    SizedBox(height: 10,),
                    _buildCustomRow(context,
                        title: "Start Date & Time".tr,
                        value: DateFormat('yyyy/MM/dd hh:mm:ss a').format(EditTripData.getInstance().startDate ?? DateTime.now()),
                        onTap: () async{
                          viewModel.updateDate();
                          print(viewModel.defaultStartDate);
                          print(viewModel.defaultEndDate);
                          List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
                            context: context,
                            startInitialDate: viewModel.defaultStartDate,
                            startFirstDate: viewModel.defaultStartDate,
                            startLastDate: viewModel.defaultEndDate,
                            endInitialDate: viewModel.defaultStartDate,
                            endFirstDate: viewModel.defaultStartDate,
                            endLastDate: viewModel.defaultEndDate,
                            is24HourMode: false,
                            isShowSeconds: false,
                            minutesInterval: 1,
                            secondsInterval: 1,
                            isForce2Digits: true,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            constraints: const BoxConstraints(
                              maxWidth: 350,
                              maxHeight: 650,
                            ),
                            theme: ThemeData(
                                useMaterial3: true,
                                colorSchemeSeed: theme.colorScheme.primary
                            ),
                            transitionBuilder: (context, anim1, anim2, child) {
                              return FadeTransition(
                                opacity: anim1.drive(
                                  Tween(
                                    begin: 0,
                                    end: 1,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 200),
                            barrierDismissible: true,

                            selectableDayPredicate: (dateTime) {
                              // Disable 25th Feb 2023
                              print(dateTime);
                              print("dateTime");
                              return true;
                              /*  if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }*/
                            },
                          );

                          if(dateTimeList?[0] != null){
                            if (dateTimeList![0].isBefore(dateTimeList![1])) {
                              EditTripData.getInstance().startDate = dateTimeList?[0];
                              viewModel.defaultStartDate = dateTimeList?[0];
                              print('Start Date: $dateTimeList![0]');
                              print('End Date: $dateTimeList![1]');
                            } else {
                              CustomDialog.showErrorDialog(context,message: "End date cannot be before start date", onPressedDialog: (){
                                Navigator.pop(context);
                              });
                              print('Error: End date cannot be before start date.');
                            }
                          }


                          if(dateTimeList?[1] != null){
                            if (dateTimeList![1].isAfter(dateTimeList![0])) {
                              EditTripData.getInstance().endDateDate = dateTimeList?[1];
                              viewModel.defaultEndDate = dateTimeList?[1];
                              print('Start Date: $dateTimeList![0]');
                              print('End Date: $dateTimeList![1]');
                            } else {
                              // Show an error message or highlight the issue
                              /*CustomDialog.showErrorDialog(context,message: "End date cannot be before start date", onPressedDialog: (){
                                Navigator.pop(context);
                              });*/
                              print('Error: End date cannot be before start date.');
                            }

                          }

                         /* if(dateTimeList?[0] != null){
                            EditTripData.getInstance().startDate = dateTimeList?[0];
                            viewModel.defaultStartDate = dateTimeList?[0];
                          }


                          if(dateTimeList?[1] != null){
                            EditTripData.getInstance().endDateDate = dateTimeList?[1];
                            viewModel.defaultEndDate = dateTimeList?[1];
                          }*/
                          viewModel.notifyListeners();
                          print("Start dateTime: ${dateTimeList?[0]}");
                          print("End dateTime: ${dateTimeList?[1]}");
                        }),
                    SizedBox(height: 10,),
                    _buildCustomRow(context,
                        title: "End Date & Time".tr,
                        value:DateFormat('yyyy/MM/dd hh:mm:ss a').format(EditTripData.getInstance().endDateDate ?? DateTime.now()),
                        onTap: () async {
                          viewModel.updateDate();
                          List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
                            context: context,
                            startInitialDate: viewModel.defaultStartDate,
                            startFirstDate: viewModel.defaultStartDate,
                            startLastDate: viewModel.defaultEndDate,
                            endInitialDate: viewModel.defaultEndDate,
                            endFirstDate: viewModel.defaultStartDate,
                            endLastDate: viewModel.defaultEndDate,
                            is24HourMode: false,
                            isShowSeconds: false,
                            minutesInterval: 1,
                            secondsInterval: 1,
                            isForce2Digits: true,
                            borderRadius: const BorderRadius.all(Radius.circular(16)),
                            constraints: const BoxConstraints(
                              maxWidth: 350,
                              maxHeight: 650,
                            ),
                            transitionBuilder: (context, anim1, anim2, child) {
                              return FadeTransition(
                                opacity: anim1.drive(
                                  Tween(
                                    begin: 0,
                                    end: 1,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 200),
                            barrierDismissible: true,
                            theme: ThemeData(
                                useMaterial3: true,
                                colorSchemeSeed: theme.colorScheme.primary
                            ),
                            selectableDayPredicate: (dateTime) {
                              // Disable 25th Feb 2023
                              print(dateTime);
                              print("dateTime");
                              return true;
                              /*  if (dateTime == DateTime(2023, 2, 25)) {
                              return false;
                            } else {
                              return true;
                            }*/
                            },
                          );


                          if(dateTimeList?[0] != null){
                            viewModel.defaultStartDate = dateTimeList?[0];
                          }


                          if(dateTimeList?[1] != null){
                            viewModel.defaultEndDate = dateTimeList?[1];
                          }
                          viewModel.notifyListeners();

                          print("Start dateTime: ${dateTimeList?[0].toString().split(r"\s+")}");
                          print(viewModel.defaultStartDate);
                          print("End dateTime: ${dateTimeList?[1]}");
                        }),
                    SizedBox(height: 10,),
                  ])),
              bottomNavigationBar: bottomButton("Continue",context,onButtonPress: (){
                EditTripData.getInstance().startDate = viewModel.defaultStartDate;
                EditTripData.getInstance().endDateDate = viewModel.defaultEndDate;
                parentViewModel.setCurrentIndex(0);
              }))),
    );
  }


  Widget _buildCustomRow(
      BuildContext context, {
        required String title,
        required String value,
        required Function() onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: AppDecoration.outlineBlack9002
              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
                padding: EdgeInsets.only(top: 3),
                child: Text(title,
                    style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.onSecondaryContainer))),
            Spacer(),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Text(value,
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: appTheme.gray70004))),
            CustomImageView(
                imagePath: ImageConstant.imgArrowRightPrimary,
                height: 18,
                width: 7,
                margin: EdgeInsets.only(left: 10, top: 2, bottom: 2))
          ])),
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

  Widget bottomButton(String buttonText , BuildContext context , {required Function() onButtonPress}) {
    return CustomOutlinedButton(
        height: 48,
        text: buttonText,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles
            .titleMediumOnErrorContainerSemiBold,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 34),
        onPressed: () {
          onButtonPress();
          //  onTapPostTrip(context);
        });


  }

}


class EditTripFormScreen extends StackedView<EditTripFormViewModel> {

  EditTripViewModel parentViewModel;

  EditTripFormScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, EditTripFormViewModel viewModel, Widget? child) {
    return _buildFrame(context, viewModel);
  }

  @override
  EditTripFormViewModel viewModelBuilder(BuildContext context) {
    return EditTripFormViewModel();
  }

  @override
  bool get reactive => super.reactive;

  @override
  void onViewModelReady(EditTripFormViewModel viewModel) {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLuggageTypes(StackedService.navigatorKey!.currentContext!, viewModel); // Call API after first build
    });
    super.onViewModelReady(viewModel);
  }

  Widget _buildFrame(BuildContext context , EditTripFormViewModel viewModel) {

    return  LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro){
        return customProgessBar();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          parentViewModel.setCurrentIndex(0);
        },
        child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Edit Trip", onBackClicked: (){
              parentViewModel.setCurrentIndex(0);
            }),
            body: Form(
              child: Builder(
                builder: (context){
                  viewModel.formContext = context;
                  return Column(
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
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 13),
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: AppDecoration.fillGray10001
                              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                          child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 9, top: 6, bottom: 6),
                                    child: CustomFloatingTextField(
                                        width: MediaQuery.sizeOf(context).width * 0.4,
                                        controller: viewModel.productSpaceController,
                                        hintText: "please enter space",
                                        focusNode: viewModel.focusNodeProductSpace,
                                        hintStyle: CustomTextStyles.bodyMediumBluegray4000115,
                                        textInputType: TextInputType.number,
                                        textInputFormater:<TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*$"))
                                        ],
                                        borderDecoration: FloatingTextFormFieldStyleHelper.custom,
                                        contentPadding: EdgeInsets.only(top: 5),
                                        validator: viewModel.validateProductSpace
                                    )),
                                Expanded(child: _buildKilogramsButton(context,viewModel))
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
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 13),
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: AppDecoration.fillGray10001
                              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                          child:ValueListenableBuilder<List<luggageModel.Data>?>(
                            valueListenable: viewModel.luggageDataList,
                            builder: (context , snapshot ,_){
                              return snapshot!.isNotEmpty ? _buildPackageTypeButton(context, viewModel) : Container();
                            },
                          )),

                      SizedBox(height: 7),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("lbl_commission".tr,
                              style: CustomTextStyles.titleMediumSemiBold),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 14,vertical: 13),
                          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          decoration: AppDecoration.fillGray10001
                              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                          child:
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 9, top: 6, bottom: 6),
                                    child: CustomFloatingTextField(
                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                        controller: viewModel.commissionController,
                                        hintText: "please enter commission",
                                        focusNode: viewModel.focusNodeCommission,
                                        textInputFormater:<TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r"^\d*\.?\d*$"))
                                        ],
                                        hintStyle: CustomTextStyles.bodyMediumBluegray4000115,
                                        textInputType: TextInputType.number,
                                        borderDecoration: FloatingTextFormFieldStyleHelper.custom,
                                        contentPadding: EdgeInsets.only(top: 5),
                                        validator: viewModel.validateCommission
                                    )),
                                SizedBox(width: 100 ,child: _buildCommisionButton(context,viewModel))
                              ])),
                    ],
                  );
                },
              ),
            ),
            bottomNavigationBar: bottomButton("Continue",context,onButtonPress: (){
              if(viewModel.validateForm(viewModel.formContext)){
                EditTripData.getInstance().luggageSpace = viewModel.productSpaceController.text;
                EditTripData.getInstance().commission = viewModel.commissionController.text;
                EditTripData.getInstance().luggageType = viewModel.luggageData.value == null ? LuggageType(EditTripData.getInstance().luggageType?.id, EditTripData.getInstance().luggageType?.name) :
                LuggageType(viewModel.luggageData.value?.id, viewModel.luggageData.value?.name);
                parentViewModel.setCurrentIndex(0);
                print(viewModel.productSpaceController.text);
                print(viewModel.commissionController.text);
                print(viewModel.luggageData.value == null ? viewModel.luggageDataList!.value?.first.name : viewModel.luggageData.value?.name);
              }

            }),
          ),
        ),
      ),
    );

  }

  Widget _buildKilogramsButton(BuildContext context , EditTripFormViewModel viewModel) {
    return  ValueListenableBuilder<String?>(
      valueListenable: viewModel.selectedValue,
      builder: (cont , snapshot , _){
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: theme.cardColor
          ),
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

  Widget _buildPackageTypeButton(BuildContext context , EditTripFormViewModel viewModel) {
    return ValueListenableBuilder<luggageModel.Data?>(
        valueListenable: viewModel.luggageData,
        builder: (context , snapshot , _){
          return  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.cardColor
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<luggageModel.Data>(
                isExpanded: true,
                hint: Text(
                 // viewModel.luggageDataList.value?.first.name ?? "",
                   EditTripData.getInstance().luggageType?.name ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: viewModel.luggageDataList.value?.map((luggageModel.Data item) => DropdownMenuItem<luggageModel.Data>(
                  value: item,
                  child: Text(
                    item.name ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
                    .toList(),
                value: snapshot ,
                onChanged: (luggageModel.Data? value) {
                  print(value!.name ?? "");
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

  Widget _buildCommisionButton(BuildContext context , EditTripFormViewModel viewModel) {
    return  ValueListenableBuilder<String?>(
      valueListenable: viewModel.commissionSelectedValue,
      builder: (con , snapshot , _){
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: theme.cardColor
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: Text(
                viewModel.comissionUnitList[0],
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).hintColor,
                ),
              ),
              items: viewModel.comissionUnitList
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
                viewModel.setCommissionUnitValue(value!);
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


  fetchLuggageTypes(BuildContext context, EditTripFormViewModel viewModel) {
    CustomLoader.showLoader(context);
    viewModel.getLuggageTypes().then((value) {
      CustomLoader.hideLoader(context);

      if (value.success ?? false) {
        viewModel.luggageDataList.value = value.data ?? [];
      } else {
        CustomDialog.showErrorDialog(context, onPressedDialog: (){
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

  Widget bottomButton(String buttonText , BuildContext context , {required Function() onButtonPress}) {
    return CustomOutlinedButton(
        height: 48,
        text: buttonText,
        buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
        buttonTextStyle: CustomTextStyles
            .titleMediumOnErrorContainerSemiBold,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 34),
        onPressed: () {
          onButtonPress();
          //  onTapPostTrip(context);
        });


  }

}


