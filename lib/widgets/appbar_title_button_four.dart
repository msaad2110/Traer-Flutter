import 'package:flutter/material.dart';
import 'package:traer/localization/app_localization.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class AppbarTitleButtonFour extends StatelessWidget {
  AppbarTitleButtonFour({
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
          width: 100,
          text: "lbl_filters".tr,
          buttonStyle: CustomButtonStyles.none,
          buttonTextStyle: theme.textTheme.bodyLarge!,
        ),
      ),
    );
  }
}
