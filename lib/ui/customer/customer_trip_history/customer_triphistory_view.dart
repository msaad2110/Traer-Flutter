


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/filter_model.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_trip_filter/customer_trip_filter_view.dart';
import 'package:traer/ui/customer/customer_trip_history/customer_triphistory_viewmodel.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_search_view.dart';

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
           FilterModel.getInstance().commissionStart,FilterModel.getInstance().commissionEnd),
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
    return GestureDetector(
      onTap: () async{
      },
      child: Container(
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
          ])),
    );
  }

  FutureBuilder<tripModel.TripHistoryModel> getScheduledTrips(CustomerTripHistoryViewModel viewModel , int userID){
    return FutureBuilder(
        future: viewModel.getRecentTrips(userID,null,null,null,null,null,null),
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
        ]));
  }

  FutureBuilder<tripModel.TripHistoryModel> getPastTrips(CustomerTripHistoryViewModel viewModel , int userID){
    return FutureBuilder(
        future: viewModel.getRecentTrips(userID,null,null,null,null,null,null),
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
        ]));
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

}