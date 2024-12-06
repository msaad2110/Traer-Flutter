


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/customer/customer_orderhistory/customer_all_orders_viewmodel.dart';
import 'package:traer/ui/customer/customer_orderhistory/customer_orderhistory_viewmodel.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/models/order_history_model.dart' as orderModel;
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:traer/widgets/custom_search_view.dart';

class CustomerOrderHistoryView extends StatefulWidget{


  @override
  State<CustomerOrderHistoryView> createState() => CustomerOrderHistoryViewState();

}

class CustomerOrderHistoryViewState extends State<CustomerOrderHistoryView> with TickerProviderStateMixin{

  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);

  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerOrderHistoryViewModel>.reactive(
      viewModelBuilder: () => CustomerOrderHistoryViewModel(),
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



class AllOrdersScreen extends StackedView<CustomerAllOrdersViewModel>{


  @override
  Widget builder(BuildContext context, CustomerAllOrdersViewModel viewModel, Widget? child) {
    return LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: Column(
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
      ),
    );
  }

  FutureBuilder<orderModel.OrderHistoryModel> getAllOrders(CustomerAllOrdersViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getAllOrders(UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0 , UserDataHolder.getInstance().userCurrentStatus ?? 0),
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


  Widget buildAllOrderListView(CustomerAllOrdersViewModel viewModel , BuildContext context , List<orderModel.Data> data){
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


  Widget orderlistItem(CustomerAllOrdersViewModel homeViewModel , orderModel.Data dataSource , BuildContext context){
    double result = (double.parse(dataSource.trip?.commission.toString() ?? "")  / 100.0) * (double.parse(dataSource.product_value.toString()));


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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomOutlinedButton(
                    width: 100,
                    text: "ACTIVE",
                    buttonStyle: CustomButtonStyles.outlineYellow,
                    buttonTextStyle: CustomTextStyles.labelLargeYellow80001,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "N-${dataSource.id}",
                      style: CustomTextStyles.bodyMediumBlack900_1,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dataSource.description ?? "",
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgFrame68Gray900,
                    height: 30,
                    width: 4,
                    margin: EdgeInsets.only(
                      top: 4,
                      bottom: 5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataSource.trip!.travelling_from ?? "",
                          style: CustomTextStyles.bodyMediumBlack900_1,
                        ),
                        SizedBox(height: 6),
                        Text(
                          dataSource.trip!.travelling_to ?? "",
                          style: CustomTextStyles.bodyMediumBlack900_1,
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomImageView(
                    imagePath: ImageConstant.imgRefresh,
                    height: 8,
                    width: 22,
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 16,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5,
                      top: 8,
                      bottom: 5,
                    ),
                    child: Text(
                      result.toString() ?? "",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // CustomImageView(
                  //   imagePath: ImageConstant.imgEllipse15,
                  //   height: 30,
                  //   width: 30,
                  //   radius: BorderRadius.circular(
                  //     15,
                  //   ),
                  // ),
                  _buildAvatar(dataSource.created_by?.first_name ?? "", dataSource.created_by?.last_name ?? ""),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 6,
                      top: 7,
                      bottom: 7,
                    ),
                    child: Text(
                      "${dataSource.created_by?.first_name} ${dataSource.created_by?.last_name}",
                      style: CustomTextStyles.bodySmallGray700,
                    ),
                  ),
                  Spacer(),
                  CustomOutlinedButton(
                    width: 137,
                    //text: "UPDATE STATUS",
                    text: "PAYMENT",
                    onPressed: () {
                      onTapPaymentButton(context, homeViewModel, dataSource.id ?? 0);
                     //locator<NavigationService>().navigateTo(Routes.customerTrackOrderView);
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


  onTapPaymentButton(BuildContext context , CustomerAllOrdersViewModel viewModel , int orderID ) {
    if(viewModel.paymentModel == null){
      CustomDialog.showErrorDialog(context,message:"please add payment method", onPressedDialog: (){
        Navigator.pop(context);
        locator<NavigationService>().navigateTo(Routes.cardslistView);
      });
    }else{
      print(viewModel.paymentModel!.id);
      CustomLoader.showLoader(context);
      viewModel.payment(viewModel.paymentModel!.id ?? "0" , UserDataHolder.getInstance().loginData!.data!.user!.id  ?? 0 , orderID ).then((value){
        print(value);
        CustomLoader.hideLoader(context);
        if(value.success ?? false){
          CustomDialog.showSuccessDialog(context,message: value.message ?? "" , onPressedDialog: (){
            locator<NavigationService>().back();
            viewModel.notifyListeners();
          });
        }else{
          CustomDialog.showErrorDialog(context,message: value.message ?? "", onPressedDialog: (){
            Navigator.pop(context);
          });
        }
      }).catchError((onError){
        CustomLoader.hideLoader(context);
        CustomDialog.showErrorDialog(context, onPressedDialog: (){
          Navigator.pop(context);
          locator<NavigationService>().back();
          viewModel.notifyListeners();
        });
      });
    }
  
  }

  void filterOrdersSearchResults(String query , CustomerAllOrdersViewModel viewModel) {

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
  CustomerAllOrdersViewModel viewModelBuilder(BuildContext context) {
    return CustomerAllOrdersViewModel();
  }

  @override
  void onViewModelReady(CustomerAllOrdersViewModel viewModel) {
    print("636346 called");
    viewModel.getDatabase().then((value){
      print("543 called");
      viewModel.paymentDao =  value;
      value.findAll().then((onValue){
        if(onValue.length > 0){
          viewModel.paymentModel =  onValue.first;
          print("model called");
          print(onValue);
        }
      });
    });
    super.onViewModelReady(viewModel);
  }

  @override
  // TODO: implement reactive
  bool get reactive => super.reactive;

}