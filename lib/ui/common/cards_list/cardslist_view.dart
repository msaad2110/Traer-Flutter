


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localdb/payment_dao.dart';
import 'package:traer/localdb/payment_model.dart';
import 'package:traer/models/card_response.dart';
import 'package:traer/models/user_data_holder.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/cards_list/cardlist_viewmodel.dart';
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

import '../../customer/customer_trip_filter/filter_country_viewmodel.dart';

class CardslistView extends StackedView<CardlistViewmodel>{


  @override
  Widget builder(BuildContext context, CardlistViewmodel viewModel, Widget? child) {
    return mainView(context, viewModel);
  }

  @override
  CardlistViewmodel viewModelBuilder(BuildContext context) {
    return CardlistViewmodel();
  }

  @override
  void onViewModelReady(CardlistViewmodel viewModel) {
    viewModel.getDatabase().then((value){
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
  bool get reactive => super.reactive;

  @override
  void onDispose(CardlistViewmodel viewModel) {
    super.onDispose(viewModel);
  }

  @override
  bool get disposeViewModel => super.disposeViewModel;

  onTapClose() {
    locator<NavigationService>().back();
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


  Widget mainView(BuildContext context , CardlistViewmodel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){

      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Cards", onBackClicked: (){
              onTapClose();
            }),
            body:  LoaderOverlay(
              useDefaultLoading: false,
              overlayWidgetBuilder: (pro){
                return customProgessBar();
              },
              child: Column(
                children: [
                  SizedBox(height: 2),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TypeWriterText.builder(
                          "Select your  Card....",
                          duration: Duration(milliseconds: 50),
                          builder: (context , value){
                            return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                                color: theme.colorScheme.onSecondaryContainer));
                          }),
                    ),
                  ),
                  SizedBox(height: 7),
                  Expanded(child: getCards(viewModel))

                ],
              ),
            ),
              bottomNavigationBar: bottomButton("Add New Card", context, onButtonPress: () {
              locator<NavigationService>().navigateTo(Routes.addCardView);
          }),
          )

      ),

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

  FutureBuilder<CardResponse> getCards(CardlistViewmodel viewModel){
    return FutureBuilder(
        future: viewModel.getCards(UserDataHolder.getInstance().loginData!.data!.user!.id ?? 0),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            print("destination countries call");
            viewModel.filterFoundCards.value = (snapshot.data!.data! ?? []);
            viewModel.filterAllCards = (snapshot.data!.data! ?? []);
            //return buildCountryListView(viewModel, context, viewModel.foundCountries);
            return ValueListenableBuilder<List<Data>>(
                valueListenable: viewModel.filterFoundCards,
                builder: (context , snapshot,_){
                  return snapshot.isEmpty ? Container() : buildCardListView(viewModel, context, viewModel.filterFoundCards.value);
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

  Widget buildCardListView(CardlistViewmodel viewModel , BuildContext context , List<Data> data){
    print(data.length);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
          viewModel.paymentModel  = viewModel.paymentModel == null ? PaymentModel(data[0].id ?? "") : viewModel.paymentModel;
          return cardListItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget cardListItem(CardlistViewmodel homeViewModel , Data dataSource , BuildContext context){

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
      child: InkWell(

        onTap: () {

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
                        child: Row(
                          children: [
                            Text(dataSource.card!.brand!.toUpperCase() ??  "" , style: theme.textTheme.titleLarge!.copyWith(
                                color: theme.colorScheme.onPrimaryContainer),),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,top: 5.0,right: 10.0,bottom: 5.0),
                                  child: Text(
                                    "**** **** **** ${dataSource.card!.last4}" ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                                      color: theme.colorScheme.onSecondaryContainer),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0,top: 5.0,right: 10.0,bottom: 5.0),
                                  child: Text("${dataSource.card!.exp_month}/${dataSource.card!.exp_year}" ??  "" , style: theme.textTheme.titleMedium!.copyWith(
                                      color: theme.colorScheme.onSecondaryContainer),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Radio(
                      value: dataSource.id ?? "",
                      groupValue: homeViewModel.paymentModel!.id,
                      onChanged: (String? value) {
                        homeViewModel.paymentDao!.deleteAll();
                        homeViewModel.paymentDao!.insertData(PaymentModel(value ?? ""));
                        homeViewModel.paymentModel =  PaymentModel(value ?? "");
                        homeViewModel.notifyListeners();
                        /*setState(() {
                          _site = value;
                        });*/
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

  onTapDelete( String paymentID , int userID ,BuildContext context , CardlistViewmodel viewModel) {
    CustomLoader.showLoader(context);
    viewModel.deleteCard(paymentID,userID).then((value) async{
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