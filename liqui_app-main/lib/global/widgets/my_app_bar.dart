import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';

import '../utils/my_style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final bool showBackButton;
  final bool? centerTitle;
  final double? elevation;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double height;

  const MyAppBar(
      {super.key,
      this.title,
      this.subTitle = '',
      this.titleStyle,
      this.subTitleStyle,
      this.showBackButton = true,
      this.centerTitle = true,
      this.elevation,
      this.leading,
      this.actions,
      this.backgroundColor,
      this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        automaticallyImplyLeading: showBackButton,
        centerTitle: centerTitle,
        leading: leading,
        backgroundColor: backgroundColor ?? Get.theme.scaffoldBackgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.validString)
              Text(
                title!.tr,
                style: titleStyle ??
                    myStyle.myFontStyle(
                        fontSize: fontSize16, fontWeight: FontWeight.w700),
              ),
            if (subTitle.validString) const SizedBox(height: padding2),
            if (subTitle.validString)
              Text(
                subTitle.tr,
                style: subTitleStyle ??
                    TextStyle(
                      fontSize: fontSizeS,
                      fontFamily: "Poppins",
                    ),
              )
          ],
        ),
        elevation: elevation,
        actions: actions,
      ),
    );
  }
}
