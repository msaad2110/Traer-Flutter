


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
import 'package:traer/main.dart';
import 'package:traer/models/all_luggagetype.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/newtripdata.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/newtrip/new_trip_form_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_datepicker_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_destination_city_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_destination_country_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_destination_state_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_origin_city_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_origin_country_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_origin_state_viewmodel.dart';
import 'package:traer/ui/traveler/newtrip/newtrip_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_elevated_button.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:traer/models/all_luggagetype.dart' as luggageModel;

class NewTripView extends StackedView<NewTripViewModel>{


  @override
  Widget builder(BuildContext context, NewTripViewModel viewModel, Widget? child) {
    return mainView(context, viewModel);
  }

  @override
  NewTripViewModel viewModelBuilder(BuildContext context) {
    return NewTripViewModel();
  }

  @override
  void onViewModelReady(NewTripViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget mainView(BuildContext context , NewTripViewModel viewModel){
    return PageView.builder(
      controller: viewModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 9, // Number of screens
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return postNewTripScreen(context, viewModel);
          case 1:
            return NewTripDestinationCountryScreen(viewModel);
          case 2:
            return NewTripDestinationStateScreen(viewModel);
          case 3:
            return NewTripDestinationCityScreen(viewModel);
          case 4:
            return NewTripOriginCountryScreen(viewModel);
          case 5:
            return NewTripOriginStateScreen( viewModel);
          case 6:
            return NewTripOriginCityScreen(viewModel);
          case 7:
            return NewTripDateTimePickerScreen(viewModel);
            return NewTripDatePickerScreen(viewModel);
          case 8:
            return NewTripFormScreen(viewModel);
        // ... cases for other screens
          default:
            return Container(); // Handle unexpected indices
        }
      },
    );
  }


  Widget postNewTripScreen(BuildContext context , NewTripViewModel viewModel){
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
                appBar: _buildAppBar(context ,"New Trip", onBackClicked: (){
                  print("back--");
                  onTapClose(context);
                }),
                body: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Column(children: [
                      _buildCustomRow(context,
                          title: "lbl_traveling_to".tr,
                          value: (NewTripData.getInstance().destinationCity == null) ? "" : (NewTripData.getInstance().destinationCity?.city_name ?? ""),onTap: (){
                           print("object");
                           viewModel.setCurrentIndex(1);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_traveling_from".tr,
                          value: (NewTripData.getInstance().originCity == null) ? "" : (NewTripData.getInstance().originCity?.city_name ?? "")  ,onTap: (){
                            viewModel.setCurrentIndex(4);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_traveling_date".tr,
                          value: NewTripData.getInstance().startDate == null ? "" : (DateFormat('MMM dd').format(NewTripData.getInstance().startDate ?? DateTime.now()) + " - " +
                              DateFormat('MMM dd').format(NewTripData.getInstance().endDateDate ?? DateTime.now())),onTap: (){
                            viewModel.setCurrentIndex(7);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_luggage_space".tr,
                          value: NewTripData.getInstance().luggageSpace == null ? "" : (NewTripData.getInstance().luggageSpace!+"KG") ?? "",onTap: (){
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_luggage_type".tr,
                          value: NewTripData.getInstance().luggageType == null ? "" : NewTripData.getInstance().luggageType?.name ?? "",onTap: (){
                            print("object");
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 10),
                      _buildCustomRow(context,
                          title: "lbl_commission".tr,
                          value: NewTripData.getInstance().commission == null ? "" : NewTripData.getInstance().commission!+"%" ?? "",onTap: (){
                            print("object");
                            viewModel.setCurrentIndex(8);
                          }),
                      SizedBox(height: 5)
                    ])),
                bottomNavigationBar: bottomButton("lbl_post_trip".tr,context,onButtonPress: (){
                   if(viewModel.validateNewTripData().$1){
                        onTapPostTrip(context, viewModel);
                   }else{
                     CustomDialog.showErrorDialog(context,message:viewModel.validateNewTripData().$2, onPressedDialog: (){
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


  void backClick(int index , NewTripViewModel viewModel){
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

  onTapPostTrip(BuildContext context , NewTripViewModel viewModel) {
    CustomLoader.showLoader(context);
    //  viewModel.login("shaheerzaeem26@gmail.com", "test_password").then((value){
    viewModel.newTrip(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0 ,
       NewTripData.getInstance().luggageType?.id  ?? 0 ,
       NewTripData.getInstance().originCity?.city_name  ?? "" ,
       NewTripData.getInstance().destinationCity?.city_name  ?? "" ,
       DateFormat('yyyy/MM/dd').format(NewTripData.getInstance().startDate ?? DateTime.now()),
       DateFormat('yyyy/MM/dd').format(NewTripData.getInstance().endDateDate ?? DateTime.now()),
       int.parse(NewTripData.getInstance().luggageSpace ?? "0")  ,
       int.parse(NewTripData.getInstance().commission ?? "0")
    ).then((value){
      CustomLoader.hideLoader(context);

      if(value.success ?? false){
        CustomDialog.showSuccessDialog(context , message : value.data ?? "" , onPressedDialog: (){
          Navigator.pop(context);
          onTapClose(context);
          NewTripData.getInstance().clearData();
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

class NewTripDestinationCountryScreen extends StackedView<NewTripDestinationCountryViewModel>{
  NewTripViewModel parentViewModel;

  NewTripDestinationCountryScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripDestinationCountryViewModel viewModel, Widget? child) {
    return _destinationCountrySelectionSecreen(context,viewModel);
  }



  @override
  NewTripDestinationCountryViewModel viewModelBuilder(BuildContext context) {
    return NewTripDestinationCountryViewModel();
  }

  @override
  void onViewModelReady(NewTripDestinationCountryViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget _destinationCountrySelectionSecreen(BuildContext context , NewTripDestinationCountryViewModel viewModel) {

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
                      focusNode: viewModel.focusNode,
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

  FutureBuilder<CountryResponse> getDestinationCountries(NewTripDestinationCountryViewModel viewModel){
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

  Widget buildDestinationCountryListView(NewTripDestinationCountryViewModel viewModel , BuildContext context , List<Countries> data){
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

  Widget countryDestinationlistItem(NewTripDestinationCountryViewModel homeViewModel , Countries dataSource , BuildContext context){

    return InkWell(

      onTap: () {
        NewTripData.getInstance().destinationCountry = dataSource;
        print( NewTripData.getInstance().destinationCountry);
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

  void filterDestinationCountrySearchResults(String query , NewTripDestinationCountryViewModel viewModel) {

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

class NewTripOriginCountryScreen extends StackedView<NewTripOriginCountryViewModel>{
  NewTripViewModel parentViewModel;


  NewTripOriginCountryScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripOriginCountryViewModel viewModel, Widget? child) {
   return _originCountrySelectionSecreen(context, viewModel);
  }

  @override
  NewTripOriginCountryViewModel viewModelBuilder(BuildContext context) {
    return NewTripOriginCountryViewModel();
  }

  @override
  void onViewModelReady(NewTripOriginCountryViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originCountrySelectionSecreen(BuildContext context , NewTripOriginCountryViewModel viewModel) {

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
  FutureBuilder<CountryResponse> getOriginCountries(NewTripOriginCountryViewModel viewModel){
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
  Widget buildOriginCountryListView(NewTripOriginCountryViewModel viewModel , BuildContext context , List<Countries> data){
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
  Widget countryOriginlistItem(NewTripOriginCountryViewModel homeViewModel , Countries dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        NewTripData.getInstance().originCountry = dataSource;
        print( NewTripData.getInstance().originCountry);
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

  void filterOriginCountrySearchResults(String query , NewTripOriginCountryViewModel viewModel) {

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

class NewTripDestinationStateScreen extends StackedView<NewTripDestinationStateViewModel>{
  NewTripViewModel parentViewModel;


  NewTripDestinationStateScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripDestinationStateViewModel viewModel, Widget? child) {
    return _destinationStateSelectionSecreen(context, viewModel);
  }

  @override
  NewTripDestinationStateViewModel viewModelBuilder(BuildContext context) {
     return NewTripDestinationStateViewModel();
  }


  @override
  void onViewModelReady(NewTripDestinationStateViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationStateSelectionSecreen(BuildContext context , NewTripDestinationStateViewModel viewModel) {

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


  FutureBuilder<StateResponse> getDestinationStates(NewTripDestinationStateViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStates("states",NewTripData.getInstance().destinationCountry?.country_name ?? ""),
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


  Widget buildDestinationStateListView(NewTripDestinationStateViewModel viewModel , BuildContext context , List<States> data){
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


  Widget stateDestinationlistItem(NewTripDestinationStateViewModel homeViewModel , States dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        NewTripData.getInstance().destinationState = dataSource;
        print( NewTripData.getInstance().destinationState);
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

  void filterDestinationStateSearchResults(String query , NewTripDestinationStateViewModel viewModel) {

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

class NewTripOriginStateScreen extends StackedView<NewTripOriginStateViewModel>{
  NewTripViewModel parentViewModel;


  NewTripOriginStateScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripOriginStateViewModel viewModel, Widget? child) {
    return _originStateSelectionSecreen(context,viewModel);
  }

  @override
  NewTripOriginStateViewModel viewModelBuilder(BuildContext context) {
   return NewTripOriginStateViewModel();
  }


  @override
  void onViewModelReady(NewTripOriginStateViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originStateSelectionSecreen(BuildContext context , NewTripOriginStateViewModel viewModel) {

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

  FutureBuilder<StateResponse> getOriginStates(NewTripOriginStateViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStates("states",NewTripData.getInstance().originCountry?.country_name ?? ""),
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


  void filterOriginStateSearchResults(String query , NewTripOriginStateViewModel viewModel) {

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

  Widget buildOriginStateListView(NewTripOriginStateViewModel viewModel , BuildContext context , List<States> data){
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

  Widget stateOriginlistItem(NewTripOriginStateViewModel homeViewModel , States dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        NewTripData.getInstance().originState = dataSource;
        print( NewTripData.getInstance().originState);
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

class NewTripDestinationCityScreen extends StackedView<NewTripDestinationCityViewModel> {

  NewTripViewModel parentViewModel;

  NewTripDestinationCityScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripDestinationCityViewModel viewModel, Widget? child) {
    return _destinationCitySelectionSecreen(context, viewModel);
  }

  @override
  NewTripDestinationCityViewModel viewModelBuilder(BuildContext context) {
    return NewTripDestinationCityViewModel();
  }

  @override
  void onViewModelReady(NewTripDestinationCityViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationCitySelectionSecreen(BuildContext context , NewTripDestinationCityViewModel viewModel) {

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

  FutureBuilder<CityResponse> getDestinationCities(NewTripDestinationCityViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCities("cities",NewTripData.getInstance().destinationState?.state_name ?? ""),
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


  Widget buildDestinationCityListView(NewTripDestinationCityViewModel viewModel , BuildContext context , List<Cities> data){
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

  Widget cityDestinationlistItem(NewTripDestinationCityViewModel homeViewModel , Cities dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        NewTripData.getInstance().destinationCity = dataSource;
        print( NewTripData.getInstance().destinationCity);
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

  void filterDestinationCitySearchResults(String query , NewTripDestinationCityViewModel viewModel) {

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

class NewTripOriginCityScreen extends StackedView<NewTripOriginCityViewModel> {

  NewTripViewModel parentViewModel;


  NewTripOriginCityScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripOriginCityViewModel viewModel, Widget? child) {
    return _originCitySelectionSecreen(context,viewModel);
  }

  @override
  NewTripOriginCityViewModel viewModelBuilder(BuildContext context) {
    return NewTripOriginCityViewModel();
  }

  @override
  void onViewModelReady(NewTripOriginCityViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  Widget _originCitySelectionSecreen(BuildContext context , NewTripOriginCityViewModel viewModel) {

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
                        filterOriginCitySearchResults(v.trim(),viewModel);
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



  FutureBuilder<CityResponse> getOriginCities(NewTripOriginCityViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCities("cities",NewTripData.getInstance().originState?.state_name ?? ""),
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

  Widget buildOriginCityListView(NewTripOriginCityViewModel viewModel , BuildContext context , List<Cities> data){
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

  Widget cityOriginlistItem(NewTripOriginCityViewModel homeViewModel , Cities dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        NewTripData.getInstance().originCity = dataSource;
        print( NewTripData.getInstance().originCity);
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

  void filterOriginCitySearchResults(String query , NewTripOriginCityViewModel viewModel) {

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

class NewTripDatePickerScreen extends StackedView<NewTripDatePickerViewModel> {

  NewTripViewModel parentViewModel;

  NewTripDatePickerScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripDatePickerViewModel viewModel, Widget? child) {
    return datePicker(context, viewModel);
  }

  @override
  NewTripDatePickerViewModel viewModelBuilder(BuildContext context) {
   return NewTripDatePickerViewModel();
  }

  @override
  void onViewModelReady(NewTripDatePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget datePicker(BuildContext context , NewTripDatePickerViewModel viewModel){
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
                NewTripData.getInstance().startDate = viewModel.defaultStartDate;
                NewTripData.getInstance().endDateDate = viewModel.defaultEndDate;
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

class NewTripDateTimePickerScreen extends StackedView<NewTripDatePickerViewModel>{

  NewTripViewModel parentViewModel;

  NewTripDateTimePickerScreen(this.parentViewModel);



  @override
  Widget builder(BuildContext context, NewTripDatePickerViewModel viewModel, Widget? child) {
    return datePicker(context, viewModel);
  }

  @override
  NewTripDatePickerViewModel viewModelBuilder(BuildContext context) {
    return NewTripDatePickerViewModel();
  }

  @override
  void onViewModelReady(NewTripDatePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget datePicker(BuildContext context , NewTripDatePickerViewModel viewModel){
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
                        value: NewTripData.getInstance().startDate == null ? "" : (DateFormat('yyyy/MM/dd hh:mm:ss a').format(NewTripData.getInstance().startDate ?? DateTime.now())),
                        onTap: () async{
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
                              NewTripData.getInstance().startDate = dateTimeList?[0];
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
                              NewTripData.getInstance().endDateDate = dateTimeList?[1];
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
                          viewModel.notifyListeners();
                          print("Start dateTime: ${dateTimeList?[0]}");
                          print("End dateTime: ${dateTimeList?[1]}");
                        }),
                    SizedBox(height: 10,),
                    _buildCustomRow(context,
                        title: "End Date & Time".tr,
                        value: NewTripData.getInstance().endDateDate == null ? "" : (DateFormat('yyyy/MM/dd hh:mm:ss a').format(NewTripData.getInstance().endDateDate ?? DateTime.now())),onTap: () async {
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
                            if (dateTimeList![0].isBefore(dateTimeList![1])) {
                              NewTripData.getInstance().startDate = dateTimeList?[0];
                              print('Start Date: $dateTimeList![0]');
                              print('End Date: $dateTimeList![1]');
                            } else {
                              CustomDialog.showErrorDialog(context,message: "End date cannot be before start date", onPressedDialog: (){
                                Navigator.pop(context);
                              });
                              print('Error: End date cannot be before start date.');
                              print('Start Date: $dateTimeList![0]');
                              print('End Date: $dateTimeList![1]');
                            }
                          }


                          if(dateTimeList?[1] != null){
                            if (dateTimeList![1].isAfter(dateTimeList![0])) {
                              NewTripData.getInstance().endDateDate = dateTimeList?[1];
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
                          viewModel.notifyListeners();

                          print("Start dateTime: ${dateTimeList?[0].toString().split(r"\s+")}");
                          print(viewModel.defaultStartDate);
                          print("End dateTime: ${dateTimeList?[1]}");
                        }),
                    SizedBox(height: 10,),
                  ])),
              bottomNavigationBar: bottomButton("Continue",context,onButtonPress: (){
                /*NewTripData.getInstance().startDate = viewModel.defaultStartDate;
                NewTripData.getInstance().endDateDate = viewModel.defaultEndDate;*/
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


class NewTripFormScreen extends StackedView<NewTripFormViewModel> {

  NewTripViewModel parentViewModel;

  NewTripFormScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, NewTripFormViewModel viewModel, Widget? child) {
    return _buildFrame(context, viewModel);
  }

  @override
  NewTripFormViewModel viewModelBuilder(BuildContext context) {
    return NewTripFormViewModel();
  }

  @override
  bool get reactive => super.reactive;

  @override
  void onViewModelReady(NewTripFormViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLuggageTypes(StackedService.navigatorKey!.currentContext!, viewModel); // Call API after first build
    });    super.onViewModelReady(viewModel);
  }

  Widget _buildFrame(BuildContext context , NewTripFormViewModel viewModel) {

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
            appBar: _buildAppBar(context ,"New Trip", onBackClicked: (){
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
                NewTripData.getInstance().luggageSpace = viewModel.productSpaceController.text;
                NewTripData.getInstance().commission = viewModel.commissionController.text;
                NewTripData.getInstance().luggageType = viewModel.luggageData.value == null ? viewModel.luggageDataList?.value?.first : viewModel.luggageData.value;
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

  Widget _buildKilogramsButton(BuildContext context , NewTripFormViewModel viewModel) {
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

  Widget _buildPackageTypeButton(BuildContext context , NewTripFormViewModel viewModel) {
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
                          viewModel.luggageDataList.value?.first.name ?? "",
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

  Widget _buildCommisionButton(BuildContext context , NewTripFormViewModel viewModel) {
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


  fetchLuggageTypes(BuildContext context, NewTripFormViewModel viewModel) {
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