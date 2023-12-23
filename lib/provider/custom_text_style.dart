import 'package:flutter/material.dart';
import 'package:traer/provider/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
      );
  static get bodyLargeGray60001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray60001,
      );
  static get bodyLargeGray70002 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray70002,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      );
  static get bodyLargeGray80002 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray80002,
      );
  static get bodyLargeGray80003 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray80003,
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 18,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBlack900_1 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
      );
  static get bodyMediumBluegray40001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray40001,
      );
  static get bodyMediumBluegray4000115 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 15,
      );
  static get bodyMediumGray500 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray500,
      );
  static get bodyMediumGray60002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray60002,
      );
  static get bodyMediumGray70001 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray70001,
      );
  static get bodyMediumGray800 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray800,
      );
  static get bodyMediumGray80002 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray80002,
      );
  static get bodyMediumGray900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.gray900,
      );
  static get bodyMediumOnError => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onError,
      );
  static get bodyMediumOnErrorContainer => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get bodyMediumWhiteA700 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
      );
  static get bodySmallGray70003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray70003,
        fontSize: 10,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 10,
      );
  static get bodySmallPrimaryContainerLight =>
      theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontWeight: FontWeight.w300,
      );
  static get bodySmallSatoshiGray70003 =>
      theme.textTheme.bodySmall!.satoshi.copyWith(
        color: appTheme.gray70003,
        fontSize: 10,
      );
  static get bodySmallSatoshiPrimaryContainer =>
      theme.textTheme.bodySmall!.satoshi.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  // Display text style
  static get displayMediumLight => theme.textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w300,
      );
  static get displayMediumSemiBold => theme.textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get displayMediumSemiBold_1 => theme.textTheme.displayMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  // Headline text style
  static get headlineMediumSemiBold => theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get headlineSmallTeal300 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.teal300,
        fontWeight: FontWeight.w700,
      );
  // Label text style
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 13,
      );
  static get labelLargeBlack900SemiBold => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeGray50001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray50001,
      );
  static get labelLargeGray80002 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray80002,
      );
  static get labelLargeGreen800 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.green800,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargePrimarySemiBold => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeSecondaryContainer =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.secondaryContainer,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
  static get labelLargeYellow80001 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.yellow80001,
        fontSize: 13,
        fontWeight: FontWeight.w600,
      );
  // Title text style
  static get titleLargeMedium => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleLargeMedium_1 => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleLargeOnSecondaryContainer =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeOnSecondaryContainerMedium =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );
  static get titleLargeOnSecondaryContainer_1 =>
      theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
      );
  static get titleLargePrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleLargeRegular => theme.textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w400,
      );
  static get titleLarge_1 => theme.textTheme.titleLarge!;
  static get titleMedium18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static get titleMedium18_1 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 17,
      );
  static get titleMediumBlack90018 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18,
      );
  static get titleMediumBlack900SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBlack900SemiBold_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack900_2 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBlack900_3 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumBluegray400 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray400,
      );
  static get titleMediumBluegray40001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.blueGray40001,
        fontSize: 17,
      );
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumGray20001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray20001,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumGray70002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray70002,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumGray70002SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray70002,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumGray80002 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray80002,
      );
  static get titleMediumOnErrorContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumOnErrorContainer17 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 17,
      );
  static get titleMediumOnErrorContainerSemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumOnErrorContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumOnErrorContainer_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleMediumPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 17,
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 18,
      );
  static get titleMediumPrimaryContainer18 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: 18,
      );
  static get titleMediumPrimaryContainer18_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(0),
        fontSize: 18,
      );
  static get titleMediumPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get titleMediumPrimarySemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSemiBold => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSemiBold18 => theme.textTheme.titleMedium!.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumSemiBold_1 => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
      );
  static get titleMediumWhiteA700 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17,
      );
  static get titleMediumWhiteA700SemiBold =>
      theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
        fontSize: 17,
        fontWeight: FontWeight.w600,
      );
  static get titleMediumWhiteA700_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumWhiteA700_2 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleMediumWhiteA700_3 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBlack900Medium => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900Medium_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900Medium_2 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallBluegray40001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray40001,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBluegray40001Medium =>
      theme.textTheme.titleSmall!.copyWith(
        color: appTheme.blueGray40001,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallGray400 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray400,
      );
  static get titleSmallGray400_1 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray400,
      );
  static get titleSmallGray70001 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray70001,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallOnErrorContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
      );
  static get titleSmallOnSecondaryContainer =>
      theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.onSecondaryContainer,
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get titleSmallPrimaryContainer => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get titleSmallWhiteA700 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.whiteA700,
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get satoshi {
    return copyWith(
      fontFamily: 'Satoshi',
    );
  }
}
