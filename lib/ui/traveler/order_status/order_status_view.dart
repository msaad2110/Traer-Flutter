

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/models/order_status.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/traveler/order_status/order_status_viewmodel.dart';
import 'package:traer/utils/colorfield.dart';
import 'package:traer/utils/dialog.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/appbar_leading_image.dart';
import 'package:traer/widgets/appbar_subtitle_three.dart';
import 'package:traer/widgets/custom_app_bar.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_loader.dart';
import 'package:traer/widgets/custom_outlined_button.dart';
import 'package:traer/widgets/custom_progressbar.dart';
import 'package:typewritertext/typewritertext.dart';

class OrderStatusView extends StackedView<OrderStatusViewModel>{

  int orderID ;


  OrderStatusView(this.orderID);

  @override
  Widget builder(BuildContext context, OrderStatusViewModel viewModel, Widget? child) {
    return SafeArea(
        child: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (pro) {
          return customProgessBar();
        },child: Scaffold(
              appBar: _buildAppBar(context, "Trip Detail", onBackClicked: () {

              }),
              body: Column(
                children: [
                  SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TypeWriterText.builder(
                          "Update Status....",
                          duration: Duration(milliseconds: 50),
                          builder: (context , value){
                            return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                                color: theme.colorScheme.onSecondaryContainer));
                          }),
                    ),
                  ),
                  SizedBox(height: 7),
                  Expanded(child: getOrderSatus(viewModel))

                ],
              ),
              bottomNavigationBar: bottomButton("Update Status", context, onButtonPress: () {
                onTapUpdateStatusButton(context, viewModel);

              })),
        ));
  }


  FutureBuilder<OrderStatusModel> getOrderSatus(OrderStatusViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getStatus("order_status"),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            viewModel.setStatus(snapshot.data!.data!.first.order_status ?? []);
            return ValueListenableBuilder<List<OrderStatus>>(
                valueListenable: viewModel.allStatus,
                builder: (context , snapshot,_){
                  print(snapshot.length);
                  return snapshot.isEmpty ? Container() : buildDestinationCountryListView(viewModel, context, viewModel.allStatus.value);
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

  Widget buildDestinationCountryListView(OrderStatusViewModel viewModel , BuildContext context , List<OrderStatus> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          return countryDestinationlistItem(viewModel, data[index] , context , index);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget countryDestinationlistItem(OrderStatusViewModel homeViewModel , OrderStatus dataSource , BuildContext context , int index){
    print("view created ");
    return InkWell(

      onTap: ()  {
          homeViewModel.allStatus.value.forEach((element) {
           element.isSelected = false;
        });
         homeViewModel.allStatus.value.elementAt(index).isSelected = true;
         homeViewModel.orderStatus = homeViewModel.allStatus.value.elementAt(index);
         List<OrderStatus> updatedList = homeViewModel.allStatus.value;
         homeViewModel.setStatus(updatedList);
         print(dataSource);
      },

      child: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: dataSource.isSelected ? appTheme.gray400  : appTheme.gray10001,
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
                      child: Text(dataSource.label ??  "" , style: theme.textTheme.titleMedium!.copyWith(
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
  OrderStatusViewModel viewModelBuilder(BuildContext context) {
    return OrderStatusViewModel();
  }

  @override
  void onViewModelReady(OrderStatusViewModel viewModel) {
    viewModel.orderID = orderID;
    super.onViewModelReady(viewModel);
  }

  @override
  void onDispose(OrderStatusViewModel viewModel) {
    super.onDispose(viewModel);
  }

  @override
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


  onTapUpdateStatusButton(BuildContext context , OrderStatusViewModel viewModel) {

    if(viewModel.orderStatus == null){
      CustomDialog.showErrorDialog(context,message: "please select status", onPressedDialog: (){
        Navigator.pop(context);
      });
    }else{
      CustomLoader.showLoader(context);
      viewModel.updateOrderStatus(viewModel.orderID,UserDataHolder.getInstance().loginData?.data?.user?.id ?? 0,viewModel.orderStatus?.value ?? 0).then((value){
        print(value);
        CustomLoader.hideLoader(context);
        if(value.success ?? false){
          CustomDialog.showSuccessDialog(context,message: value.data ?? "" , onPressedDialog: (){
            locator<NavigationService>().clearStackAndShow(Routes.mainView);
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
        });
        print("onError.toString()");
        print(onError.toString());
      });
    }


  }

}