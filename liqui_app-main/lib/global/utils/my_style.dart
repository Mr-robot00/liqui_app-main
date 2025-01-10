import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';

class MyStyle {
  TextStyle myFontStyle(
          {Color? color,
          String? fontFamily,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      Get.textTheme.titleSmall!.copyWith(
          fontWeight: fontWeight,
          color: color ?? (Get.isDarkMode ? whiteColor : fontDesColor),
          fontSize: fontSize ?? fontSizeDefault,
          fontFamily: fontFamily ?? "Poppins",
          fontStyle: fontStyle);

  TextStyle get defaultFontStyle => Get.textTheme.titleMedium!;

  TextStyle get defaultTitleFontStyle => Get.textTheme.titleLarge!;

  TextStyle get defaultLabelStyle => Get.textTheme.labelMedium!;

  TextStyle get defaultHintFontStyle => Get.textTheme.labelLarge!;

  TextStyle defaultButtonTextStyle(
          {Color? color,
          String? fontFamily,
          double? fontSize,
          FontWeight? fontWeight,
          FontStyle? fontStyle}) =>
      TextStyle(
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? whiteColor,
          fontSize: fontSize ?? fontSizeM,
          fontFamily: fontFamily ?? "Poppins",
          fontStyle: fontStyle);

  TextStyle get defaultOutlinedButtonTextStyle => TextStyle(
        color: buttonColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSizeM,
        fontFamily: "Poppins",
      );
}

final myStyle = MyStyle();
