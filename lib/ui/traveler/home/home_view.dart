
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/trip_history_model.dart' as tripModel;
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/home/home_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/utils/pref_utils.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_icon_button.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';


class HomeView extends StackedView<HomeViewModel>{

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    print("homeview rebuild");
    return SafeArea(
        child: Scaffold(
            appBar: _buildAppBar(context,viewModel),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  _buildOrderComponent(context,viewModel),
                  SizedBox(height: 12),
                 _buildFrame1(context),
                  SizedBox(height: 10),
                  _buildFrameTwentyFive(context),
                  SizedBox(height: 21),
                  Expanded(child: getRecentTrips(viewModel,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0)),
                 // _buildFrameFifteen(context),
                  SizedBox(height: 12),
                 /*_buildFrame(context,
                      parkhiText: "lbl_par_khi".tr,
                      marText: "lbl_mar_15_2023".tr),
                  SizedBox(height: 12.v),
                  _buildFrameFifteen2(context),
                  SizedBox(height: 12.v),
                  _buildFrameFifteen3(context),
                  SizedBox(height: 12.v),
                  _buildFrame(context,
                      parkhiText: "lbl_par_khi".tr,
                      marText: "lbl_mar_15_2023".tr)*/
                ]))));
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context , HomeViewModel viewModel) {
    return CustomAppBar(
        title: Padding(
            padding: EdgeInsets.only(left: 20),
            child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "lbl_welcome_back".tr,
                      style: CustomTextStyles.titleMediumBlack90018),
                  TextSpan(
                      text: '${UserDataHolder.getInstance().loginData?.data?.user?.first_name} ',
                      style: CustomTextStyles.titleMediumPrimary)
                ]),
                textAlign: TextAlign.left)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: toogleSwitch(viewModel.isSelected,viewModel),
          )
          /*Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              margin: EdgeInsets.fromLTRB(20, 15, 20, 17),
              color: theme.colorScheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusStyle.circleBorder12),
              child: Container(
                  height: 60,
                  width: 100,
                  decoration: AppDecoration.fillPrimary
                      .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
                  child: Stack(alignment: Alignment.centerRight, children: [
                   *//* Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                            height: 24,
                            width: 24,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.onErrorContainer
                                    .withOpacity(1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: theme.colorScheme.primary,
                                    width: 2)))),
                    CustomImageView(
                        imagePath: ImageConstant.imgMdiTransitCon,
                        height: 14,
                        width: 14,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.fromLTRB(25, 5, 5, 5))*//*
                    toogleSwitch(viewModel.isSelected,viewModel)
                  ])))*/
        ]);
  }

  Widget toogleSwitch(bool isSelected , HomeViewModel viewModel){
    return Switch(
      value: viewModel.isSelected,
      onChanged: (bool value) {
        viewModel.updateSlected(value);
      },
      activeColor: theme.colorScheme.primary,
      thumbColor:  MaterialStateProperty.all(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeThumbImage:  AssetImage(ImageConstant.imgMdiTransitCon,),
      inactiveThumbImage: AssetImage(ImageConstant.imgArrowLeft),
    );
  }




  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget newOder( BuildContext context){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.42,
      child: GestureDetector(
        onTap: () {
          locator<NavigationService>().navigateTo(Routes.newOrderView);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 24,
          ),
          decoration: AppDecoration.fillGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgOrders,
                height: 38,
                width: 38,
                radius: BorderRadius.circular(
                  19,
                ),
              ),
              SizedBox(height: 11),
              Text(
                "New Order",
                style: CustomTextStyles.titleMediumSemiBold_1,
              ),
            ],
          ),
        ),
      ),
    );
}

  Widget newTrip(BuildContext context , HomeViewModel viewModel ){
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.42,
      child: GestureDetector(
        onTap: () {
        //  CustomDialog.showDocumentUploadBottomSheet(context);
            locator<NavigationService>().navigateTo(Routes.newTripView);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 23,
            vertical: 24,
          ),
          decoration: AppDecoration.fillGray.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgTrips,
                height: 38,
                width: 38,
                radius: BorderRadius.circular(
                  19,
                ),
              ),
              SizedBox(height: 11),
              Text(
                "New Trip",
                style: CustomTextStyles.titleMediumSemiBold_1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderComponent(BuildContext context , HomeViewModel viewModel) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          newOder(context),
          newTrip(context , viewModel)
        ],
      ),
    );
  }

  Widget _buildFrame1(BuildContext context) {
    return InkWell(
        onTap: () {
          locator<NavigationService>().navigateTo(Routes.orderHistoryView);
        },
        child: Container(

            padding: EdgeInsets.all(5),
            decoration: AppDecoration.fillPrimary
                .copyWith(borderRadius: BorderRadiusStyle.circleBorder12),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  height: 42,
                  width: 42,
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: AppDecoration.fillOnErrorContainer
                      .copyWith(borderRadius: BorderRadiusStyle.circleBorder19),
                  child: CustomImageView(
                      imagePath: ImageConstant.imgThumbsUp,
                      height: 22,
                      width: 20,
                      alignment: Alignment.bottomLeft)),
              Padding(
                  padding: EdgeInsets.only(left: 16, top: 12, bottom: 9),
                  child: Text("msg_view_ongoing_orders".tr,
                      style: CustomTextStyles.titleMediumOnErrorContainer_1)),
              Spacer(),
              CustomImageView(
                  imagePath: ImageConstant.imgArrowRight,
                  height: 24,
                  width: 24,
                  margin: EdgeInsets.symmetric(vertical: 9))
            ])));
  }

  Widget _buildFrameTwentyFive(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Text("lbl_recent_trips".tr, style: CustomTextStyles.titleMediumBlack90018),
        CustomOutlinedButton(
            width: MediaQuery.sizeOf(context).width * 0.26,
            text: "lbl_see_all".tr,
            margin: EdgeInsets.only(bottom: 4),
            onPressed: () {
              onTapSEEALL();
            })
      ]),
    );
  }


  FutureBuilder<tripModel.TripHistoryModel> getRecentTrips(HomeViewModel viewModel , int userID){
    print("destination countries call1  mussadiq");
    print( PrefUtils().getToken(PrefUtils.token));
    print("destination countries call2");
    return FutureBuilder(
        key: Key('recent_trips_future_builder'),
        future: viewModel.getRecentTrips(userID,null,null,null,null,null,null,UserDataHolder.getInstance().userCurrentStatus),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
             return buildRecentTripListView(viewModel, context, snapshot.data?.data ?? []);

            return Text("data");
          }else if(snapshot.hasError){
            return Center(child: (Text(snapshot.error.toString())));
          } else {
            return showShimmer(context);

          }
        });
  }

  Widget buildRecentTripListView(HomeViewModel viewModel , BuildContext context , List<tripModel.Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return triplistItem(viewModel, data[index] , context , index);
        }
    ) :   const Text(
        'No Trip found',
        style: TextStyle(fontSize: 24));
  }


  Widget triplistItem(HomeViewModel homeViewModel , tripModel.Data dataSource , BuildContext context , int index) {
    return Slidable(
      key:  ValueKey(dataSource),
      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (da){
              print(dataSource.travelling_to);
          },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (da){
              print(dataSource.travelling_to);
            },
            backgroundColor: Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: (){
          locator<NavigationService>().navigateTo(Routes.tripDetailView,arguments: TripDetailViewArguments(dataSource: dataSource));
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
      ),
    );
  }

  String formatDate(String dateStr) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    final formattedDate = DateFormat("dd MMM, yyyy").format(dateFormat.parse(dateStr));
    return formattedDate;
  }
/*
  Widget triplistItem(HomeViewModel homeViewModel , tripModel.Data dataSource , BuildContext context){

    return InkWell(

      onTap: () {
        */
/*NewTripData.getInstance().destinationCountry = dataSource;
        print( NewTripData.getInstance().destinationCountry);
        homeViewModel.setCurrentIndex(2);*//*

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
                      child: Text(dataSource.travelling_from ??  "" , style: theme.textTheme.titleMedium!.copyWith(
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
*/



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

    onTapSEEALL() {
     locator<NavigationService>().navigateTo(Routes.tripHistoryView);
    }



}