


import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:face_camera/face_camera.dart';
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
import 'package:traer/models/documents.dart';
import 'package:traer/models/upload_document.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/ui/common/uploaddocument/selfie_picker_viewmodel.dart';
import 'package:traer/ui/common/uploaddocument/upload_document_viewmodel.dart';
import 'package:traer/ui/common/uploaddocument/upload_id_back_viewmodel.dart';
import 'package:traer/ui/common/uploaddocument/upload_id_front_viewmodel.dart';
import 'package:traer/ui/common/uploaddocument/upload_selfie_viewmodel.dart';
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
import 'package:traer/widgets/custom_search_view.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:traer/models/document_types.dart' as documentType;

class UploadDocumentView extends StackedView<UploadDocumentViewModel>{


  @override
  Widget builder(BuildContext context, UploadDocumentViewModel viewModel, Widget? child) {
    return mainView(context, viewModel);
  }

  @override
  UploadDocumentViewModel viewModelBuilder(BuildContext context) {
    return UploadDocumentViewModel();
  }

  @override
  void onViewModelReady(UploadDocumentViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  @override
  void onDispose(UploadDocumentViewModel viewModel) {
    super.onDispose(viewModel);
  }


  Widget mainView(BuildContext context , UploadDocumentViewModel viewModel){
    return PageView.builder(
      controller: viewModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5, // Number of screens
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return documentSelectionSecreen(context, viewModel);
          case 1:
            return UploadFrontDocumentView(viewModel);
          case 2:
            return UploadBackDocumentView(viewModel);
          case 3:
            return UploadSelfieView(viewModel);
          case 4:
            return SelfiePickerView(viewModel);
          default:
            return Container(); // Handle unexpected indices
        }
      },
    );
  }

  Widget documentSelectionSecreen(BuildContext context , UploadDocumentViewModel viewModel) {

    return  PopScope(
      canPop: true,
      onPopInvoked: (value){

        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Identification required", onBackClicked: (){
              print("object");
              onTapClose(context);
            }),
            body:  Column(
              children: [
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TypeWriterText.builder(
                        "Quick and easy! Upload just one ID document to get going.",
                        duration: Duration(milliseconds: 50),
                        builder: (context , value){
                          return Text(value,style: theme.textTheme.titleLarge!.copyWith(
                              color: theme.colorScheme.onSecondaryContainer));
                        }),
                  ),
                ),
                SizedBox(height: 7),
                Expanded(child: getDestinationCountries(viewModel))

              ],
            ),
          )),
    );

  }

  onTapClose(BuildContext context) {
    locator<NavigationService>().clearStackAndShow(Routes.mainView);
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

  FutureBuilder<documentType.DocumentType> getDestinationCountries(UploadDocumentViewModel viewModel){
    return FutureBuilder(
        future: viewModel.getDocumentTypes(),
        builder: (context , snapshot){
          if (snapshot.hasData) {
            viewModel.allDocuments = (snapshot.data?.data ?? []);
            return   buildDocumentListView(viewModel, context, viewModel.allDocuments);
          }else if(snapshot.hasError){
            return(Text(snapshot.error.toString()));
          } else {
            return showShimmer(context);

          }
        });
  }

  Widget buildDocumentListView(UploadDocumentViewModel viewModel , BuildContext context , List<documentType.Data> data){
    print(data.length);
    data.removeWhere((element) => element.id == 1);
    data.removeWhere((element) => element.id == 5);
    return data.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context , index){
            return documentlistItem(viewModel, data[index] , context);
        }
    ) :   const Text(
        'No results found',
        style: TextStyle(fontSize: 24));
  }

  Widget documentlistItem(UploadDocumentViewModel homeViewModel , documentType.Data dataSource , BuildContext context){

    return InkWell(
      onTap: () {
        if(UploadDocument.getInstance().documentType != null){
          if(UploadDocument.getInstance().documentType != dataSource.id){
            UploadDocument.getInstance().documents.clear();
          }

        }
        UploadDocument.getInstance().documentName = dataSource.name;
        UploadDocument.getInstance().documentType = dataSource.id;
        homeViewModel.setCurrentIndex(1);
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
                      child: Text(dataSource.name ??  "" , style: theme.textTheme.titleMedium!.copyWith(
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


class UploadFrontDocumentView extends StackedView<UploadIDFrontViewModel>{
  UploadDocumentViewModel parentViewModel;

  UploadFrontDocumentView(this.parentViewModel);

  @override
  Widget builder(BuildContext context, UploadIDFrontViewModel viewModel, Widget? child) {
    return nicView(context,viewModel);
  }



  @override
  UploadIDFrontViewModel viewModelBuilder(BuildContext context) {
    return UploadIDFrontViewModel();
  }

  @override
  void onViewModelReady(UploadIDFrontViewModel viewModel) {
    viewModel.initPlatformState();
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;

  Widget nicView(BuildContext context , UploadIDFrontViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(0);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,parentViewModel.getTitle(UploadDocument().documentType ?? 0).$1, onBackClicked: (){
              print("object");
              parentViewModel.setCurrentIndex(0);
            }),
            body:  Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 33),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                            onPressed(viewModel);
                        },
                        child: ValueListenableBuilder<File?>(
                          valueListenable: viewModel.image,
                          builder: (context , snapshot , _){
                            print("UploadDocument.getInstance().documents != null");
                            print(UploadDocument.getInstance().documents?.length);
                               if (UploadDocument.getInstance().documents.length!=0) {
                              return CustomImageView(
                                imagePath: UploadDocument.getInstance().documents[0].uri.path,
                                height: 200,
                                width: MediaQuery.sizeOf(context).width * 0.8,fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ); // Display the image if it's available
                            } else {
                              return CustomImageView(
                                  imagePath: ImageConstant.imgFront,
                                  height: 200,
                                  width: MediaQuery.sizeOf(context).width * 0.6,fit: BoxFit.fill,
                                  alignment: Alignment.center); // Show a placeholder if no image is set
                            }

                         /*   if (snapshot != null) {
                              return CustomImageView(
                                imagePath: snapshot.uri.path,
                                height: 200,
                                width: MediaQuery.sizeOf(context).width * 0.8,fit: BoxFit.fill,
                                alignment: Alignment.center,
                              ); // Display the image if it's available
                            } else {
                              return CustomImageView(
                                  imagePath: ImageConstant.imgVector,
                                  height: 200
                                  , width: MediaQuery.sizeOf(context).width * 0.8,fit: BoxFit.fill,
                                  alignment: Alignment.center); // Show a placeholder if no image is set
                            }*/
                          },
                        ),
                      ),
                      SizedBox(height: 46),
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: parentViewModel.getBodyText(UploadDocument.getInstance().documentType ?? 0).$1.tr,
                                    style: CustomTextStyles.titleMedium18),
                                TextSpan(
                                    text: "msg_entire_id_in_your".tr,
                                    style: CustomTextStyles.titleMediumBold)
                              ]),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 36),

                      Center(
                        child: Container(
                          width: 200,
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    CustomImageView(
                                        imagePath:
                                        ImageConstant.imgMaterialSymbolsNoFlash,
                                        height: 24,
                                        width: 24),
                                    Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text("lbl_no_flash".tr,
                                            style:
                                            CustomTextStyles.titleMediumSemiBold_1))
                                  ]),
                              SizedBox(height: 23),
                              Row(children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgBrightness,
                                    height: 22,
                                    width: 22),
                                Padding(
                                    padding: EdgeInsets.only(left: 16, top: 2),
                                    child: Text(("msg_use_a_light_room".tr+""),
                                        style:
                                        CustomTextStyles.titleMediumSemiBold_1))
                              ]),
                              SizedBox(height: 22),
                              Row(
                                  children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgMaterialSymbol,
                                        height: 24,
                                        width: 24),
                                    Padding(
                                        padding:
                                        EdgeInsets.only(left: 16, top: 2),
                                        child: Text("msg_hold_the_camera".tr,
                                            style: CustomTextStyles
                                                .titleMediumSemiBold_1))
                                  ])

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 5)
                    ])),
            bottomNavigationBar: bottomButton("Continue", context, onButtonPress: () {


              if(UploadDocument.getInstance().documents.length > 0){

                if(UploadDocument.getInstance().documentType==4){
                  parentViewModel.setCurrentIndex(3);
                }else{
                  parentViewModel.setCurrentIndex(2);
                }

              }else{
                CustomDialog.showErrorDialog(context,message:
                    "Please Upload Document", onPressedDialog: (){
                  Navigator.pop(context);
                });
              }


            }),
          )),
    );

  }

  void onPressed(UploadIDFrontViewModel viewModel) async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
       print(pictures.first);
       var file = File(pictures.first);
       UploadDocument.getInstance().documents.insert(0, file);
       print(UploadDocument.getInstance().documents.length);
       viewModel.image.value = file;


    } catch (exception) {
      print(exception.toString());
      // Handle exception here
    }
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


