import 'package:flutter/material.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class AppbarTitleButtonTwo extends StatelessWidget {
  AppbarTitleButtonTwo({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          height: 20,
          width: 64,
          text: "lbl_trip_details".tr,
          buttonStyle: CustomButtonStyles.none,
          buttonTextStyle: theme.textTheme.bodyLarge!,
        ),
      ),
    );
  }
}
