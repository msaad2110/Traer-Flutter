
import 'dart:ffi';

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
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/city_response.dart';
import 'package:traer/models/country_response.dart';
import 'package:traer/models/filter_model.dart';
import 'package:traer/models/sort_by_model.dart';
import 'package:traer/models/state_response.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_viewmodel.dart';
import 'package:traer/ui/customer/customer_trip_filter/filter_city_viewmodel.dart';
import 'package:traer/ui/customer/customer_trip_filter/filter_country_viewmodel.dart';
import 'package:traer/ui/customer/customer_trip_filter/filter_state_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/appbar_subtitle_two.dart';
import 'package:traer/widgets/appbar_title.dart';
import 'package:traer/widgets/appbar_title_button_four.dart';
import 'package:traer/widgets/appbar_trailing_image.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_floating_text_field.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:typewritertext/typewritertext.dart';

import '../../../widgets/custom_outlined_button.dart';
import '../../../widgets/custom_progressbar.dart';

class CustomerTripFilterView extends StackedView<CustomerTripFilterViewModel>{


  @override
  Widget builder(BuildContext context, CustomerTripFilterViewModel viewModel, Widget? child) {
    return mainView(context, viewModel);
  }




    Widget mainView(BuildContext context , CustomerTripFilterViewModel viewModel){
      return PageView.builder(
        controller: viewModel.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 9, // Number of screens
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return filterTripScreen(context, viewModel);
            case 1:
              return FilterCountryScreen(viewModel);
            case 2:
              return FilterStateScreen(viewModel);
            case 3:
              return FilterCityScreen(viewModel);
           /* case 4:
              return NewTripOriginCountryScreen(viewModel);
            case 5:
              return NewTripOriginStateScreen( viewModel);
            case 6:
              return NewTripOriginCityScreen(viewModel);
            case 7:
              return NewTripDateTimePickerScreen(viewModel);
              return NewTripDatePickerScreen(viewModel);
            case 8:
              return NewTripFormScreen(viewModel);*/
          // ... cases for other screens
            default:
              return Container(); // Handle unexpected indices
          }
        },
      );
    }


  Widget filterTripScreen(BuildContext context , CustomerTripFilterViewModel viewModel){
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
                appBar: _buildAppBar(context,viewModel),
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Column(children: [
                        SizedBox(height: 7),
                        Container(
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.symmetric(horizontal: 14,vertical: 13),
                            margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                            decoration: AppDecoration.fillGray10001
                                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                            child:Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Sort By".tr,
                                        style: CustomTextStyles.titleMediumSemiBold),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: ValueListenableBuilder<List<SortByModel>?>(
                                    valueListenable: viewModel.sortByList,
                                    builder: (context , snapshot ,_){
                                      return snapshot!.isNotEmpty ? _buildPackageTypeButton(context, viewModel) : Container();
                                    },
                                  ),
                                ),
                              ],
                            )),
                        _buildCustomRow(context,
                            title: "Date".tr,
                            value: FilterModel.getInstance().starDate == null ? "" : (DateFormat('MMM dd').format(FilterModel.getInstance().starDate ?? DateTime.now()) + " - " +
                                DateFormat('MMM dd').format(FilterModel.getInstance().endDate ?? DateTime.now())),
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
                                type: OmniDateTimePickerType.date,
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
                                  FilterModel.getInstance().starDate = dateTimeList?[0];
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
                                  FilterModel.getInstance().endDate = dateTimeList?[1];
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

                            /*  if(dateTimeList?[0] != null){
                                FilterModel.getInstance().starDate = dateTimeList?[0];
                              }


                              if(dateTimeList?[1] != null){
                                FilterModel.getInstance().endDate = dateTimeList?[1];
                              }*/
                              viewModel.notifyListeners();
                              print("Start dateTime: ${dateTimeList?[0]}");
                              print("End dateTime: ${dateTimeList?[1]}");
                            }),
                        SizedBox(height: 10),
                        _buildCustomRow(context,
                            title: "Select City".tr,
                            value: (FilterModel.getInstance().filterCity == null) ? "" : (FilterModel.getInstance().filterCity?.city_name ?? ""),onTap: (){
                              viewModel.setCurrentIndex(1);
                            }),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0, vertical: 13),
                          decoration: AppDecoration.fillGray10001.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder12),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 14),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Luguage Capacity".tr,
                                      style: CustomTextStyles.titleMediumSemiBold),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 13),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 10),

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
                                            )),
                                        Expanded(
                                            child: _buildKilogramsButton(
                                                context, viewModel))
                                      ])),
                            ],
                          ),
                        ),

                        SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                          decoration: AppDecoration.outlineBlack9002
                              .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                          child: Column(mainAxisSize: MainAxisSize.min, children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("lbl_commission".tr,
                                          style: CustomTextStyles.titleMediumSemiBold),
                                      CustomImageView(
                                          imagePath: ImageConstant.imgArrowUpPrimary13x12,
                                          height: 13,
                                          width: 12,
                                          margin: EdgeInsets.symmetric(vertical: 3))
                                    ])),
                            SizedBox(height: 17),
                            ValueListenableBuilder(
                              valueListenable: viewModel.rangeSliderSelectedValue,
                              builder: (cont,snapshot,_){
                                return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                        padding: EdgeInsets.only(left: 2),
                                        child: Text(viewModel.rangeSliderSelectedValue.value[0].toStringAsFixed(0)+"%-"+viewModel.rangeSliderSelectedValue.value[1].toStringAsFixed(0)+"%",
                                            style: CustomTextStyles.titleMediumBlack900SemiBold_1),),);
                              },
                            ),
                            SizedBox(height: 16),
                            SliderTheme(
                                data: SliderThemeData(
                                    trackShape: RoundedRectSliderTrackShape(),
                                    activeTrackColor: theme.colorScheme.primary,
                                    inactiveTrackColor: appTheme.blueGray100,
                                    thumbColor: theme.colorScheme.onErrorContainer.withOpacity(1),
                                    thumbShape: RoundSliderThumbShape()),
                                child: ValueListenableBuilder(
                                  valueListenable: viewModel.rangeSliderSelectedValue,
                                  builder: (cont , snapshot ,_){
                                    return  RangeSlider(
                                        values: RangeValues(viewModel.rangeSliderSelectedValue.value[0],viewModel.rangeSliderSelectedValue.value[1]),
                                        min: 0.0,
                                        max: 100.0,
                                        onChanged: (value) {
                                          viewModel.rangeSliderSelectedValue.value = [value.start,value.end];
                                          FilterModel.getInstance().commissionStart = value.start.toInt();
                                          FilterModel.getInstance().commissionEnd = value.end.toInt();


                                        });
                                  }
                                ))
                          ])),
                        SizedBox(height: 5)
                      ])),
                ),
                bottomNavigationBar: bottomButton("Show Trips".tr,context,onButtonPress: (){
                  if(viewModel.productSpaceController.text.toString().isNotEmpty){
                    FilterModel.getInstance().luggageSpace = int.parse(viewModel.productSpaceController.text.toString());
                  };
                  locator<NavigationService>().back(result: FilterModel.getInstance());

                })),
          )),
    );
  }

  Widget _buildPackageTypeButton(BuildContext context , CustomerTripFilterViewModel viewModel) {
    return ValueListenableBuilder<SortByModel?>(
        valueListenable: viewModel.sortByItem,
        builder: (context , snapshot , _){
          return  Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: theme.cardColor
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<SortByModel>(
                isExpanded: true,
                hint: Text(
                   viewModel.sortByList.value?.first.name ?? "",
                  //EditTripData.getInstance().luggageType?.name ?? "",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: viewModel.sortByList.value?.map((SortByModel item) => DropdownMenuItem<SortByModel>(
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
                onChanged: (SortByModel? value) {
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

  Widget _buildKilogramsButton(BuildContext context, CustomerTripFilterViewModel viewModel) {
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
          decoration: AppDecoration.fillGray100
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


  @override
  CustomerTripFilterViewModel viewModelBuilder(BuildContext context) {
    return CustomerTripFilterViewModel();
  }

  @override
  void onDispose(CustomerTripFilterViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  void onViewModelReady(CustomerTripFilterViewModel viewModel) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchLuggageTypes(StackedService.navigatorKey!.currentContext!, viewModel); // Call API after first build
    });
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;


  PreferredSizeWidget _buildAppBar(BuildContext context, CustomerTripFilterViewModel viewModel) {
    return CustomAppBar(
        leadingWidth: 26,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgUserPrimary,
            margin: EdgeInsets.only(left: 20, top: 22, bottom: 23),
            onTap: () {
              onTapClose();
            }),
        title: AppbarTitleButtonFour(
            onTap: () {
              onTapFilters(context);
            }),
        actions: [
          AppbarSubtitleTwo(
              text: "lbl_reset".tr,
              margin: EdgeInsets.fromLTRB(20, 18, 20, 17),
              onTap: () {
                onTapLeftTitle(context,viewModel);
              })
        ]);
  }

  onTapFilters(BuildContext context) {

  }

  onTapClose() {
    locator<NavigationService>().back();
  }
  /// Navigates to the customerTripFiltersScreen when the action is triggered.
  onTapLeftTitle(BuildContext context, CustomerTripFilterViewModel viewModel) {
   FilterModel.getInstance().clearData();
   viewModel.rangeSliderSelectedValue.value = [0.0,100,0];
   viewModel.productSpaceController.clear();
   viewModel.notifyListeners();
  }

  Widget _buildFrameFortyEight(
      BuildContext context, {
        required String dynamicText,
        required String dynamicText1,
        Function? onTapFrameFortyEight,
      }) {
    return GestureDetector(
        onTap: () {
          onTapFrameFortyEight!.call();
        },
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            decoration: AppDecoration.outlineBlack9002
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(dynamicText,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.onSecondaryContainer)),
              Spacer(),
              Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(dynamicText1,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: appTheme.gray70004))),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRightPrimary,
                  height: 18,
                  width: 7,
                  margin: EdgeInsets.only(left: 10))
            ])));
  }


  fetchLuggageTypes(BuildContext context, CustomerTripFilterViewModel viewModel) {

    viewModel.sortByList.value = [new SortByModel(0, "Default") , new SortByModel(1, "Commission L to H"),new SortByModel(2,"Commission H to L")];
    viewModel.productSpaceController.text = FilterModel.getInstance().luggageSpace == null ? "" : FilterModel.getInstance().luggageSpace.toString();


  }
}