class UploadBackDocumentView extends StackedView<UploadIDBackViewModel>{
  UploadDocumentViewModel parentViewModel;

  UploadBackDocumentView(this.parentViewModel);

  @override
  Widget builder(BuildContext context, UploadIDBackViewModel viewModel, Widget? child) {
    return nicView(context,viewModel);
  }



  @override
  UploadIDBackViewModel viewModelBuilder(BuildContext context) {
    return UploadIDBackViewModel();
  }

  @override
  void onViewModelReady(UploadIDBackViewModel viewModel) {
    viewModel.initPlatformState();
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget nicView(BuildContext context , UploadIDBackViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(1);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,parentViewModel.getTitle(UploadDocument().documentType ?? 0).$2, onBackClicked: (){
              print("object");
              parentViewModel.setCurrentIndex(1);
            }),
            body:  Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 33),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          onPressed(viewModel);
                        },
                        child: ValueListenableBuilder<File?>(
                          valueListenable: viewModel.image,
                          builder: (context , snapshot , _){
                              if (UploadDocument.getInstance().documents.length>1) {
                                return CustomImageView(
                                  imagePath: UploadDocument.getInstance().documents[1].uri.path,
                                  height: 200,
                                  width: MediaQuery.sizeOf(context).width * 0.8,fit: BoxFit.fill,
                                  alignment: Alignment.center,
                                ); // Display the image if it's available
                              } else {
                                return CustomImageView(
                                    imagePath: ImageConstant.imgBack,
                                    height: 200
                                    , width: MediaQuery.sizeOf(context).width * 0.6,fit: BoxFit.fill,
                                    alignment: Alignment.center); // Show a placeholder if no image is set
                              }
                          },
                        ),
                      ),
                      SizedBox(height: 46),
                      SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: parentViewModel.getBodyText(UploadDocument.getInstance().documentType ?? 0).$2.tr,
                                    style: CustomTextStyles.titleMedium18),
                                TextSpan(
                                    text: "msg_entire_id_in_your".tr,
                                    style: CustomTextStyles.titleMediumBold)
                              ]),
                              textAlign: TextAlign.center)),
                      SizedBox(height: 36),

                      Center(
                        child: Container(
                          width: 200,
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    CustomImageView(
                                        imagePath:
                                        ImageConstant.imgMaterialSymbolsNoFlash,
                                        height: 24,
                                        width: 24),
                                    Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text("lbl_no_flash".tr,
                                            style:
                                            CustomTextStyles.titleMediumSemiBold_1))
                                  ]),
                              SizedBox(height: 23),
                              Row(children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgBrightness,
                                    height: 22,
                                    width: 22),
                                Padding(
                                    padding: EdgeInsets.only(left: 16, top: 2),
                                    child: Text(("msg_use_a_light_room".tr+""),
                                        style:
                                        CustomTextStyles.titleMediumSemiBold_1))
                              ]),
                              SizedBox(height: 22),
                              Row(
                                  children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgMaterialSymbol,
                                        height: 24,
                                        width: 24),
                                    Padding(
                                        padding:
                                        EdgeInsets.only(left: 16, top: 2),
                                        child: Text("msg_hold_the_camera".tr,
                                            style: CustomTextStyles
                                                .titleMediumSemiBold_1))
                                  ])

                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 5)
                    ])),
            bottomNavigationBar: bottomButton("Continue", context, onButtonPress: () {
              if(UploadDocument.getInstance().documents.length > 1){
                parentViewModel.setCurrentIndex(3);
              }else{
                CustomDialog.showErrorDialog(context,message:
                "Please Upload Document", onPressedDialog: (){
                  Navigator.pop(context);
                });
              }
            }),
          )),
    );

  }

  void onPressed(UploadIDBackViewModel viewModel) async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      /*if (!mounted) return;*/
      //  setState(() {
      //_pictures = pictures;
      var file = File(pictures.first);
      UploadDocument.getInstance().documents.insert(1, file);
      print(UploadDocument.getInstance().documents.length);
      viewModel.image.value = file;
