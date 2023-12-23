

import 'package:flutter/material.dart';
import 'package:traer/utils/CreateMaterialColor.dart';
import 'package:traer/utils/colorfield.dart';


class CustomTextStyle {

  final createMaterialColor = CreateMaterialColor();




  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 12,
    color:  ColorsField.orangeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle smallGreyTextStyle = TextStyle(
    fontSize: 12,
    color:  ColorsField.greyColorDark,
    fontWeight: FontWeight.normal,
  );


  static const TextStyle normalTextStyle = TextStyle(
    fontSize: 12,
    color:  ColorsField.greyColor,
    fontWeight: FontWeight.bold,
  );


  static const TextStyle smallWhiteTextStyle = TextStyle(
    fontSize: 12,
    color:  Colors.white,
    fontWeight: FontWeight.normal,
  );


  static const TextStyle largeWhiteTextStyle = TextStyle(
    fontSize: 12,
    color:  Colors.white,
    fontWeight: FontWeight.normal,
  );


  static const TextStyle largeWhiteTextStyleBold = TextStyle(
    fontSize: 14,
    color:  Colors.white,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle largeorangeTextStyleBold = TextStyle(
    fontSize: 16,
    color:  ColorsField.orangeColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle largeblackTextStyleBold = TextStyle(
    fontSize: 16,
    color:  ColorsField.blackColor,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle largeblackTextStyleNormal = TextStyle(
    fontSize: 16,
    color:  ColorsField.blackColor,
    fontWeight: FontWeight.normal,
  );

  static  TextStyle customStyle(double fontSize , Color color , FontWeight fontWeight) => TextStyle(
    fontSize: fontSize,
    color:  color,
    fontWeight: fontWeight,
  );
}