import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/signup/add_bank_account/controllers/add_bank_account_controller.dart';

import '../../../../global/constants/app_constants.dart';
import '../../../../global/utils/my_style.dart';

class AddBankAccount extends GetView<AddBankAccountController> {
  const AddBankAccount({Key? key}) : super(key: key);

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
          appBar: MyAppBar(title: 'add_bank_account'.tr),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding20, vertical: padding20),
                  child: Column(children: mainWidgetList()),
                ),
              ),
              MyButton(
                margin: const EdgeInsets.all(padding16),
                title: 'continue'.tr,
                onPressed: !controller.disableButton.value
                    ? () => controller.callCreateBanking()
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> mainWidgetList() {
    List<Widget> children = [];
    children.add(showSizedBox());
    children.add(MyInputField(
      controller: controller.ifscController,
      label: 'IFSC',
      hint: 'enter_ifsc_code'.tr,
      maxLength: 11,
      maxLines: 1,
      errorText: controller.bankNameError,
      textCapitalization: TextCapitalization.characters,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.length != 11 ? 'please_enter_ifsc'.tr : null;
      },
      hintStyle: myStyle.myFontStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSize14,
          color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
      textInputAction: TextInputAction.done,
      labelStyle: defaultTextStyle,
      onChanged: (value) => {
        if (value.length == 11)
          {
            controller.callIFSCode(),
          },
        controller.updateTextError(value, controller.fetchBankNameError),
      },
      autofocus: true,
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      label: 'bank_name'.tr,
      controller: controller.bankNameController,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        return value!.isEmpty ? 'bank_name_cannot_be_empty'.tr : null;
      },
      onChanged: (val) {
        controller.updateTextError(val, controller.fetchBankNameError);
      },
      readOnly: true,
      labelStyle: defaultTextStyle,
    ));
    children.add(showSizedBox());
    children.add(Focus(
      child: MyInputField(
        focusNode: controller.accountNumberFocusNode,
        label: 'account_number'.tr,
        controller: controller.accountNumberController,
        errorText: controller.accountHolderNameErrorMsg,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        textInputAction: TextInputAction.done,
        labelStyle: defaultTextStyle,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return value!.length < 6 ? 'please_enter_account_number'.tr : null;
        },
        hint: 'enter_account_number'.tr,
        hintStyle: myStyle.myFontStyle(
            fontWeight: FontWeight.w500,
            fontSize: fontSize14,
            color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
        onChanged: (val) {
          controller.updateButtonState();
        },
        onFieldSubmitted: (value) => {
          controller.callBankDetails(),
          controller.updateTextError(
              value, controller.fetchAccountHolderNameError)
        },
        // onTapOutside: (v){
        //   if (controller.accountNumberController.text.length > 5) {
        //     controller.updateTextError(controller.accountNumberController.text,
        //         controller.fetchAccountHolderNameError);
        //     controller.callBankDetails();
        //   }
        // },
      ),
      onFocusChange: (hasFocus) {
        if (!hasFocus && controller.accountNumberController.text.length > 5) {
          controller.updateTextError(controller.accountNumberController.text,
              controller.fetchAccountHolderNameError);
          controller.callBankDetails();
        }
      },
    ));
    children.add(showSizedBox());
    children.add(MyInputField(
      label: 'account_holder_name'.tr,
      readOnly: true,
      controller: controller.accountNameController,
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