class FilterCountryScreen extends StackedView<FilterCountryViewModel>{
  CustomerTripFilterViewModel parentViewModel;

  FilterCountryScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, FilterCountryViewModel viewModel, Widget? child) {
    return _destinationCountrySelectionSecreen(context,viewModel);
  }



  @override
  FilterCountryViewModel viewModelBuilder(BuildContext context) {
    return FilterCountryViewModel();
  }

  @override
  void onViewModelReady(FilterCountryViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget _destinationCountrySelectionSecreen(BuildContext context , FilterCountryViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select  Country", onBackClicked: (){
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
                        "Select your  country....",
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
                      controller: viewModel.filterCountrySearchController,
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

  FutureBuilder<CountryResponse> getDestinationCountries(FilterCountryViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCountries("countries"),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            viewModel.filterFoundCountries.value = (snapshot.data!.data!.first.countries ?? []);
            viewModel.filterAllCountries = (snapshot.data!.data!.first.countries ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Countries>>(
                valueListenable: viewModel.filterFoundCountries,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationCountryListView(viewModel, context, viewModel.filterFoundCountries.value);
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

  Widget buildDestinationCountryListView(FilterCountryViewModel viewModel , BuildContext context , List<Countries> data){
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

  Widget countryDestinationlistItem(FilterCountryViewModel homeViewModel , Countries dataSource , BuildContext context){

    return InkWell(

      onTap: () {
        FilterModel.getInstance().destinationCountry = dataSource;
        print( FilterModel.getInstance().destinationCountry);
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

  void filterDestinationCountrySearchResults(String query , FilterCountryViewModel viewModel) {

    List<Countries> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.filterAllCountries;
    }else{
      for(Countries country in viewModel.filterAllCountries){
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

class FilterStateScreen extends StackedView<FilterStateViewModel>{
  CustomerTripFilterViewModel parentViewModel;


  FilterStateScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, FilterStateViewModel viewModel, Widget? child) {
    return _destinationStateSelectionSecreen(context, viewModel);
  }

  @override
  FilterStateViewModel viewModelBuilder(BuildContext context) {
    return FilterStateViewModel();
  }


  @override
  void onViewModelReady(FilterStateViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationStateSelectionSecreen(BuildContext context , FilterStateViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(1);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Select  State", onBackClicked: (){
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
                        "Select your State....",
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
                      controller: viewModel.filterStateSearchController,
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


  FutureBuilder<StateResponse> getDestinationStates(FilterStateViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStates("states",FilterModel.getInstance().destinationCountry?.country_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination state call");
            viewModel.filterFoundStates.value = (snapshot.data!.data!.first.states ?? []);
            viewModel.filterAllStates = (snapshot.data!.data!.first.states ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<States>>(
                valueListenable: viewModel.filterFoundStates,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationStateListView(viewModel, context, viewModel.filterFoundStates.value);
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


  Widget buildDestinationStateListView(FilterStateViewModel viewModel , BuildContext context , List<States> data){
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


  Widget stateDestinationlistItem(FilterStateViewModel homeViewModel , States dataSource , BuildContext context){

    return InkWell(
      onTap: (){
        FilterModel.getInstance().filterState = dataSource;
        print( FilterModel.getInstance().filterState);
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

  void filterDestinationStateSearchResults(String query , FilterStateViewModel viewModel) {

    List<States> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.filterAllStates;
    }else{
      for(States state in viewModel.filterAllStates){
        if(state.state_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(state);
        }
      }
    }

    viewModel.setDestinationStates(searchList);

  }

}


class FilterCityScreen extends StackedView<FilterCityViewModel> {

  CustomerTripFilterViewModel parentViewModel;

  FilterCityScreen(this.parentViewModel);

  @override
  Widget builder(BuildContext context, FilterCityViewModel viewModel, Widget? child) {
    return _destinationCitySelectionSecreen(context, viewModel);
  }

  @override
  FilterCityViewModel viewModelBuilder(BuildContext context) {
    return FilterCityViewModel();
  }

  @override
  void onViewModelReady(FilterCityViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget _destinationCitySelectionSecreen(BuildContext context , FilterCityViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(2);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context,"Select  City" , onBackClicked: (){
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
                        "Select your  City....",
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
                      controller: viewModel.filterCitySearchController,
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

  FutureBuilder<CityResponse> getDestinationCities(FilterCityViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getCities("cities",FilterModel.getInstance().filterState?.state_name ?? ""),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination cities call");
            viewModel.filterFoundCities.value = (snapshot.data!.data!.first.cities ?? []);
            viewModel.filterAllCities = (snapshot.data!.data!.first.cities ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Cities>>(
                valueListenable: viewModel.filterFoundCities,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildDestinationCityListView(viewModel, context, viewModel.filterFoundCities.value);
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


  Widget buildDestinationCityListView(FilterCityViewModel viewModel , BuildContext context , List<Cities> data){
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

  Widget cityDestinationlistItem(FilterCityViewModel homeViewModel , Cities dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        FilterModel.getInstance().filterCity = dataSource;
        print( FilterModel.getInstance().filterCity);
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

  void filterDestinationCitySearchResults(String query , FilterCityViewModel viewModel) {

    List<Cities> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.filterAllCities;
    }else{
      for(Cities city in viewModel.filterAllCities){
        if(city.city_name!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(city);
        }
      }
    }

    viewModel.setDestinationCities(searchList);

  }

}
