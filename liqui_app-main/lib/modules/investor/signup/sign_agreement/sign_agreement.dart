import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/signup/sign_agreement/controllers/sign_agreement_controller.dart';

class SignAgreement extends GetView<SignAgreementController> {
  const SignAgreement({super.key});

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
          backgroundColor: Get.isDarkMode
              ? Get.theme.scaffoldBackgroundColor
              : Colors.white54,
          appBar: MyAppBar(title: 'sign_agreement'.tr),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: padding20,
                      right: padding20,
                      bottom: padding10,
                      top: padding20,
                    ),
                    child: titleDescriptions(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: padding20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: padding10,
                    ),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              if (controller.signInValue.value) {
                                controller.signInValue.value = false;
                              } else {
                                controller.signInValue.value = true;
                              }
                            },
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: myHelper.getAssetImage(
                                  controller.signInValue.value
                                      ? 'checked'
                                      : 'unchecked'),
                            )),
                        const SizedBox(
                          width: padding10,
                        ),
                        Flexible(
                          child: Text('i_accept'.tr,
                              style: myStyle.myFontStyle(
                                  color: Get.isDarkMode? whiteColor:blackColor,
                                  fontWeight: FontWeight.w300,
                                  fontSize: fontSize12)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: padding10,
                    ),
                    MyButton(
                      onPressed: controller.signInValue.value
                          ? () => controller.callSignAgreement()
                          : null,
                      title: 'sign_agreement'.tr,
                      margin: const EdgeInsets.symmetric(vertical: padding20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleDescriptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          myLocal.appConfig.signAgreementTnc!.terms!.title!,
          textAlign: TextAlign.start,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : blackColor,
              fontWeight: FontWeight.bold,
              fontSize: padding12),
        ),
        Text(
          myLocal.appConfig.signAgreementTnc!.terms!.description!,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : blackColor,
              // fontWeight: FontWeight.bold,
              fontSize: padding12),
        ),
        const SizedBox(
          height: padding10,
        ),
        Text(
          myLocal.appConfig.signAgreementTnc!.conditions!.title!,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : blackColor,
              fontWeight: FontWeight.bold,
              fontSize: padding12),
        ),
        Text(
          myLocal.appConfig.signAgreementTnc!.conditions!.description!,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : blackColor,
              //fontWeight: FontWeight.bold,
              fontSize: padding12),
        ),
      ],
    );
  }
}
