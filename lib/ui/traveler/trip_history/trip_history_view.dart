


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/trip_history/trip_history_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/appbar_title_button_one.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_progressbar.dart';

class TripHistoryView extends StatefulWidget {
  const TripHistoryView({super.key});

  @override
  State<TripHistoryView> createState() => _TripHistoryViewState();
}

class _TripHistoryViewState extends State<TripHistoryView> with TickerProviderStateMixin{
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
      return ViewModelBuilder<TripHistoryViewModel>.reactive(
      viewModelBuilder: () => TripHistoryViewModel(),
      onViewModelReady: (model) {},
      builder: (context, model, child) => SafeArea(
        child: PopScope(
          canPop: true,
          onPopInvoked: (val){
            //onTapClose(context);
          },
          child: SafeArea(
            child: Scaffold(
              appBar: _buildAppBar(context),
              body: LoaderOverlay(
                useDefaultLoading: false,
                overlayWidgetBuilder: (pro){
                  return customProgessBar();
                },
                child: SizedBox(
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

    Widget allTripsView(TripHistoryViewModel viewModel){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: getAllTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
    );

  }

    Widget allScheduledView(TripHistoryViewModel viewModel){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: getScheduledTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
      );

    }

    Widget allPastView(TripHistoryViewModel viewModel){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: getPastTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
      );

    }

    FutureBuilder<tripModel.TripHistoryModel> getAllTrips(TripHistoryViewModel viewModel , int userID){
      return FutureBuilder(
          future: viewModel.getRecentTrips(userID,null,null,null,null,null,null,UserDataHolder.getInstance().userCurrentStatus),
          builder: (context , snapshot){
            if (snapshot.hasData) {
              print("destination countries call");
              //return buildCountryListView(viewModel, context, viewModel.foundCountries);
              return buildAllTripListView(viewModel, context, snapshot.data?.data ?? []);

              return Text("data");
            }else if(snapshot.hasError){
              return Center(child: (Text(snapshot.error.toString())));
            } else {
              return showShimmer(context);

            }
          });
    }

    Widget buildAllTripListView(TripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
      print(data.length);
      return data.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
            return tripAlllistItem(viewModel, data[index] , context , index);
          }
      ) :   Center(
        child: Center(
          child: const Text(
              'No Trip found',
              style: TextStyle(fontSize: 24)),
        ),
      );
    }

    Widget tripAlllistItem(TripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
      return Slidable(
        key:  ValueKey(dataSource),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (da){
                onTapDelete(dataSource.id!, UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0, context, homeViewModel);
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: (){},
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
        ),
      );
    }

    FutureBuilder<tripModel.TripHistoryModel> getScheduledTrips(TripHistoryViewModel viewModel , int userID){
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

    Widget buildScheduledTripListView(TripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
      print(data.length);
      return data.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
            return tripScheduledlistItem(viewModel, data[index] , context , index);
          }
      ) :   Center(
        child: const Text(
            'No Trip found',
            style: TextStyle(fontSize: 24)),
      );
    }

    Widget tripScheduledlistItem(TripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
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

    FutureBuilder<tripModel.TripHistoryModel> getPastTrips(TripHistoryViewModel viewModel , int userID){
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

    Widget buildPastTripListView(TripHistoryViewModel viewModel , BuildContext context , List<tripModel.Data> data){
      print(data.length);
      return data.isNotEmpty ? ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context , index){
            return tripPastlistItem(viewModel, data[index] , context , index);
          }
      ) :   Center(
        child: const Text(
            'No Trip found',
            style: TextStyle(fontSize: 24)),
      );
    }

    Widget tripPastlistItem(TripHistoryViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
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

    onTapDelete( int tripID , int userID ,BuildContext context , TripHistoryViewModel viewModel) {
      CustomLoader.showLoader(context);
      viewModel.deleteTrip(tripID,userID).then((value) async{
        CustomLoader.hideLoader(context);

        if(value.success ?? false){
          viewModel.notifyListeners();
        }else{
          CustomDialog.showErrorDialog(context,message: value.message ?? "" , onPressedDialog: (){
            Navigator.pop(context);
          });
        }
        print("value");
      }).catchError((onError){
        print(onError.toString());
        CustomLoader.hideLoader(context);
        CustomDialog.showErrorDialog(context, onPressedDialog: (){
          Navigator.pop(context);
        });
        print(onError.toString());
      });
      // locator<NavigationService>().navigateTo(Routes.splashView);
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


/*
class TripHistoryView extends StackedView<TripHistoryViewModel> {



  @override
  Widget builder(BuildContext context, TripHistoryViewModel viewModel,
      Widget? child) {

    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: double.maxFinite,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 9),
                      Container(
                          height: 32,
                          width: 237,
                          margin: EdgeInsets.only(left: 20),
                          child: TabBar(
                              onTap: viewModel.onTabTapped,
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
                                Tab(child: Text("All")),
                                Tab(child: Text("Scheduled")),
                                Tab(child: Text("Past"))
                              ])),
                      SizedBox(
                          height: 562,
                          child: TabBarView(
                              children: [
                                */
/*TravelerAllTripsPage(),
                                TravelerAllTripsPage(),
                                TravelerAllTripsPage()*//*

                              ]))
                    ]))));
  }

  @override
  TripHistoryViewModel viewModelBuilder(BuildContext context) {

    return TripHistoryViewModel();
  }

  @override
  void onViewModelReady(TripHistoryViewModel viewModel) {
    // TODO: implement onViewModelReady
    // viewModel.initializeTabController();
    super.onViewModelReady(viewModel);
  }


  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

  @override
  void onDispose(TripHistoryViewModel viewModel) {
    // TODO: implement onDispose
    super.onDispose(viewModel);
  }


  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        title: AppbarTitleButtonOne(
            margin: EdgeInsets.only(left: 20),
            onTap: () {
              onTapRecentTrips(context);
            }));
  }

  onTapRecentTrips(BuildContext context) {
    //Navigator.pushNamed(context, AppRoutes.travelerHomepageContainerScreen);
  }



}*/