/*
       Image.file(File(pictures.first));
*/
      //  });
    } catch (exception) {
      print(exception.toString());
      // Handle exception here
    }
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


class UploadSelfieView extends StackedView<UploadSelfieViewModel>{
  UploadDocumentViewModel parentViewModel;

  UploadSelfieView(this.parentViewModel);

  @override
  Widget builder(BuildContext context, UploadSelfieViewModel viewModel, Widget? child) {
    return nicView(context,viewModel);
  }



  @override
  UploadSelfieViewModel viewModelBuilder(BuildContext context) {
    return UploadSelfieViewModel();
  }

  @override
  void onViewModelReady(UploadSelfieViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget nicView(BuildContext context , UploadSelfieViewModel viewModel) {

    return  LoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (pro) {
        return customProgessBar();
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (value){
          if(UploadDocument.getInstance().documentType == 4 ){
            parentViewModel.setCurrentIndex(1);
          }else{
            parentViewModel.setCurrentIndex(2);
          }
          //  backClick(viewModel.currentIndex, viewModel);
        },
        child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: _buildAppBar(context ,"Upload Document", onBackClicked: (){
                print("object");
                if(UploadDocument.getInstance().documentType == 4 ){
                  parentViewModel.setCurrentIndex(1);
                }else{
                  parentViewModel.setCurrentIndex(2);
                }

              }),
                body: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 29, vertical: 28),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: (){
                              parentViewModel.setCurrentIndex(4);
                            },
                    child: UploadDocument.getInstance().selfie != null
                      ? CustomImageView(
                          imagePath:
                              UploadDocument.getInstance().selfie?.uri.path,
                          height: 200,
                          width: 200,
                          fit: BoxFit.fill,
                          radius: BorderRadius.circular(100),
                          alignment: Alignment.center,
                        )
                      : CustomImageView(
                          imagePath: ImageConstant.imgSelfie,
                          height: 146,
                          width: 146,
                          alignment: Alignment.center),
                ),
                SizedBox(height: 40),
                          Container(
                              width: 330,
                              margin: EdgeInsets.only(left: 1),
                              child: Text("msg_please_provide_us3".tr,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: CustomTextStyles.titleMedium18_1
                                      .copyWith(height: 1.22))),
                          SizedBox(height: 40),
                          Center(
                            child: Container(
                              width: 200,
                              child: Column(
                                children: [
                                  Row(
                                      children: [
                                        CustomImageView(
                                            imagePath:
                                            ImageConstant.imgMaterialSymbolsNoFlash,
                                            height: 24,
                                            width: 24),
                                        Padding(
                                            padding: EdgeInsets.only(left: 16),
                                            child: Text("lbl_no_flash".tr,
                                                style:
                                                CustomTextStyles.titleMediumSemiBold_1))
                                      ]),
                                  SizedBox(height: 23),
                                  Row(children: [
                                    CustomImageView(
                                        imagePath: ImageConstant.imgBrightness,
                                        height: 22,
                                        width: 22),
                                    Padding(
                                        padding: EdgeInsets.only(left: 16, top: 2),
                                        child: Text(("msg_use_a_light_room".tr+""),
                                            style:
                                            CustomTextStyles.titleMediumSemiBold_1))
                                  ]),
                                  SizedBox(height: 22),
                                  Row(
                                      children: [
                                        CustomImageView(
                                            imagePath: ImageConstant.imgMaterialSymbol,
                                            height: 24,
                                            width: 24),
                                        Padding(
                                            padding:
                                            EdgeInsets.only(left: 16, top: 2),
                                            child: Text("msg_hold_the_camera".tr,
                                                style: CustomTextStyles
                                                    .titleMediumSemiBold_1))
                                      ])

                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 5)
                        ])),
              bottomNavigationBar: bottomButton("Continue", context, onButtonPress: () {
                if(UploadDocument.getInstance().selfie != null){
                 /* CustomDialog.showErrorDialog(context,message:
                  "Upload Successfully", onPressedDialog: (){
                    UploadDocument.getInstance().clearData();
                    locator<NavigationService>().navigateTo(Routes.mainView);
                  });*/

                  List<File> documentArray = [];
                  List<int> documentIds = [];
                  UploadDocument.getInstance().documents.forEach((element) {
                    documentArray.add( element);
                    documentIds.add(UploadDocument.getInstance().documentType ?? 0);
                  });
                  documentArray.add(UploadDocument.getInstance().selfie!);
                  documentIds.add(5);

                  viewModel.uploadDocumentsAPI(StackedService.navigatorKey!.currentState!.context,documentIds,documentArray);

                }else{
                  CustomDialog.showErrorDialog(context,message:
                  "Please Upload Selfie", onPressedDialog: (){
                    Navigator.pop(context);
                  });
                }
              }),
            )),
      ),
    );

  }

  void onPressed(UploadIDBackViewModel viewModel) async {
    List<String> pictures;
    try {
      pictures = await CunningDocumentScanner.getPictures() ?? [];
      /*if (!mounted) return;*/
      //  setState(() {
      //_pictures = pictures;
      var file = File(pictures.first);
      UploadDocument.getInstance().documents.insert(1, file);
      print(UploadDocument.getInstance().documents.length);
      viewModel.image.value = file;
/*
       Image.file(File(pictures.first));
*/
      //  });
    } catch (exception) {
      print(exception.toString());
      // Handle exception here
    }
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


class SelfiePickerView extends StackedView<SelfiePickerViewModel>{
  UploadDocumentViewModel parentViewModel;

  SelfiePickerView(this.parentViewModel);

  @override
  Widget builder(BuildContext context, SelfiePickerViewModel viewModel, Widget? child) {
    return nicView(context,viewModel);
  }



  @override
  SelfiePickerViewModel viewModelBuilder(BuildContext context) {
    return SelfiePickerViewModel();
  }

  @override
  void onViewModelReady(SelfiePickerViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  @override
  bool get reactive => super.reactive;



  Widget nicView(BuildContext context , SelfiePickerViewModel viewModel) {

    return  PopScope(
      canPop: false,
      onPopInvoked: (value){
        parentViewModel.setCurrentIndex(3);
        //  backClick(viewModel.currentIndex, viewModel);
      },
      child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context ,"Upload Document", onBackClicked: (){
              print("object");
              parentViewModel.setCurrentIndex(3);
            }),
            body:     SmartFaceCamera(
                                  autoCapture: true,
                                  showCameraLensControl : false,
                                  showFlashControl: false,
                                  defaultCameraLens: CameraLens.front,
                                  message: 'Center your face in the square',
                                  onCapture: (File? image){
                                  UploadDocument.getInstance().selfie = image;
                                  parentViewModel.setCurrentIndex(3);
                                  }),
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



}