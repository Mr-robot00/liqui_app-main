import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/my_style.dart';

import '../constants/app_constants.dart';

class MyTitleSubtitle extends StatelessWidget {
  final String title;
  final String subTitle;

  final double? titleTextSize;
  final double? subTitleTextSize;

  final Color? titleTextColor;
  final Color? subTitleTextColor;

  final FontWeight? tittleWeight;
  final FontWeight? subTittleWeight;

  const MyTitleSubtitle(
      {super.key,
      required this.title,
      required this.subTitle,
      this.titleTextSize = 14,
      this.subTitleTextSize = 14,
      this.titleTextColor = darkGrayColor,
      this.subTitleTextColor = greyColor,
      this.tittleWeight = FontWeight.w400,
      this.subTittleWeight = FontWeight.w600});

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? grayLightColor : titleTextColor,
              fontSize: titleTextSize,
              fontWeight: tittleWeight),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          subTitle,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : subTitleTextColor,
              fontSize: subTitleTextSize,
              fontWeight: subTittleWeight),
        ),
      ],
    );
  }
}
