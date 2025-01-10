import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/signup/add_address/controllers/add_address_controller.dart';

import '../../../../global/constants/app_constants.dart';
import '../../../../global/utils/helpers/my_helper.dart';
import '../../../../global/utils/my_style.dart';

class AddAddress extends GetView<AddAddressController> {
  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          appBar: MyAppBar(title: 'your_address'.tr),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding20, vertical: padding20),
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mainListWidget(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(padding16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!controller.fromAddAddrees.value)
                      MyOutlinedButton(
                        onPressed: () {
                          Get.offAllNamed(homeScreen);
                        },
                        textStyle: myStyle.myFontStyle(
                            fontSize: fontSize14,
                            color: primaryColor,
                            fontWeight: FontWeight.w500),
                        buttonPadding:
                            const EdgeInsets.symmetric(vertical: padding15),
                        title: 'do_it_later'.tr,
                      ),
                    const SizedBox(
                      height: padding16,
                    ),
                    MyButton(
                        onPressed: !controller.disableButton.value
                            ? () => controller.callCreateAddress()
                            : null,
                        title: "submit".tr),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> mainListWidget() {
    List<Widget> children = [];
    children.add(showSizedBox());
    children.add(Text(
      'where_can_we_reach_you'.tr,
      style: myStyle.myFontStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : navyDarkColor),
    ));
    children.add(showSizedBox(height: 12));
    children.add(Text(
      'add_address_for_communication'.tr,
      style: myStyle.myFontStyle(
          fontWeight: FontWeight.w400,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : navyDarkColor.withOpacity(0.7)),
    ));
    children.add(showSizedBox(height: padding30));
    children.add(MyInputField(
      autofillHints: [
        if (myHelper.isAndroid) AutofillHints.postalAddressExtendedPostalCode,
        AutofillHints.postalCode,
      ],
      label: 'Pincode',
      controller: controller.pinCodeController,
      hint: 'enter_your_pincode'.tr,
      maxLength: 6,
      onChanged: (val) {
        if (val.length == 6) {
          controller.callVerifyPinCode();
        }
        controller.updateButtonState();
      },
      validator: (value) {
        return myHelper.formValidator(value!, 'please_enter_pincode'.tr);
      },
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      labelStyle: defaultTextStyle,
      hintStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
      onFieldSubmitted: (value) => {
        if (value.length == 6)
          {controller.callVerifyPinCode()}
        else
          {Get.showSnackBar('please_enter_pincode'.tr)}
      },
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      focusNode: controller.address1FocusNode,
      onFieldSubmitted: (_) => controller.address2FocusNode.requestFocus(),
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.fullStreetAddress],
      label: 'address_line_one'.tr,
      maxLength: 50,
      keyboardType: TextInputType.streetAddress,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return myHelper.formValidator(value!, 'please_enter_address'.tr);
      },
      controller: controller.addressOneController,
      labelStyle: defaultTextStyle,
      onChanged: (val) {
        ///if min char validation arrives
        controller.updateButtonState();
      },
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      focusNode: controller.address2FocusNode,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.fullStreetAddress],
      label: 'address_line_two'.tr,
      maxLength: 50,
      controller: controller.addressTwoController,
      keyboardType: TextInputType.streetAddress,
      labelStyle: defaultTextStyle,
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      autofillHints: const [AutofillHints.addressCity],
      label: 'city'.tr,
      readOnly: true,
      errorText: controller.cityError,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return myHelper.formValidator(value!, 'city_name_cannot_be_empty'.tr);
      },
      onChanged: (val) {
        if (val.isNotEmpty) {
          controller.updateButtonState();
        }
      },
      controller: controller.cityController,
      initialValue: controller.cityController.value.text,
      labelStyle: defaultTextStyle,
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      autofillHints: const [AutofillHints.addressState],
      label: 'state'.tr,
      readOnly: true,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return myHelper.formValidator(value!, 'state_name_cannot_be_empty'.tr);
      },
      onChanged: (val) {
        if (val.isNotEmpty) {
          controller.updateButtonState();
        }
      },
      errorText: controller.stateErrorMsg,
      controller: controller.stateController,
      initialValue: controller.stateController.value.text,
      labelStyle: defaultTextStyle,
    ));
    return children;
  }

  Widget showSizedBox({double? height}) {
    return SizedBox(
      height: height ?? padding24,
    );
  }

  TextStyle get defaultTextStyle {
    return myStyle.myFontStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontSize14,
        color: Get.isDarkMode ? whiteColor : fontHintColor);
  }
}
