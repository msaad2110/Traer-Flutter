


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/customer_trip_detail_model.dart';
import 'package:traer/models/filter_model.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_view.dart';
import 'package:traer/ui/customer/customer_trip_history/customer_triphistory_viewmodel.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:traer/widgets/custom_loader.dart';
class CustomerTripHistoryView   extends StatefulWidget{

  const CustomerTripHistoryView({super.key});

  @override
  State<CustomerTripHistoryView> createState() => _CustomerTripHistoryViewState();

}

class _CustomerTripHistoryViewState extends State<CustomerTripHistoryView> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

  }

  onTapClose(BuildContext context) {
    locator<NavigationService>().back();
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerTripHistoryViewModel>.reactive(
      viewModelBuilder: () => CustomerTripHistoryViewModel(),
      onViewModelReady: (model) {},
      builder: (context, model, child) => SafeArea(
        child: PopScope(
          canPop: true,
          onPopInvoked: (val){
            //onTapClose(context);
          },
          child: SafeArea(
            child: LoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (pro){
                return customProgessBar();
              },
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: _buildAppBar(context),
                body: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 9),
                      Container(
                          height: 32,
                          width: 250,
                          margin: EdgeInsets.only(left: 10,right: 10),
                          child: TabBar(
                              indicatorSize: TabBarIndicatorSize.tab,
                              controller:  tabController,
                              dividerColor: Colors.transparent,
                              onTap: model.onTabTapped,
                              labelPadding: EdgeInsets.zero,
                              labelColor: appTheme.whiteA700,
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                              unselectedLabelColor: appTheme.gray80002,
                              unselectedLabelStyle: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                              indicator: BoxDecoration(
                                  color: theme.colorScheme.primary,
                                  borderRadius: BorderRadius.circular(10)),
                              tabs: [
                                Tab(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("All"),
                                )),
                                Tab(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Scheduled"),
                                )),
                                Tab(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Past"),
                                ))
                              ])),
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                            controller: tabController, // Access model's TabController
                            children: [
                              allTripsView(model),
                              allScheduledView(model),
                              allPastView(model),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


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
            text: "lbl_recent_trips".tr,
            margin: EdgeInsets.only(left: 14)));
  }


  onTapRecentTrips(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.travelerHomepageContainerScreen);
  }


  Widget allTripsView(CustomerTripHistoryViewModel viewModel){
    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomSearchView(
                  autofocus: false,
                  controller: viewModel.filterTripSearchController,
                  onChanged: (v){
                    filterTripsSearchResults(v.trim(),viewModel);
                  },
                  hintText: "lbl_search".tr,

                  alignment: Alignment.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: ()async{
                final result  = await locator<NavigationService>().navigateTo(Routes.customerTripFilterView);
                /*FilterModel data = result as FilterModel;
                print(data.filterCity?.city_name ?? "");
                print(data.endDate ?? "");
                print("calling");*/
                viewModel.notifyListeners();
              },
              child:
              Text("Filter".tr,
                  style: CustomTextStyles.titleMediumSemiBold)
              /*CustomIconButton(
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(8),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgArrowUp))*/,
            )
          ],
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: getAllTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
          ),
        ),
      ],
    );

  }

  void filterTripsSearchResults(String query , CustomerTripHistoryViewModel viewModel) {

    List<tripModel.Data> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.filterAllTrip;
    }else{
      for(tripModel.Data item in viewModel.filterAllTrip){
        if(item.travelling_from!.toLowerCase().contains(query.toLowerCase())){
          searchList.add(item);
        }
      }
    }

    viewModel.setTrips(searchList);

  }

  Widget allScheduledView(CustomerTripHistoryViewModel viewModel){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: getScheduledTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
    );

  }

  Widget allPastView(CustomerTripHistoryViewModel viewModel){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: getPastTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
    );

  }

  FutureBuilder<tripModel.TripHistoryModel> getAllTrips(CustomerTripHistoryViewModel viewModel , int userID){
    return FutureBuilder(
        future: viewModel.getRecentTrips(userID,
          FilterModel.getInstance().starDate == null ?  null
            : DateFormat('yyyy-MM-dd').format(FilterModel.getInstance().starDate ?? DateTime.now()),
            FilterModel.getInstance().endDate == null ?  null
                : DateFormat('yyyy-MM-dd').format(FilterModel.getInstance().endDate ?? DateTime.now()),
         FilterModel.getInstance().luggageSpace,
            FilterModel.getInstance().filterCity == null ? null : FilterModel.getInstance().filterCity?.city_name ?? "" ,
           FilterModel.getInstance().commissionStart,FilterModel.getInstance().commissionEnd,UserDataHolder.getInstance().userCurrentStatus),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            viewModel.filterFoundTrips.value = (snapshot.data!.data ?? []);
            viewModel.filterAllTrip = (snapshot.data!.data ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<tripModel.Data>>(
                valueListenable: viewModel.filterFoundTrips,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildAllTripListView(viewModel, context, viewModel.filterFoundTrips.value);
                }
            );
            return buildAllTripListView(viewModel, context, snapshot.data?.data ?? []);

            return Text("data");
          }else if(snapshot.hasError){
            return Center(child: (Text(snapshot.error.toString())));
          } else {
            return showShimmer(context);

          }
        });
  }

  Widget buildAllTripListView(CustomerTripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return tripAlllistItem(viewModel, data[index] , context , index);
        }
    ) :   const Text(
        'No Trip found',
        style: TextStyle(fontSize: 24));
  }

  Widget tripAlllistItem(CustomerTripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {


    String startDateTimeString = "${dataSource.start_date} ${dataSource.start_time == null ? "01:25:00" : dataSource.start_time}";
    DateFormat sFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime startDateTime = sFormatter.parse(startDateTimeString);

    String endDateTimeString = "${dataSource.end_date} ${dataSource.end_time  == null ? "04:25:00" : dataSource.end_time}";
    DateFormat eFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime endDateTime = eFormatter.parse(endDateTimeString);

    Duration difference = endDateTime.difference(startDateTime);

    int daysDifference = difference.inDays;
    int hoursDifference = difference.inHours % 24; // Get hours excluding whole days
    int minutesDifference = difference.inMinutes % 60; // Get minutes excluding whole hours

    print("Difference: $daysDifference days, $hoursDifference hours, $minutesDifference minutes");


    return GestureDetector(
      onTap: () async{
        locator<NavigationService>().navigateTo(Routes.customerTripDetailView,arguments:
        CustomerTripDetailViewArguments(customerTripDetailModel:  CustomerTripDetailModel(
          dataSource.id,
          dataSource.luggage_type_id,
          dataSource.travelling_from,
          dataSource.travelling_to,
          dataSource.start_date,
          dataSource.end_date,
          dataSource.start_time,
          dataSource.end_time,
          dataSource.luggage_space,
          dataSource.commission,
          dataSource.created_by_id,
          dataSource.updated_by_id,
          dataSource.created_at,
          dataSource.updated_at,
          dataSource.deleted_by_id,
          dataSource.deleted_at,
          LuggageType(dataSource.luggage_type?.id,dataSource.luggage_type?.name),
          CreatedBy(dataSource.created_by?.id,dataSource.created_by?.first_name,dataSource.created_by?.last_name,dataSource.created_by?.email,dataSource.created_by?.phone,
              dataSource.created_by?.country ,dataSource.created_by?.is_traveller,dataSource.created_by?.is_verified,dataSource.created_by?.stripe_id,
              dataSource.created_by?.pm_type ,dataSource.created_by?.pm_last_four,
              ProfilePicture(dataSource.created_by?.profile_picture?.id , dataSource.created_by?.profile_picture?.document_type_id,dataSource.created_by?.profile_picture?.user_id,
                  dataSource.created_by?.profile_picture?.name,dataSource.created_by?.profile_picture?.file_name,dataSource.created_by?.profile_picture?.file_path,dataSource.created_by?.profile_picture?.file_preview_path)),
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: AppDecoration.outlineBlack9006.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(dataSource.start_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.start_time == null ? "01:25:00" : dataSource.start_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_from ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Text(
                          "$daysDifference d$hoursDifference h$minutesDifference m",
                          style: CustomTextStyles.bodyMediumBluegray40001,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Divider(),
                        ),
                        SizedBox(height: 9),
                        Text(
                          "1 stop",
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        formatDate(dataSource.end_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.end_time == null ? "01:25:00" : dataSource.end_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_to ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               /* CustomImageView(
                  imagePath: ImageConstant.imgEllipse1226x26,
                  height: 26,
                  width: 26,
                  radius: BorderRadius.circular(
                    13,
                  ),
                ),*/
                _buildAvatar("${dataSource.created_by?.first_name}","${dataSource.created_by?.last_name}"),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    "${dataSource.created_by?.first_name} " " ${dataSource.created_by?.last_name}",
                    style: CustomTextStyles.titleSmallBlack900Medium_2,
                  ),
                ),
                Spacer(),
                CustomOutlinedButton(
                  height: 21,
                  width: 84,
                  text: "4.8",
                  margin: EdgeInsets.symmetric(vertical: 3),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  buttonTextStyle: CustomTextStyles.titleMediumBlack900_2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: appTheme.gray20002,
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text(
                            "Commission:",
                            style: CustomTextStyles.labelLargeGray80002,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            "${dataSource.commission.toString()}%",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 137,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              "Available Space:",
                              style: CustomTextStyles.labelLargeGray80002,
                            ),
                          ),
                          Text(
                            " ${dataSource.luggage_space}KG",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomOutlinedButton(
                  onPressed: (){
                    CustomLoader.showLoader(context);
                    getSingleUserById(dataSource.created_by?.email ?? "").then((user) async {
                      if (user!.id.isNotEmpty) {
                        final room = await FirebaseChatCore.instance.createRoom(user);
                        CustomLoader.hideLoader(context);
                        locator<NavigationService>().navigateTo(Routes.chatView,
                            arguments: ChatViewArguments(room:room));
                      } else {
                        CustomLoader.hideLoader(context);
                        CustomDialog.showSuccessDialog(context,message:  "Oops Error Occured , Try Again Later" , onPressedDialog: (){
                          Navigator.pop(context);
                        });
                        print("User with ID  not found");
                      }
                    });
                  },
                  width: 83,
                  text: "CHAT",
                  margin: EdgeInsets.only(
                    top: 6,
                    bottom: 5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
          ],
        ),
      )
      /*Container(
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
                    imagePath: homeViewModel.imageList[index % homeViewModel.imageList.length])),
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
          ]))*/,
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

  Widget _buildAvatar(String fname , String lName) {
    var color = appTheme.whiteA700;

    /*if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
              (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found.
      }
    }*/

    String firstLetterFirstName = fname.substring(0, 1);
    String firstLetterLastName = lName.substring(0, 1);


    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor:  color,
        backgroundImage:  null,
        radius: 20,
        child:  Text(
          " ${firstLetterFirstName.toUpperCase()}${firstLetterLastName.toUpperCase()} ",
          style: const TextStyle(color: Colors.black),
        )
        ,
      ),
    );
  }

  FutureBuilder<tripModel.TripHistoryModel> getScheduledTrips(CustomerTripHistoryViewModel viewModel , int userID){
    return FutureBuilder(
        future: viewModel.getRecentTrips(userID,null,null,null,null,null,null,UserDataHolder.getInstance().userCurrentStatus),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return buildScheduledTripListView(viewModel, context, snapshot.data?.data ?? []);

            return Text("data");
          }else if(snapshot.hasError){
            return Center(child: (Text(snapshot.error.toString())));
          } else {
            return showShimmer(context);

          }
        });
  }

  Widget buildScheduledTripListView(CustomerTripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return tripScheduledlistItem(viewModel, data[index] , context , index);
        }
    ) :   const Text(
        'No Trip found',
        style: TextStyle(fontSize: 24));
  }

  Widget tripScheduledlistItem(CustomerTripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
    String startDateTimeString = "${dataSource.start_date} ${dataSource.start_time == null ? "01:25:00" : dataSource.start_time}";
    DateFormat sFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime startDateTime = sFormatter.parse(startDateTimeString);

    String endDateTimeString = "${dataSource.end_date} ${dataSource.end_time  == null ? "04:25:00" : dataSource.end_time}";
    DateFormat eFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime endDateTime = eFormatter.parse(endDateTimeString);

    Duration difference = endDateTime.difference(startDateTime);

    int daysDifference = difference.inDays;
    int hoursDifference = difference.inHours % 24; // Get hours excluding whole days
    int minutesDifference = difference.inMinutes % 60; // Get minutes excluding whole hours

    print("Difference: $daysDifference days, $hoursDifference hours, $minutesDifference minutes");


    return GestureDetector(
      onTap: () async{
        locator<NavigationService>().navigateTo(Routes.customerTripDetailView,arguments:
        CustomerTripDetailViewArguments(customerTripDetailModel:  CustomerTripDetailModel(
          dataSource.id,
          dataSource.luggage_type_id,
          dataSource.travelling_from,
          dataSource.travelling_to,
          dataSource.start_date,
          dataSource.end_date,
          dataSource.start_time,
          dataSource.end_time,
          dataSource.luggage_space,
          dataSource.commission,
          dataSource.created_by_id,
          dataSource.updated_by_id,
          dataSource.created_at,
          dataSource.updated_at,
          dataSource.deleted_by_id,
          dataSource.deleted_at,
          LuggageType(dataSource.luggage_type?.id,dataSource.luggage_type?.name),
          CreatedBy(dataSource.created_by?.id,dataSource.created_by?.first_name,dataSource.created_by?.last_name,dataSource.created_by?.email,dataSource.created_by?.phone,
              dataSource.created_by?.country ,dataSource.created_by?.is_traveller,dataSource.created_by?.is_verified,dataSource.created_by?.stripe_id,
              dataSource.created_by?.pm_type ,dataSource.created_by?.pm_last_four,
              ProfilePicture(dataSource.created_by?.profile_picture?.id , dataSource.created_by?.profile_picture?.document_type_id,dataSource.created_by?.profile_picture?.user_id,
                  dataSource.created_by?.profile_picture?.name,dataSource.created_by?.profile_picture?.file_name,dataSource.created_by?.profile_picture?.file_path,dataSource.created_by?.profile_picture?.file_preview_path)),
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: AppDecoration.outlineBlack9006.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(dataSource.start_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.start_time == null ? "01:25:00" : dataSource.start_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_from ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Text(
                          "$daysDifference d$hoursDifference h$minutesDifference m",
                          style: CustomTextStyles.bodyMediumBluegray40001,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Divider(),
                        ),
                        SizedBox(height: 9),
                        Text(
                          "1 stop",
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        formatDate(dataSource.end_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.end_time == null ? "01:25:00" : dataSource.end_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_to ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* CustomImageView(
                  imagePath: ImageConstant.imgEllipse1226x26,
                  height: 26,
                  width: 26,
                  radius: BorderRadius.circular(
                    13,
                  ),
                ),*/
                _buildAvatar("${dataSource.created_by?.first_name}","${dataSource.created_by?.last_name}"),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    "${dataSource.created_by?.first_name} " " ${dataSource.created_by?.last_name}",
                    style: CustomTextStyles.titleSmallBlack900Medium_2,
                  ),
                ),
                Spacer(),
                CustomOutlinedButton(
                  height: 21,
                  width: 84,
                  text: "4.8",
                  margin: EdgeInsets.symmetric(vertical: 3),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  buttonTextStyle: CustomTextStyles.titleMediumBlack900_2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: appTheme.gray20002,
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text(
                            "Commission:",
                            style: CustomTextStyles.labelLargeGray80002,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            "${dataSource.commission.toString()}%",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 137,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              "Available Space:",
                              style: CustomTextStyles.labelLargeGray80002,
                            ),
                          ),
                          Text(
                            " ${dataSource.luggage_space}KG",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomOutlinedButton(
                  onPressed: (){
                    CustomLoader.showLoader(context);
                    getSingleUserById(dataSource.created_by?.email ?? "").then((user) async {
                      if (user!.id.isNotEmpty) {
                        final room = await FirebaseChatCore.instance.createRoom(user);
                        CustomLoader.hideLoader(context);
                        locator<NavigationService>().navigateTo(Routes.chatView,
                            arguments: ChatViewArguments(room:room));
                      } else {
                        CustomLoader.hideLoader(context);
                        CustomDialog.showSuccessDialog(context,message:  "Oops Error Occured , Try Again Later" , onPressedDialog: (){
                          Navigator.pop(context);
                        });
                        print("User with ID  not found");
                      }
                    });
                  },
                  width: 83,
                  text: "CHAT",
                  margin: EdgeInsets.only(
                    top: 6,
                    bottom: 5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
          ],
        ),
      )
      /*Container(
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
                    imagePath: homeViewModel.imageList[index % homeViewModel.imageList.length])),
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
          ]))*/,
    );
  }

  FutureBuilder<tripModel.TripHistoryModel> getPastTrips(CustomerTripHistoryViewModel viewModel , int userID){
    return FutureBuilder(
        future: viewModel.getRecentTrips(userID,null,null,null,null,null,null,UserDataHolder.getInstance().userCurrentStatus),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return buildPastTripListView(viewModel, context, snapshot.data?.data ?? []);

            return Text("data");
          }else if(snapshot.hasError){
            return Center(child: (Text(snapshot.error.toString())));
          } else {
            return showShimmer(context);

          }
        });
  }

  Widget buildPastTripListView(CustomerTripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return tripPastlistItem(viewModel, data[index] , context , index);
        }
    ) :   const Text(
        'No Trip found',
        style: TextStyle(fontSize: 24));
  }

  Widget tripPastlistItem(CustomerTripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
    String startDateTimeString = "${dataSource.start_date} ${dataSource.start_time == null ? "01:25:00" : dataSource.start_time}";
    DateFormat sFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime startDateTime = sFormatter.parse(startDateTimeString);

    String endDateTimeString = "${dataSource.end_date} ${dataSource.end_time  == null ? "04:25:00" : dataSource.end_time}";
    DateFormat eFormatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime endDateTime = eFormatter.parse(endDateTimeString);

    Duration difference = endDateTime.difference(startDateTime);

    int daysDifference = difference.inDays;
    int hoursDifference = difference.inHours % 24; // Get hours excluding whole days
    int minutesDifference = difference.inMinutes % 60; // Get minutes excluding whole hours

    print("Difference: $daysDifference days, $hoursDifference hours, $minutesDifference minutes");


    return GestureDetector(
      onTap: () async{
        locator<NavigationService>().navigateTo(Routes.customerTripDetailView,arguments:
        CustomerTripDetailViewArguments(customerTripDetailModel:  CustomerTripDetailModel(
          dataSource.id,
          dataSource.luggage_type_id,
          dataSource.travelling_from,
          dataSource.travelling_to,
          dataSource.start_date,
          dataSource.end_date,
          dataSource.start_time,
          dataSource.end_time,
          dataSource.luggage_space,
          dataSource.commission,
          dataSource.created_by_id,
          dataSource.updated_by_id,
          dataSource.created_at,
          dataSource.updated_at,
          dataSource.deleted_by_id,
          dataSource.deleted_at,
          LuggageType(dataSource.luggage_type?.id,dataSource.luggage_type?.name),
          CreatedBy(dataSource.created_by?.id,dataSource.created_by?.first_name,dataSource.created_by?.last_name,dataSource.created_by?.email,dataSource.created_by?.phone,
              dataSource.created_by?.country ,dataSource.created_by?.is_traveller,dataSource.created_by?.is_verified,dataSource.created_by?.stripe_id,
              dataSource.created_by?.pm_type ,dataSource.created_by?.pm_last_four,
              ProfilePicture(dataSource.created_by?.profile_picture?.id , dataSource.created_by?.profile_picture?.document_type_id,dataSource.created_by?.profile_picture?.user_id,
                  dataSource.created_by?.profile_picture?.name,dataSource.created_by?.profile_picture?.file_name,dataSource.created_by?.profile_picture?.file_path,dataSource.created_by?.profile_picture?.file_preview_path)),
        )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: AppDecoration.outlineBlack9006.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(dataSource.start_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.start_time == null ? "01:25:00" : dataSource.start_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_from ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Text(
                          "$daysDifference d$hoursDifference h$minutesDifference m",
                          style: CustomTextStyles.bodyMediumBluegray40001,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Divider(),
                        ),
                        SizedBox(height: 9),
                        Text(
                          "1 stop",
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        formatDate(dataSource.end_date ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      Text(
                        formatTime(dataSource.end_time == null ? "01:25:00" : dataSource.end_time ?? ""),
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        dataSource.travelling_to ?? "",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* CustomImageView(
                  imagePath: ImageConstant.imgEllipse1226x26,
                  height: 26,
                  width: 26,
                  radius: BorderRadius.circular(
                    13,
                  ),
                ),*/
                _buildAvatar("${dataSource.created_by?.first_name}","${dataSource.created_by?.last_name}"),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    "${dataSource.created_by?.first_name} " " ${dataSource.created_by?.last_name}",
                    style: CustomTextStyles.titleSmallBlack900Medium_2,
                  ),
                ),
                Spacer(),
                CustomOutlinedButton(
                  height: 21,
                  width: 84,
                  text: "4.8",
                  margin: EdgeInsets.symmetric(vertical: 3),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 10,
                      width: 10,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  buttonTextStyle: CustomTextStyles.titleMediumBlack900_2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: appTheme.gray20002,
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text(
                            "Commission:",
                            style: CustomTextStyles.labelLargeGray80002,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            "${dataSource.commission.toString()}%",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 137,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              "Available Space:",
                              style: CustomTextStyles.labelLargeGray80002,
                            ),
                          ),
                          Text(
                            " ${dataSource.luggage_space}KG",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomOutlinedButton(
                  onPressed: (){
                    CustomLoader.showLoader(context);
                    getSingleUserById(dataSource.created_by?.email ?? "").then((user) async {
                      if (user!.id.isNotEmpty) {
                        final room = await FirebaseChatCore.instance.createRoom(user);
                        CustomLoader.hideLoader(context);
                        locator<NavigationService>().navigateTo(Routes.chatView,
                            arguments: ChatViewArguments(room:room));
                      } else {
                        CustomLoader.hideLoader(context);
                        CustomDialog.showSuccessDialog(context,message:  "Oops Error Occured , Try Again Later" , onPressedDialog: (){
                          Navigator.pop(context);
                        });
                        print("User with ID  not found");
                      }
                    });
                  },
                  width: 83,
                  text: "CHAT",
                  margin: EdgeInsets.only(
                    top: 6,
                    bottom: 5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
          ],
        ),
      )
      /*Container(
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
                    imagePath: homeViewModel.imageList[index % homeViewModel.imageList.length])),
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
          ]))*/,
    );
  }

  String formatDate(String dateStr) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final formattedDate = DateFormat("dd MMM, yyyy").format(dateFormat.parse(dateStr));
    //final formattedDate = DateFormat('yyyy/MM/dd hh:mm:ss a').format(dateFormat.parse(dateStr));
    return formattedDate;
  }

  String formatTime(String dateStr) {
    final dateFormat = DateFormat("hh:mm:ss");
    //final dateFormat = DateFormat("yyyy-MM-dd");
    final formattedDate = DateFormat('hh:mm:ss a').format(dateFormat.parse(dateStr));
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

}