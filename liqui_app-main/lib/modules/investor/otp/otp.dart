import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/otp/controllers/otp_controller.dart';

import '../../../global/constants/app_constants.dart';
import '../../../global/utils/my_style.dart';

class Otp extends GetView<OtpController> {
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(
      () => OverlayScreen(
        isLoading: controller.isLoading.value,
        errorMessage: controller.errorMsg.value,
        onRetryPressed: () => controller.handleRetryAction(),
        backgroundColor: controller.overlayLoading.value
            ? Get.isDarkMode
                ? Colors.black54
                : Colors.white54
            : Get.theme.scaffoldBackgroundColor,
        child: Scaffold(
          appBar: MyAppBar(
            title: 'verify_mobile'.tr,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: padding20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: padding20),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: padding8),
                            child: Text(
                              'sent_otp_on'.tr,
                              style: myStyle.myFontStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: fontSize16,
                              color: navyDarkColor),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: padding5),
                                child: RichText(
                                  text: TextSpan(
                                      text: controller.mobileNumber.isNotEmpty
                                          ? '+91-${controller.mobileNumber}'
                                          : 'Invalid number',
                                      style: myStyle.myFontStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: fontSize20)),
                                ),
                              ),
                              Visibility(
                                visible: true,
                                child: InkWell(
                                  onTap: () {
                                    Get.offNamed(loginScreen);
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: padding20),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(padding5))),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: padding10,
                                          vertical: padding2),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.edit_outlined,
                                            size: padding16,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            ' edit'.toUpperCase().tr,
                                            style: myStyle.myFontStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: fontSize12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: padding50,
                          ),
                          Text(
                            'enter_otp'.tr,
                            style: myStyle.myFontStyle(
                                color: Get.isDarkMode ? whiteColor : blackColor,
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize14),
                          ),
                          const SizedBox(height: padding10),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: padding10,
                            ),
                            child: OTPTextField(
                              onCompleted: (code) {
                                controller.verifyOtp();
                              },
                              onChanged: (code) {
                                controller.updateButtonState();
                              },
                              onSubmitted: (code) {
                                if (code.length == 6) {
                                  controller.verifyOtp();
                                }
                              },
                              controller: controller.otpController,
                            ),
                          ),
                          Visibility(
                            visible: (controller.counter.value > 0),
                            child: Row(
                              children: [
                                Text("resend_otp_after".tr),
                                CountDownTimer(
                                  timerMaxSeconds: controller.counter.value,
                                ),
                                Text("seconds".tr)
                              ],
                            ),
                          ),
                          const SizedBox(height: padding20),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: padding20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: padding30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('not_receive_otp'.tr,
                                style: myStyle.myFontStyle(
                                    color: Get.isDarkMode
                                        ? grayLightColor
                                        : fontHintColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: fontSize14)),
                            InkWell(
                              onTap: controller.resendButton.value
                                  ? () => {
                                        logEvent.btnResendOtp(
                                            page:
                                                "page_${otpScreen.substring(1)}",
                                            source: controller.autoSendOtp
                                                ? "auto_logout"
                                                : "page_${loginScreen.substring(1)}",
                                            type: controller.accountExist
                                                ? "login"
                                                : "signup"),
                                        controller.callSendOTP(),
                                      }
                                  : null,
                              child: Text(
                                'resend_otp'.tr,
                                style: myStyle.myFontStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSize14,
                                    color: controller.resendButton.value
                                        ? primaryColor
                                        : fontHintColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: padding30),
                          child: MyButton(
                            onPressed: controller.disableButton.value
                                ? () => controller.verifyOtp()
                                : null,
                            title: 'verify'.tr,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
