import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:get/get.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
            primary: primaryColor, secondary: secondaryColor),
        primaryColor: primaryColor,
        primaryColorDark: secondaryColor,
        indicatorColor: primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.buttonStyle(),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppTheme.buttonStyle(isOutlined: true),
        ),
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          actionsIconTheme: const IconThemeData(color: primaryDarkColor),
          iconTheme: const IconThemeData(color: primaryDarkColor),
          titleTextStyle: const TextStyle(
              color: primaryDarkColor,
              fontSize: fontSize22,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: secondaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          ),
        ),
        textTheme: TextTheme(
          displayMedium: const TextStyle(
              fontSize: fontSize14,
              fontWeight: FontWeight.w400,
              color: whiteColor,
              fontFamily: "Poppins"),
          titleMedium: const TextStyle(
            color: fontDesColor,
            fontSize: fontSize14,
            fontFamily: "Poppins",
          ),
          titleLarge: const TextStyle(
            color: fontDesColor,
            fontWeight: FontWeight.w800,
            fontSize: fontSize14,
            fontFamily: "Poppins",
          ),
          labelMedium: const TextStyle(
            color: fontDesColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize16,
            fontFamily: "Poppins",
          ),
          labelLarge: TextStyle(
            color: fontHintColor.withOpacity(0.4),
            fontWeight: FontWeight.w500,
            fontSize: fontSize16,
            fontFamily: "Poppins",
          ),
        ));
  }

  static ThemeData darkTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        indicatorColor: primaryColor,
        primaryColor: primaryDarkColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.buttonStyle(darkTheme: true),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppTheme.buttonStyle(isOutlined: true, darkTheme: true),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          titleTextStyle: const TextStyle(
              color: whiteColor,
              fontSize: fontSize22,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: primaryDarkColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        textTheme: TextTheme(
            displayMedium: const TextStyle(
                fontSize: fontSize14,
                fontWeight: FontWeight.w400,
                color: Colors.black12,
                fontFamily: "Poppins"),
            titleLarge: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w800,
              fontSize: fontSize14,
              fontFamily: "Poppins",
            ),
            titleMedium: const TextStyle(
              color: whiteColor,
              fontSize: fontSize14,
              fontFamily: "Poppins",
            ),
            labelMedium: const TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.w600,
              fontSize: fontSize16,
              fontFamily: "Poppins",
            ),
            labelLarge: TextStyle(
              color: grayLightColor.withOpacity(0.8),
              fontWeight: FontWeight.w500,
              fontSize: fontSize16,
              fontFamily: "Poppins",
            )));
  }

  static buttonStyle({bool isOutlined = false, bool darkTheme = false}) =>
      ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          Color backgroundColor = buttonColor;
          if (states.contains(MaterialState.disabled)) {
            backgroundColor =
                darkTheme ? primaryDarkColor : buttonDisabledColor;
          }
          if (states.contains(MaterialState.pressed)) {
            backgroundColor = secondaryColor;
          }
          return isOutlined ? transparentColor : backgroundColor;
        }),
        textStyle: MaterialStateProperty.resolveWith((states) {
          Color textColor = states.contains(MaterialState.disabled)
              ? grayDarkColor
              : isOutlined
                  ? buttonColor
                  : whiteColor;
          return myStyle.defaultButtonTextStyle(color: textColor);
        }),
        side: MaterialStateProperty.resolveWith((states) {
          Color sideColor = states.contains(MaterialState.disabled)
              ? grayDarkColor
              : buttonColor;
          return isOutlined ? BorderSide(color: sideColor) : null;
        }),
        minimumSize: MaterialStateProperty.resolveWith((states) {
          return Size.fromHeight(myHelper.isTablet ? padding60 : padding50);
        }),
      );
}
