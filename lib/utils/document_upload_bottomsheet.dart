

import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/widgets/custom_outlined_button.dart';

class DocumentUploadBottomSheet extends StatefulWidget {
  //final Function(File file) onUpload; // Callback for uploaded file

  const DocumentUploadBottomSheet({Key? key})
      : super(key: key);

  @override
  State<DocumentUploadBottomSheet> createState() =>
      _DocumentUploadBottomSheetState();
}

class _DocumentUploadBottomSheetState extends State<DocumentUploadBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.0),
          Text(
            "Verification Required",
              style: CustomTextStyles.titleMediumSemiBold),
          SizedBox(height: 10.0),
          Text(
              "Upload a document to verify your account.",
              style: CustomTextStyles.titleMediumSemiBold),
          SizedBox(height: 20.0),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 60,
            child: buildBottomButton(context),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }


  Widget buildBottomButton(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomOutlinedButton(
                      height: 48,
                      width :MediaQuery.sizeOf(context).width * 0.4,
                      text: "Get Verified".tr,
                      margin: EdgeInsets.only(left: 5),
                      buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
                      buttonTextStyle: CustomTextStyles.titleMediumWhiteA700SemiBold,
                      onPressed: () {
                        onTapGetVarified(context);
                      }),
                  CustomOutlinedButton(
                      height: 48,
                      width :MediaQuery.sizeOf(context).width * 0.4,
                      text: "Verify Later".tr,
                      margin: EdgeInsets.only(left: 5),
                      buttonStyle: CustomButtonStyles.outlinePrimaryTL10,
                      buttonTextStyle: CustomTextStyles.titleMediumPrimarySemiBold,
                      onPressed: () {
                        onTapLater(context);
                      })
                ])));
  }

  onTapGetVarified(BuildContext context) {
    Navigator.pop(context);
    locator<NavigationService>().navigateTo(Routes.uploadDocumentView);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapLater(BuildContext context) {
    Navigator.pop(context);
  //  locator<NavigationService>().navigateTo(Routes.loginView);

  }

}