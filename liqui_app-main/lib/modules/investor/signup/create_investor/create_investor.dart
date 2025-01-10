import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/widgets/index.dart';

import 'controllers/create_investor_controller.dart';

class CreateInvestor extends GetView<CreateInvestorController> {
  // final isDisable = false.obs;

  const CreateInvestor({Key? key}) : super(key: key);

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
              title: 'basic_information'.tr,
              showBackButton: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding20, vertical: padding10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: mainWidgetList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding20, vertical: padding10),
                  child: MyButton(
                    buttonPadding:
                        const EdgeInsets.symmetric(vertical: padding15),
                    title: 'continue'.tr,
                    onPressed: !controller.disableButton.value
                        ? () => controller.callVerifyCKYC()
                        : null,
                  ),
                )
              ],
            )),
      ),
    );
  }

  List<Widget> mainWidgetList() {
    List<Widget> children = [];
    children.add(showSizedBox(height: padding32));
    children.add(Text(
      'pancard_details_text'.tr,
      style: myStyle.myFontStyle(
          color: Get.isDarkMode ? whiteColor : navyDarkColor,
          fontWeight: FontWeight.w400,
          fontSize: fontSize16),
    ));
    children.add(showSizedBox(height: padding28));
    children.add(MyInputField(
        textInputAction: TextInputAction.next,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value!.length != 10 || !value.isPanValid
              ? 'please_enter_pan'.tr
              : null;
        },
        keyboardType: controller.panController.value.text.length > 4 &&
                controller.panController.value.text.length < 9
            ? TextInputType.number
            : TextInputType.text,
        label: 'PAN',
        controller: controller.panController,
        maxLength: 10,
        maxLines: 1,
        textCapitalization: TextCapitalization.characters,
        labelStyle: myStyle.myFontStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize14,
            color: Get.isDarkMode ? whiteColor : fontHintColor),
        hint: 'enter_pan_number'.tr,
        hintStyle: myStyle.myFontStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize14,
            color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
        onChanged: (value) => {
              if (value.length == 10 && value.isPanValid)
                {controller.callVerifyPan()},
              controller.updateButtonState(),
            }));
    children.add(showSizedBox());
    children.add(MyInputField(
      onFieldSubmitted: (value) => controller.dobFocusNode.requestFocus(),
      textInputAction: TextInputAction.next,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.length < 3 ? 'please_enter_name'.tr : null;
      },
      controller: controller.nameController,
      label: 'name'.tr,
      labelStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontHintColor),
      maxLines: 1,
      focusNode: controller.nameFocusNode,
      textCapitalization: TextCapitalization.words,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
      ],
      hint: 'your_name_on_pan'.tr,
      hintStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
      readOnly: controller.readOnly.value,
      errorText: controller.nameErrorMsg,
      onChanged: (val) {
        controller.updateTextError(val, controller.fetchNameError);
      },
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      focusNode: controller.dobFocusNode,
      textInputAction: TextInputAction.next,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.isEmpty ? 'please_enter_dob'.tr : null;
      },
      controller: controller.dateController,
      label: 'dob'.tr,
      hint: 'dob_on_pan'.tr,
      readOnly: true,
      maxLines: 1,
      onChanged: (val) {
        controller.updateButtonState();
      },
      onTap: () => controller.openDOBSheet(),
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      focusNode: controller.emailFocusNode,
      textInputAction: TextInputAction.next,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return !value!.isEmailIdValid ? 'please_enter_email'.tr : null;
      },
      label: 'email'.tr,
      labelStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontHintColor),
      keyboardType: TextInputType.emailAddress,
      maxLines: 1,
      onChanged: (val) {
        controller.updateButtonState();
      },
      initialValue: controller.emailController.value.text,
      hint: 'enter_email'.tr,
      hintStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
      controller: controller.emailController,
    ));
    children.add(showSizedBox());
    children.add(Text("gender".tr, style: myStyle.defaultLabelStyle));
    children.add(Row(
      children: [
        Flexible(
          flex: 1,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "female".tr,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize14,
                  color: Get.isDarkMode ? whiteColor : fontHintColor),
            ),
            value: "female",
            groupValue: controller.gender.value,
            onChanged: (value) {
              controller.gender.value = value!;
              controller.updateButtonState();
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "male".tr,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize14,
                  color: Get.isDarkMode ? whiteColor : fontHintColor),
            ),
            value: "male",
            groupValue: controller.gender.value,
            onChanged: (value) {
              controller.gender.value = value!;
              controller.updateButtonState();
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              "other".tr,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize14,
                  color: Get.isDarkMode ? whiteColor : fontHintColor),
            ),
            value: "Other",
            groupValue: controller.gender.value,
            onChanged: (value) {
              controller.gender.value = value!;
              controller.updateButtonState();
            },
          ),
        ),
      ],
    ));
    return children;
  }

  Widget showSizedBox({double? height}) {
    return SizedBox(
      height: height ?? padding24,
    );
  }
}
