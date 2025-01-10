import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/widgets/index.dart';

import 'controller/verify_withdraw_request_controller.dart';

class VerifyWithdrawRequest extends GetView<VerifyWithdrawRequestController> {
  const VerifyWithdrawRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: MyAppBar(
            title: "verify_otp".tr,
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            onDismissPressed: () => controller.updateLoading(),
            backgroundColor: controller.overlayLoading.value
                ? Colors.white54
                : Get.theme.scaffoldBackgroundColor,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: padding30),
                width: screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: padding40),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: padding8),
                      child: Text(
                        'sent_otp_on_mobile'.tr,
                        style: myStyle.myFontStyle(
                            color: Get.isDarkMode ? whiteColor : fontHintColor,
                            fontWeight: FontWeight.w500,
                            fontSize: fontSize18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: padding40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: padding10,
                      ),
                      child: OTPTextField(
                        onCompleted: (code) {
                          // controller.validateForm();
                        },
                        onChanged: (code) {
                          controller.validateForm(verifyOtp: false);
                        },
                        onSubmitted: (code) {
                          if (code.length == 6) {
                            // controller.validateForm();
                          }
                        },
                        controller: controller.otpController,
                      ),
                    ),
                    const SizedBox(
                      height: padding20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: padding40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('not_receive_otp'.tr,
                                  style: myStyle.myFontStyle(
                                      color: Get.isDarkMode
                                          ? whiteColor
                                          : fontHintColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSize18)),
                              InkWell(
                                onTap: () => {
                                  logEvent.btnResendOtp(
                                      page:
                                          "page_${verifyWithdrawRequestScreen.substring(1)}",
                                      source:
                                          "page_${withdrawFundScreen.substring(1)}",
                                      type: "withdraw_fund"),
                                  controller.postSendTxnOTP()
                                },
                                child: Text(
                                  'resend_otp'.tr,
                                  style: myStyle.myFontStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: fontSize18,
                                      color: primaryColor),
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
                                  ? null
                                  : () => controller.validateForm(),
                              title: 'verify'.tr,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
