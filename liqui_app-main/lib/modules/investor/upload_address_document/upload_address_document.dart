import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/modules/investor/upload_bank_document/controller/upload_bank_document_controller.dart';

import '../../../global/constants/index.dart';
import '../../../global/widgets/index.dart';

class UploadAddressDocument extends GetView<UploadBankDocumentController> {
  const UploadAddressDocument({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            appBar: MyAppBar(
              title: "upload_address_doc".tr,
            ),
            body: OverlayScreen(
                isLoading: controller.isLoading.value,
                errorMessage: controller.errorMsg.value,
                onRetryPressed: () => controller.handleRetryAction(),
                onDismissPressed: () => controller.updateLoading(),
                backgroundColor: controller.overlayLoading.value
                    ? Colors.white54
                    : Get.theme.scaffoldBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(padding16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyInputField(
                            controller: controller.documentValue,
                            label: 'select_proof_address'.tr,
                            labelStyle: myStyle.myFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize14,
                                color: Get.isDarkMode ? whiteColor : fontHintColor),
                            hint: "select_proof_address".tr,
                            hintStyle: myStyle.myFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize14,
                                color: Get.isDarkMode ? whiteColor : fontPlaceholderColor),
                            keyboardType: TextInputType.number,
                            onTap: () => myWidget.showDocumentSelection(),
                            readOnly: true,
                            suffix: const Icon(Icons.arrow_drop_down,
                                color: primaryColor),
                          ),
                          const SizedBox(
                            height: padding10,
                          ),
                          if (controller.showProofError.isTrue)
                            Padding(
                              padding: const EdgeInsets.only(top: padding0),
                              child: Text(
                                "Please ${"select_proof_address".tr}",
                                style: myStyle.myFontStyle(
                                    color: redColor, fontSize: padding16),
                              ),
                            ),
                        ],
                      ),
                      controller.imagePath.value.isNotEmpty
                          ? Stack(children: [
                              Padding(
                                padding: const EdgeInsets.all(padding20),
                                child:
                                    controller.imagePath.value.contains(".pdf")
                                        ? const SizedBox(
                                            width: 350,
                                            height: 350,
                                            child: Icon(
                                              Icons.picture_as_pdf_rounded,
                                              color: grayDarkColor,
                                              size: 300,
                                            ),
                                          )
                                        : Image.file(
                                            File(controller.imagePath.value),
                                            width: 350,
                                            height: 350,
                                            fit: BoxFit.fill,
                                          ),
                              ),
                              Positioned(
                                  right: padding0,
                                  top: padding0,
                                  child: RoundedContainer(
                                    radius: (padding25),
                                    backgroundColor:
                                        Get.theme.scaffoldBackgroundColor,
                                    child: Material(
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(padding25),
                                        onTap: () => {
                                          {controller.imagePath.value = ""},
                                          controller.validateForm()
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: redColor,
                                          size: padding50,
                                        ),
                                      ),
                                    ),
                                  )),
                            ])
                          : MyOutlinedButton(
                              minimumSize: const Size(padding0, padding50),
                              avoidIntrusions: true,
                              margin: const EdgeInsets.all(padding10),
                              onPressed: controller.documentValue.text.isEmpty
                                  ? null
                                  : () async {
                                      var result = await myWidget.uploadImage();
                                      if (result != null) {
                                        controller.imagePath.value = result!;
                                        controller.validateForm();
                                      }
                                    },
                              title: "upload_address_doc".tr),
                      MyButton(
                          onPressed: controller.disableButton.value
                              ? null
                              : () => {controller.validateForm(true)},
                          title: "proceed".tr)
                    ],
                  ),
                )),
          ),
        ));
  }
}
