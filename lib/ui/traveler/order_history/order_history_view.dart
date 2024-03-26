



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/order_history/all_orders_viewmodel.dart';
import 'package:traer/ui/traveler/order_history/order_history_viewmodel.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_search_view.dart';
import 'package:traer/models/order_history_model.dart' as orderModel;

class  OrderHistoryView  extends StatefulWidget {

  @override
  State<OrderHistoryView> createState() => OrderHistoryViewState();

}

class OrderHistoryViewState extends State<OrderHistoryView> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderHistoryViewModel>.reactive(
      viewModelBuilder: () => OrderHistoryViewModel(),
      onViewModelReady: (model) {},
      builder: (context, model, child) => SafeArea(
        child: PopScope(
          canPop: true,
          onPopInvoked: (value){
            print(value);
          //  onTapClose();
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
                        margin: EdgeInsets.only(left: 20,right: 10,bottom: 10),
                        child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            controller:  tabController,
                            dividerColor: Colors.transparent,
                           // onTap: model.onTabTapped,
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
                                child: Text("lbl_all".tr),
                              )),
                              Tab(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("lbl_active2".tr),
                              )),
                              Tab(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("lbl_completed2".tr),
                              ))
                            ])),
                    Expanded(
                      child: SizedBox(
                        child: TabBarView(
                          controller: tabController, // Access model's TabController
                          children: [
                            AllOrdersScreen(),
                            AllOrdersScreen(),
                            AllOrdersScreen(),
                            /*allTripsView(model),
                            allScheduledView(model),
                            allPastView(model),*/
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
              onTapClose();
            }),
        title: AppbarSubtitleThree(
            text: "lbl_orders".tr,
            margin: EdgeInsets.only(left: 14)));
  }

}

 onTapClose() {
  locator<NavigationService>().back();
}



class AllOrdersScreen extends StackedView<AllOrdersViewModel>{


  @override
  Widget builder(BuildContext context, AllOrdersViewModel viewModel, Widget? child) {
    return Column(
      children: [
        SizedBox(height: 2),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CustomSearchView(
              controller: viewModel.allOrdersSearchController,
              onChanged: (v){
                filterOrdersSearchResults(v.trim(),viewModel);
              },
              hintText: "lbl_search".tr,

              alignment: Alignment.center,
            ),
          ),
        ),
        SizedBox(height: 7),
        Expanded(child: getAllOrders(viewModel))

      ],
    );
  }

  FutureBuilder<orderModel.OrderHistoryModel> getAllOrders(AllOrdersViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getAllOrders(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            viewModel.allFoundOrders.value = (snapshot.data!.data ?? []);
            viewModel.allOrdersList = (snapshot.data!.data ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<orderModel.Data>>(
                valueListenable: viewModel.allFoundOrders,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildAllOrderListView(viewModel, context, viewModel.allFoundOrders.value);
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


  Widget buildAllOrderListView(AllOrdersViewModel viewModel , BuildContext context , List<orderModel.Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return orderlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
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
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "",
            style: CustomTextStyles.bodyMediumBlack900_1,
          ),
          SizedBox(height: 9),
          Text(
            "",
            style: CustomTextStyles.titleMediumBlack900_3,
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFrame68,
                height: 30,
                width: 4,
                margin: EdgeInsets.only(
                  top: 4,
                  bottom: 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      style: CustomTextStyles.bodyMediumBlack900_1,
                    ),
                    SizedBox(height: 6),
                    Text(
                       "",
                      style: CustomTextStyles.bodyMediumBlack900_1,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomOutlinedButton(
                width: 137,
                text: "lbl_update_status".tr,
                margin: EdgeInsets.only(
                  top: 6,
                  bottom: 8,
                ),
                onPressed: () {
                  // onTapUpdateStatusButton!.call();
                },
              ),
            ],
          ),
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

  Widget orderlistItem(AllOrdersViewModel homeViewModel , orderModel.Data dataSource , BuildContext context){

    return InkWell(
      onTap: () {
      },
      child: Wrap(
        children: [Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: AppDecoration.fillGray10001.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "N- "+dataSource.id.toString(),
            style: CustomTextStyles.bodyMediumBlack900_1,
          ),
          SizedBox(height: 9),
          Text(
            dataSource.description!,
            style: CustomTextStyles.titleMediumBlack900_3,
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgFrame68,
                height: 30,
                width: 4,
                margin: EdgeInsets.only(
                  top: 4,
                  bottom: 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dataSource.trip?.travelling_from ?? "",
                      style: CustomTextStyles.bodyMediumBlack900_1,
                    ),
                    SizedBox(height: 6),
                    Text(
                      dataSource.trip?.travelling_to ?? "",
                      style: CustomTextStyles.bodyMediumBlack900_1,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomOutlinedButton(
                width: 137,
                text: "lbl_update_status".tr,
                margin: EdgeInsets.only(
                  top: 6,
                  bottom: 8,
                ),
                onPressed: () {
                 // onTapUpdateStatusButton!.call();
                },
              ),
            ],
          ),
        ],
      ),
    )
        ],
      ),
    );

  }



  void filterOrdersSearchResults(String query , AllOrdersViewModel viewModel) {

    List<orderModel.Data> searchList = [];

    if(query.isEmpty){
      searchList = viewModel.allOrdersList;
    }else{
      for(orderModel.Data order in viewModel.allOrdersList){
        if(order.id!.toString().contains(query.toLowerCase())){
          searchList.add(order);
        }
      }
    }

    viewModel.setOrders(searchList);


  }

  @override
  AllOrdersViewModel viewModelBuilder(BuildContext context) {
    return AllOrdersViewModel();
  }

  @override
  void onViewModelReady(AllOrdersViewModel viewModel) {
    // TODO: implement onViewModelReady
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}
