import 'package:flutter/material.dart';
import 'package:traer/provider/theme_helper.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillGray => BoxDecoration(
        color: appTheme.gray200,
      );
  static BoxDecoration get fillGray100 => BoxDecoration(
        color: appTheme.gray100,
      );
  static BoxDecoration get fillGray10001 => BoxDecoration(
        color: appTheme.gray10001,
      );
  static BoxDecoration get fillOnErrorContainer => BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
  static BoxDecoration get fillTeal => BoxDecoration(
        color: appTheme.teal300,
      );

  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: appTheme.black900,
        border: Border.all(
          color: appTheme.black900,
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        border: Border.all(
          color: appTheme.black900,
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9001 => BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: appTheme.black900.withOpacity(0.1),
            width: 1,
          ),
        ),
      );
  static BoxDecoration get outlineBlack9002 => BoxDecoration(
        color: appTheme.gray10001,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.1),
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9003 => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.1),
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9004 => BoxDecoration(
        color: theme.colorScheme.primary,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.5),
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9005 => BoxDecoration(
        color: appTheme.gray10001,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.5),
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9006 => BoxDecoration(
        color: appTheme.gray10001,
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.05),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(
              0,
              10,
            ),
          ),
        ],
      );
  static BoxDecoration get outlineBlack9007 => BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.25),
          width: 1,
        ),
      );
  static BoxDecoration get outlineBlack9008 => BoxDecoration(
        color: appTheme.gray10001,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.25),
          width: 1,
        ),
      );
  static BoxDecoration get outlinePrimary => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 1,
        ),
      );
  static BoxDecoration get outlinePrimary1 => BoxDecoration(
        color: appTheme.gray10001,
        border: Border.all(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(
        12,
      );
  static BorderRadius get circleBorder19 => BorderRadius.circular(
        19,
      );
  static BorderRadius get circleBorder66 => BorderRadius.circular(
        66,
      );

  // Custom borders
  static BorderRadius get customBorderBL20 => BorderRadius.vertical(
        bottom: Radius.circular(20),
      );

  // Rounded borders
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15,
      );
  static BorderRadius get roundedBorder38 => BorderRadius.circular(
        38,
      );
  static BorderRadius get roundedBorder4 => BorderRadius.circular(
        4,
      );
  static BorderRadius get roundedBorder7 => BorderRadius.circular(
        7,
      );
}

// Comment/Uncomment the below code based on your Flutter SDK version.
    
// For Flutter SDK Version 3.7.2 or greater.
    
double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
    