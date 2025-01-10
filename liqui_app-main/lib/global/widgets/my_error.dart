import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';

import 'index.dart';

class MyError extends StatelessWidget {
  final String errorMessage;
  final String retryButtonText;
  final String dismissText;
  final bool showRetryButton;
  final bool showDismissButton;
  final VoidCallback? onRetryPressed;
  final VoidCallback? onDismissPressed;

  const MyError({
    Key? key,
    required this.errorMessage,
    this.onRetryPressed,
    this.onDismissPressed,
    this.dismissText = 'dismiss',
    this.retryButtonText = 'try_again',
    this.showDismissButton = true,
    this.showRetryButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showDismissButton = this.showDismissButton && onDismissPressed != null;
    bool showRetryButton = this.showRetryButton && onRetryPressed != null;

    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 26.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            child: myHelper.getAssetImage(
              errorMessage.contains('internet')
                  ? 'no_internet'
                  : _noData
                      ? "error_image"
                      : 'error_image',
              // height: myHelper.isTablet ? 180 : 140,
              width: double.maxFinite,
            ),
          ),
          const SizedBox(
            height: padding10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 10.0),
            child: Text(
              errorMessage.contains('internet')
                  ? 'Whoops!'
                  : _noData
                      ? "Oh Snap!"
                      : 'Oh Snap!',
              textAlign: TextAlign.center,
              style: myStyle.myFontStyle(
                color: Get.isDarkMode ? whiteColor : Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: myHelper.isTablet ? 30 : 25,
              ),
            ),
          ),

          Container(
            width: 60.0,
            height: 4.0,
            color: Get.isDarkMode ? whiteColor : Colors.black26,
          ),

          const SizedBox(
            height: padding10,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0),
            child: Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: myStyle.myFontStyle(
                color: Get.isDarkMode ? grayLightColor : fontTitleColor,
                fontSize: myHelper.isTablet ? 22 : 18,
              ),
            ),
          ),
          const SizedBox(height: padding20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showDismissButton)
                Flexible(
                  child: MyButton(
                    avoidIntrusions: false,
                    onPressed: onDismissPressed,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(padding20),
                      ),
                    ),
                    backgroundColor: redColor,
                    title: dismissText.tr,
                    minimumSize: const Size(0, 45),
                    buttonPadding:
                        const EdgeInsets.symmetric(horizontal: padding20),
                  ),
                ),
              if (showDismissButton && showRetryButton)
                const SizedBox(width: padding20),
              if (showRetryButton)
                Flexible(
                  child: MyButton(
                    avoidIntrusions: false,
                    onPressed:
                        _unauthorized ? myHelper.logoutUser : onRetryPressed,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(padding20),
                      ),
                    ),
                    title: _noData
                        ? "refresh".tr
                        : _unauthorized
                            ? "login".tr
                            : retryButtonText.tr,
                    buttonPadding:
                        const EdgeInsets.symmetric(horizontal: padding20),
                    minimumSize: const Size(0, 45),
                  ),
                ),
            ],
          ),
          // const SizedBox(height: 16),
        ],
      ),
    );
  }

  bool get _noData {
    return (errorMessage.contains('No data found!') ||
        errorMessage.contains('No data found') ||
        errorMessage.contains('No Data Found!') ||
        errorMessage.contains('No Data Found'));
  }

  bool get _unauthorized {
    return (errorMessage.contains('Unauthorised') ||
        errorMessage.contains('Session Expired!'));
  }
}
