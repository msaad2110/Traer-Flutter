import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:traer/base/app_setup.locator.dart';
import 'package:traer/base/app_setup.router.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/widgets/custom_elevated_button.dart';
import 'package:traer/widgets/custom_outlined_button.dart';

class PersonalAccountDialog extends StatefulWidget {
  const PersonalAccountDialog({Key? key}) : super(key: key);

  @override
  PersonalAccountDialogState createState() => PersonalAccountDialogState();

  static Widget builder(BuildContext context) {
    return PersonalAccountDialog();
  }
}

class PersonalAccountDialogState extends State<PersonalAccountDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        padding: EdgeInsets.all(25),
        decoration: AppDecoration.fillOnErrorContainer
            .copyWith(borderRadius: BorderRadiusStyle.circleBorder19),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("lbl_logging_out".tr, style: CustomTextStyles.titleLarge_1),
              SizedBox(height: 24),
              Text("msg_thanks_for_stopping".tr,
                  style: CustomTextStyles.bodyMediumGray800),
              SizedBox(height: 23),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Expanded(
                    child: CustomOutlinedButton(
                        height: 44,
                        text: "lbl_cancel".tr,
                        margin: EdgeInsets.only(right: 5),
                        buttonStyle: CustomButtonStyles.outlinePrimaryTL10,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        buttonTextStyle: CustomTextStyles.titleMediumPrimary)),
                Expanded(
                    child: CustomOutlinedButton(
                        height: 44,
                        text: "lbl_logout2".tr,
                        margin: EdgeInsets.only(left: 5),
    buttonStyle: CustomButtonStyles.outlinePrimaryTL101,
    buttonTextStyle: CustomTextStyles
        .titleMediumOnErrorContainerSemiBold,
                        onPressed: () {
                          onTapLogout(context);
                        }))
              ])
            ]));
  }

  onTapLogout(BuildContext context) {
    locator<NavigationService>().clearStackAndShow(Routes.loginView);
    // TODO: implement Actions
  }
}
