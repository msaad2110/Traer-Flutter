import 'package:flutter/material.dart';
import 'package:traer/provider/app_decoration.dart';
import 'package:traer/provider/custom_button_style.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';
import 'package:traer/utils/image_constant.dart';
import 'package:traer/widgets/custom_image_view.dart';
import 'package:traer/widgets/custom_outlined_button.dart';

// ignore: must_be_immutable
class FlightdetailsItemWidget extends StatelessWidget {
  FlightdetailsItemWidget({
    Key? key,
    this.onTapFlightDetails,
  }) : super(
          key: key,
        );

  VoidCallback? onTapFlightDetails;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFlightDetails!.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        decoration: AppDecoration.outlineBlack9006.copyWith(
          borderRadius: BorderRadiusStyle.circleBorder12,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "08:20",
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "LHR",
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Column(
                      children: [
                        Text(
                          "08h 45m",
                          style: CustomTextStyles.bodyMediumBluegray40001,
                        ),
                        SizedBox(height: 8),
                        SizedBox(
                          width: 160,
                          child: Divider(),
                        ),
                        SizedBox(height: 9),
                        Text(
                          "1 stop",
                          style: CustomTextStyles.bodyMediumBlack900,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "17:40",
                        style: CustomTextStyles.bodyMediumBluegray4000115,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "JFK",
                        style: theme.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgEllipse1226x26,
                  height: 26,
                  width: 26,
                  radius: BorderRadius.circular(
                    13,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 4,
                    top: 4,
                    bottom: 4,
                  ),
                  child: Text(
                    "John Doe",
                    style: CustomTextStyles.titleSmallBlack900Medium_2,
                  ),
                ),
                Spacer(),
                CustomOutlinedButton(
                  height: 19,
                  width: 44,
                  text: "4.8",
                  margin: EdgeInsets.symmetric(vertical: 3),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgSignal,
                      height: 14,
                      width: 14,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  buttonTextStyle: CustomTextStyles.titleMediumBlack900_2,
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(
              color: appTheme.gray20002,
            ),
            SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 1),
                          child: Text(
                            "Commission:",
                            style: CustomTextStyles.labelLargeGray80002,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Text(
                            "15%",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: 137,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 1),
                            child: Text(
                              "Available Space:",
                              style: CustomTextStyles.labelLargeGray80002,
                            ),
                          ),
                          Text(
                            "60KG",
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CustomOutlinedButton(
                  width: 68,
                  text: "CHAT",
                  margin: EdgeInsets.only(
                    top: 6,
                    bottom: 5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}
