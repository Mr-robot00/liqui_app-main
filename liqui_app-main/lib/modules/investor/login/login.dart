import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/login/controllers/login_controller.dart';

class Login extends GetView<LoginController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(
      () => OverlayScreen(
        isLoading: controller.isLoading.value,
        errorMessage: controller.errorMsg.value,
        onRetryPressed: () => controller.handleRetryAction(),
        onDismissPressed: () => controller.updateLoading(),
        backgroundColor: controller.overlayLoading.value
            ? Get.isDarkMode
                ? Colors.black54
                : Colors.white54
            : Get.theme.scaffoldBackgroundColor,
        child: Scaffold(
          appBar: const MyAppBar(height: 0),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: padding30),
                  myHelper.getNetworkImage(
                    myLocal.appConfig.loginPageInfo!.asset!.url!,
                    width: padding200,
                    height: padding50,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: padding30),
                  Text(
                    myLocal.appConfig.loginPageInfo!.title!,
                    style: myStyle.myFontStyle(
                        fontWeight: FontWeight.w500, fontSize: fontSize20),
                  ),
                  const SizedBox(height: padding10),
                  Text(
                    myLocal.appConfig.loginPageInfo!.subtitle!,
                    style: myStyle.myFontStyle(
                        fontWeight: FontWeight.bold, fontSize: fontSize22),
                  ),
                  const SizedBox(height: padding50),
                  mobileNumberTextField,
                  const SizedBox(height: padding10),
                  Visibility(
                    visible: (controller.prevNumber.value ==
                            controller.mobileController.text &&
                        controller.counter.value > 0),
                    child: Row(
                      children: [
                        Text("try_again_after".tr),
                        CountDownTimer(
                          timerMaxSeconds: controller.counter.value,
                        ),
                        Text("seconds".tr)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '${'by_continue_accept'.tr} ',
                    style: myStyle.defaultFontStyle,
                    children: [
                      TextSpan(
                        text: 'terms_conditions'.tr,
                        style: myStyle.defaultTitleFontStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => myHelper.openUrl(termsAndConditionLink),
                      ),
                      TextSpan(
                        text: ' ${"and".tr} ',
                        style: myStyle.defaultFontStyle,
                      ),
                      TextSpan(
                        text: 'privacy_policy'.tr,
                        style: myStyle.defaultTitleFontStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => myHelper.openUrl(privacyPolicyLink),
                      ),
                    ],
                  ),
                ),
                MyButton(
                    margin: const EdgeInsets.symmetric(vertical: padding20),
                    onPressed: controller.disableButton.value
                        ? null
                        : () => controller.validateForm(),
                    title: "proceed".tr),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get mobileNumberTextField => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'mobile_number'.tr,
            style: myStyle.myFontStyle(
                fontWeight: FontWeight.w500,
                fontSize: fontSize14,
                color: Get.isDarkMode ? whiteColor : fontHintColor),
          ),
          const SizedBox(height: padding10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding10),
            child: InternationalPhoneNumberInput(
              keyboardType: TextInputType.number,
              autofillHints: [
                if (myHelper.isAndroid) AutofillHints.telephoneNumberNational,
                AutofillHints.telephoneNumber,
              ],
              // maxLength: 10,
              onInputChanged: (PhoneNumber number) {
                controller.mobileController.text = number.phoneNumber
                        ?.replaceAll(number.dialCode ?? '+91', '') ??
                    '';
                controller.updateButtonState();
              },
              countries: const ["IN"],
              hintText: "enter_mobile_number".tr,
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              ),
              textStyle: const TextStyle(fontFamily: "Poppins"),
              autoValidateMode: AutovalidateMode.disabled,
              selectorTextStyle: TextStyle(
                color: Get.isDarkMode ? whiteColor : Colors.black,
                fontFamily: "Poppins",
              ),
              initialValue: controller.phoneNumber,
              textFieldController: controller.mobileController,
              formatInput: false,
              autoFocus: true,
            ),
          )
        ],
      );
}
