import 'dart:io';
import 'dart:io' as io;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/helpers/app_permissions.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';
import 'package:liqui_app/modules/investor/select_folio/controllers/hierarchy_controller.dart';
import 'package:liqui_app/modules/investor/upload_bank_document/controller/upload_bank_document_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../constants/index.dart';

class MyWidget {
  Widget divider({double width = 0.0, double height = 0.0}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  Future<dynamic> showFolioSelection({
    bool isDismissible = true,
    bool showAllFolio = false,
    bool showIfaChangeConfirmation = false,
    String ifaChangeConfirmationMsg = "",
    required String page,
    required String source,
  }) {
    HierarchyController controller = Get.find();
    controller.folios(showAllFolio: showAllFolio);
    //Here folio id 0 is set for All Folio option
    var selectedFolio = (myLocal.ifaId.isEmpty ? "0" : myLocal.ifaId).obs;
    return Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      SafeArea(
        child: Obx(
          () => OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: padding30),
                  Text(
                    'choose_folio'.tr,
                    style: myStyle.myFontStyle(
                        fontSize: fontSize20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: padding20),
                  Text(
                    controller.showRegisterButton
                        ? "choose_folio_subtext_create_account".tr
                        : 'choose_folio_subtext_continue'.tr,
                    style: myStyle.myFontStyle(fontSize: fontSize16),
                  ),
                  const SizedBox(height: padding30),
                  controller.ifaData.isNotEmpty
                      ? Column(
                          children: [
                            ListView.separated(
                              itemCount: controller.ifaData.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var folio = controller.ifaData[index];
                                return Column(
                                  children: [
                                    Obx(
                                      () => ListTile(
                                        onTap: () {
                                          if (selectedFolio.value !=
                                              folio.ifaId.toString()) {
                                            selectedFolio.value =
                                                folio.ifaId.toString();
                                          }
                                        },
                                        leading: CircleAvatar(
                                          backgroundColor: primaryColor,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(padding2),
                                            //border size
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: Text(
                                                folio.ifaName![0]
                                                    .toLowerCase()
                                                    .capFirstOfEach,
                                                style: myStyle.myFontStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: fontSize20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          folio.ifaName!
                                              .toLowerCase()
                                              .capFirstOfEach,
                                          style: myStyle.myFontStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSize14),
                                        ),
                                        trailing: Icon(
                                          selectedFolio.value ==
                                                  folio.ifaId.toString()
                                              ? Icons.check_circle
                                              : Icons.radio_button_off,
                                          color: primaryColor,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: padding16);
                              },
                            ),
                            const SizedBox(height: padding16),
                            MyButton(
                                margin: const EdgeInsets.symmetric(
                                    vertical: padding20),
                                onPressed: selectedFolio.value ==
                                        (myLocal.ifaId.validString
                                            ? myLocal.ifaId
                                            : "0")
                                    ? null
                                    : () {
                                        var validSelection =
                                            selectedFolio.value !=
                                                myLocal.ifaId;
                                        var selected = controller.ifaData
                                            .firstWhere((folio) =>
                                                folio.ifaId.toString() ==
                                                selectedFolio.value);
                                        if (validSelection) {
                                          logEvent.buttonSelectFolio(
                                              ifaId: num.parse(selectedFolio
                                                      .value.validString
                                                  ? selectedFolio.value
                                                  : "0"),
                                              ifaName:
                                                  selectedFolio.value == "0"
                                                      ? "All"
                                                      : selected.ifaName!,
                                              page: page,
                                              source: source);
                                          HomeController home = Get.find();
                                          if (showIfaChangeConfirmation) {
                                            myWidget.showConfirmationPopUp(
                                                "$ifaChangeConfirmationMsg ${selected.ifaName!}",
                                                onConfirmPressed: () {
                                                  controller
                                                      .selectFolio(selected);
                                                  home.updateFolioDetails();
                                                  Get.back(
                                                      result: validSelection);
                                                },
                                                onCancelPressed: () =>
                                                    Get.back(result: false));
                                          } else {
                                            controller.selectFolio(selected);
                                            home.updateFolioDetails();
                                            Get.back(result: validSelection);
                                          }
                                        } else {
                                          logEvent.buttonSelectFolio(
                                              ifaId: num.parse(selectedFolio
                                                      .value.validString
                                                  ? selectedFolio.value
                                                  : "0"),
                                              ifaName:
                                                  selectedFolio.value == "0"
                                                      ? "All"
                                                      : selected.ifaName!,
                                              page: page,
                                              source: source);
                                          Get.back(result: validSelection);
                                        }
                                      },
                                title: "continue".tr),
                            // if(controller.showRegisterButton)
                            if (controller.showRegisterButton)
                              Column(
                                children: [
                                  Row(children: <Widget>[
                                    _divider,
                                    Text(
                                      "or".tr,
                                      style: myStyle.myFontStyle(
                                          color: Get.isDarkMode
                                              ? grayLightColor
                                              : fontDesColor,
                                          fontSize: fontSize16),
                                    ),
                                    _divider,
                                  ]),
                                  const SizedBox(height: padding10),
                                  MyOutlinedButton(
                                      avoidIntrusions: true,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: padding16),
                                      onPressed: () {
                                        logEvent.buttonCreateLlAccount(
                                            page: page, source: source);
                                        Get.offNamed(createInvestorScreen,
                                            arguments: {
                                              "mobile_number": myLocal
                                                  .userDataConfig.userNumber,
                                              "for_register_folio": true
                                            });
                                      },
                                      title:
                                          "create_new_liquiloans_account".tr),
                                ],
                              ),
                          ],
                        )
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(padding16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "no_data_found".tr,
                                style:
                                    myStyle.myFontStyle(fontSize: fontSize18),
                              ),
                              const SizedBox(height: padding10),
                              MyButton(
                                onPressed: controller.onPullRefresh,
                                title: "refresh".tr,
                                minimumSize: const Size(0, 40),
                              )
                            ],
                          ),
                        ),
                  const SizedBox(height: padding20),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  Future<dynamic> showDocumentSelection() {
    final UploadBankDocumentController controller = Get.find();

    return Get.bottomSheet(
      isDismissible: true,
      SafeArea(
        child: Obx(
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: padding16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: padding30),
                  Text(
                    'select_proof'.tr,
                    style: myStyle.myFontStyle(
                        fontSize: fontSize20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: padding20),
                  controller.docs.isNotEmpty
                      ? Flexible(
                          child: ListView.separated(
                            itemCount: controller.docs.length,
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              var folio = controller.docs[index];
                              return Column(
                                children: [
                                  ListTile(
                                      onTap: () {
                                        var selected = controller.docs[index];
                                        controller.documentValue.text =
                                            selected.label;
                                        controller.validateForm();
                                        Get.back();
                                      },
                                      leading: const Icon(Icons.file_present,
                                          size: padding30),
                                      title: Text(
                                        controller.docs[index].label,
                                        style: myStyle.myFontStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: fontSize16),
                                      ),
                                      trailing: Icon(
                                        folio.label.toString() ==
                                                controller.documentValue.text
                                            ? Icons.check_circle
                                            : Icons.radio_button_off,
                                        color: primaryColor,
                                        size: 30,
                                      )),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(height: padding16);
                            },
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(padding16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "no_data_found".tr,
                                style:
                                    myStyle.myFontStyle(fontSize: fontSize18),
                              ),
                              const SizedBox(height: padding10),
                            ],
                          ),
                        ),
                  const SizedBox(height: padding20),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  Future<dynamic> uploadImage(
      {bool isDismissible = true, bool showFile = true}) async {
    final ImagePicker picker = ImagePicker();
    return Get.bottomSheet(
      isDismissible: isDismissible,
      SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: padding20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'upload_proof'.tr,
              style: myStyle.myFontStyle(
                  fontSize: fontSize20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: padding20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                myWidget.optionWidget(Icons.camera_alt, "photo".tr, () async {
                  if (Platform.isIOS
                      ? await appPermissions
                          .permissionsGranted(AppPermissions.cameraPermission)
                      : true) {
                    final XFile? result =
                        await picker.pickImage(source: ImageSource.camera);
                    if (result != null &&
                        result.path.validString &&
                        io.File(result.path).existsSync()) {
                      final compressedImage = await _compressImage(
                        file: io.File(result.path),
                      );
                      Get.back(result: compressedImage.path);
                    } else {
                      Get.back(result: null);
                      Get.showSnackBar("unable_to_load_image".tr);
                    }
                  }
                }),
                myWidget.optionWidget(Icons.image_rounded, "img_upload".tr,
                    () async {
                  if (Platform.isIOS
                      ? await appPermissions
                          .permissionsGranted(AppPermissions.photosPermission)
                      : true) {
                    final XFile? result =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (result != null &&
                        result.path.validString &&
                        io.File(result.path).existsSync()) {
                      final compressedImage = await _compressImage(
                        file: io.File(result.path),
                      );

                      Get.back(result: compressedImage.path);
                    } else {
                      Get.back(result: null);
                      Get.showSnackBar("unable_to_load_image".tr);
                    }
                  }
                }),
                if (showFile)
                  myWidget.optionWidget(
                      Icons.upload_file_sharp, "upload_doc".tr, () async {
                    if (Platform.isAndroid && await myHelper.sdkVersion < 33
                        ? await appPermissions.permissionsGranted(
                            AppPermissions.storagePermission)
                        : true) {
                      FilePickerResult? result = await FilePicker.platform
                          .pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['pdf']);

                      if (result != null &&
                          result.files.first.path.validString &&
                          io.File(result.files.first.path ?? "").existsSync()) {
                        Get.back(result: result.files.first.path!);
                      } else {
                        Get.back(result: null);
                        Get.showSnackBar("unable_to_load_document".tr);
                      }
                    }
                  }),
              ],
            ),
            const SizedBox(height: padding20),
            MyOutlinedButton(
                avoidIntrusions: true,
                margin: const EdgeInsets.symmetric(horizontal: padding20),
                onPressed: () {
                  Get.back();
                },
                title: "cancel".tr),
          ],
        ),
      )),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  /// compress image
  Future<io.File> _compressImage(
      {required File file, int quality = 100, int precentage = 14}) async {
    final sizeInMB = (file.lengthSync() / 1024) / 1024;
    if (sizeInMB <= 3) return file;
    return await FlutterNativeImage.compressImage(
      file.absolute.path,
      quality: quality,
      percentage: precentage,
    );
  }

  Widget optionWidget(final icon, String title, VoidCallback? onClicked) {
    return RoundedContainer(
      radius: 8,
      width: 120,
      height: 100,
      backgroundColor: Get.isDarkMode ? blackLightColor : blueLightColor,
      child: MaterialButton(
        onPressed: onClicked,
        padding: const EdgeInsets.symmetric(
            vertical: padding10, horizontal: padding16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(padding8),
          ),
        ),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: padding35, color: primaryColor),
            const SizedBox(height: padding10),
            Flexible(
              child: Text(
                title,
                style: myStyle.defaultTitleFontStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showInvalidIfaAlert({bool isDismissible = true}) {
    return Get.bottomSheet(
      isDismissible: isDismissible,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: padding16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: padding30),
              Text(
                'invalid_ifa_message'.tr,
                style: myStyle.myFontStyle(
                    fontSize: fontSize20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: padding20),
              MyOutlinedButton(
                  onPressed: () => Get.back(), title: "Okay".allInCaps),
              const SizedBox(height: padding20),
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  Widget folioSelectionRow(
      {bool showDroDown = false,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) {
    return Container(
      padding: padding,
      margin: margin,
      child: Row(
        children: [
          // Icon(Icons.account_circle, color: fontColor),
          // myHelper.getAssetImage(
          //   "ifa",
          //   height: padding30,
          //   width: padding30,
          // ),
          CircleAvatar(
            backgroundColor: primaryColor,
            radius: padding12, //border color
            child: Padding(
              padding: const EdgeInsets.all(padding2), //border size
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  myLocal.ifaName.validString
                      ? myLocal.ifaName[0].toLowerCase().capFirstOfEach
                      : "A",
                  style: myStyle.myFontStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: padding5),
          Text(
              myLocal.ifaName.validString
                  ? myLocal.ifaName.split(" ")[0].toLowerCase().capFirstOfEach
                  : "All Folios",
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w500, fontSize: fontSize14)),
          // const SizedBox(width: padding5),
          if (showDroDown)
            const Icon(Icons.arrow_drop_down, color: primaryColor),
        ],
      ),
    );
  }

  Future<dynamic> kycAlertDialog(
      {bool isDismissible = false,
      required String screenName,
      forKycRejection = false,
      String? kycRejectionMessage}) {
    final ProfileController profile = Get.find();
    var loading = false.obs;
    return Get.bottomSheet(
      isDismissible: isDismissible,
      SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding16),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: padding20),
                  myHelper.getAssetImage(
                    'kyc_not_verified',
                    height: 128,
                    width: 100,
                    fit: BoxFit.fitHeight,
                  ),
                  if (forKycRejection)
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: padding20),
                        Text(
                          'your_kyc_verification_failed'.tr,
                          style: myStyle.myFontStyle(
                              fontSize: fontSize22,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: padding10),
                      ],
                    ),
                  if (!forKycRejection)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(padding20),
                          child: Text(
                            "complete_your_kyc".tr,
                            textAlign: TextAlign.center,
                            style: myStyle.myFontStyle(
                                fontSize: fontSize20,
                                fontWeight: FontWeight.w700),
                            // textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: padding20),
                      ],
                    ),
                  if (forKycRejection)
                    Column(
                      children: [
                        Text(
                          kycRejectionMessage!,
                          textAlign: TextAlign.center,
                          style: myStyle.myFontStyle(
                              fontSize: fontSize16,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: padding20),
                      ],
                    ),
                  MyOutlinedButton(
                      avoidIntrusions: true,
                      onPressed: loading.value
                          ? null
                          : () => {
                                // Get.toNamed(uploadBankDocumentScreen)
                                Get.back(),
                                logEvent.verifyKycConfirmation(
                                    page: "page_$screenName",
                                    btnClicked: "do_it_later".tr)
                              },
                      title: "do_it_later".tr),
                  if (!forKycRejection)
                    Column(
                      children: [
                        const SizedBox(height: padding20),
                        loading.value
                            ? const CircularProgressIndicator()
                            : MyButton(
                                onPressed: () async {
                                  loading.value = true;
                                  var result = await profile.callGetBasicDetail(
                                      fromKycDialog: true);
                                  logEvent.verifyKycConfirmation(
                                      page: "page_$screenName",
                                      btnClicked: "complete_kyc".tr);
                                  loading.value = false;
                                  Get.back();
                                  if (result.isNotEmpty && result[0]) {
                                    if (profile.nextKycScreen != "review") {
                                      Get.toNamed(profile.nextKycScreen,
                                          arguments: (profile.nextKycScreen ==
                                                      addAddressScreen ||
                                                  profile.nextKycScreen ==
                                                      addBankAccountScreen)
                                              ? {"fromKyc": true}
                                              : null);
                                    }
                                  } else {
                                    Get.showSnackBar(
                                        result[1] ?? "something_went_wrong".tr);
                                  }
                                },
                                title: "complete_kyc".tr),
                      ],
                    ),
                  const SizedBox(height: padding20)
                ],
              ),
            )),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  Future<dynamic> transactionCancelledAlertDialog(
      {bool isDismissible = false,
      required String interestRupees,
      required VoidCallback clickContinue,
      required VoidCallback clickCancel}) {
    return Get.bottomSheet(
      isDismissible: isDismissible,
      SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: padding20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(flex: 1, child: SizedBox.shrink()),
                    Expanded(
                        flex: 8,
                        child: myHelper.getAssetImage(
                          'transaction_cancelled',
                          height: 100,
                          width: 100,
                          fit: BoxFit.fitHeight,
                        )),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: clickCancel, child: const Icon(Icons.close)))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: padding20,
                      left: padding20,
                      right: padding20,
                      bottom: padding10),
                  child: Text(
                    '${"losing_text".tr}${myHelper.currencyFormat.format(double.parse(interestRupees))}',
                    textAlign: TextAlign.center,
                    style: myStyle.myFontStyle(
                        fontSize: fontSize20,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                    // textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(padding0),
                  child: Text(
                    'why_lose_when_you_can_earn'.tr,
                    textAlign: TextAlign.center,
                    style: myStyle.myFontStyle(
                        fontSize: fontSize16, fontWeight: FontWeight.w400),
                    // textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: padding20),
                MyButton(onPressed: clickContinue, title: "continue".tr),
                const SizedBox(height: padding20)
              ],
            )),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  dynamic customDialog(String image, String title, String loadingText,
      {Widget? child}) {
    return Get.bottomSheet(
        GestureDetector(
          onTap: () {
            Future.delayed(const Duration(seconds: 5), () {
              Get.back();
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  border: Border.all(color: transparentColor),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(padding20),
                      topRight: Radius.circular(padding20))),
              child: child ??
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: padding20, bottom: padding10),
                        child: Text(title,
                            textAlign: TextAlign.center,
                            style: myStyle.myFontStyle(
                                fontSize: myHelper.isTablet ? 25.0 : 20.0,
                                fontWeight: FontWeight.bold,
                                color: greenDarkColor)),
                      ),
                      Text(loadingText,
                          style: myStyle.myFontStyle(
                              fontSize: myHelper.isTablet ? 20.0 : 15.0,
                              fontWeight: FontWeight.w400,
                              color: Get.isDarkMode
                                  ? grayLightColor
                                  : fontDesColor)),
                      myHelper.getAssetImage(image),
                      const SizedBox(
                        height: padding20,
                      )
                    ],
                  )),
        ),
        exitBottomSheetDuration: const Duration(seconds: 1));
  }

  void showPopUp(
    String message, {
    String? title,
    bool dismissible = true,
    IconData icon = Icons.info,
    Color iconColor = Colors.yellow,
  }) {
    Get.dialog(
        barrierDismissible: dismissible,
        WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Center(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: padding26,
                    left: padding26,
                    right: padding26,
                    top: 36,
                  ),
                  padding: const EdgeInsets.all(padding26),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Get.theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(padding20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: padding26, bottom: padding16),
                        child: Text(
                          "${title ?? "alert".tr}!",
                          textAlign: TextAlign.center,
                          style: myStyle.myFontStyle(
                            color: Get.isDarkMode ? whiteColor : fontTitleColor,
                            fontWeight: FontWeight.bold,
                            fontSize: fontSizeL,
                          ),
                        ),
                      ),
                      Container(
                          width: 60.0,
                          height: 4.0,
                          color: Get.isDarkMode ? whiteColor : Colors.black26),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: padding16),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: myStyle.myFontStyle(
                            fontSize: fontSizeM,
                          ),
                        ),
                      ),
                      const SizedBox(height: padding16),
                      MyOutlinedButton(
                        onPressed: () => Get.back(),
                        title: "okay".tr,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: padding0,
                  right: padding0,
                  child: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 35,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        child: Icon(icon, size: 65, color: iconColor),
                        // Image.asset("placeholder"),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  void showConfirmationPopUp(String message,
      {String? title,
      String? confirmButtonLabel,
      required VoidCallback? onConfirmPressed,
      VoidCallback? onCancelPressed,
      bool dismissible = true,
      IconData icon = Icons.info,
      Color iconColor = Colors.yellow,
      bool showCancelButton = true}) {
    Get.dialog(
        barrierDismissible: dismissible,
        WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Center(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: padding10),
                  child: Container(
                    margin: const EdgeInsets.all(padding26),
                    padding: const EdgeInsets.all(padding26),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Get.theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(padding20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: padding26, bottom: padding16),
                          child: Text(
                            "${title ?? "alert".tr}!",
                            textAlign: TextAlign.center,
                            style: myStyle.myFontStyle(
                              color:
                                  Get.isDarkMode ? whiteColor : fontTitleColor,
                              fontWeight: FontWeight.bold,
                              fontSize: fontSizeL,
                            ),
                          ),
                        ),
                        Container(
                            width: 60.0,
                            height: 4.0,
                            color: Get.isDarkMode
                                ? grayLightColor
                                : Colors.black26),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: padding16),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                            style: myStyle.myFontStyle(
                              fontSize: fontSizeM,
                            ),
                          ),
                        ),
                        const SizedBox(height: padding16),
                        Row(
                          children: [
                            if (showCancelButton)
                              Flexible(
                                child: MyOutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                    if (onCancelPressed != null) {
                                      onCancelPressed();
                                    }
                                  },
                                  title: "cancel".tr,
                                  foregroundColor: redColor,
                                  side: const BorderSide(color: redColor),
                                ),
                              ),
                            const SizedBox(width: padding20),
                            Flexible(
                              child: MyOutlinedButton(
                                onPressed: () {
                                  Get.back();
                                  if (onConfirmPressed != null) {
                                    onConfirmPressed();
                                  }
                                },
                                title: confirmButtonLabel ?? "confirm".tr,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: padding0,
                  right: padding0,
                  child: CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 35,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(35)),
                        child: Icon(icon, size: 65, color: iconColor),
                        // Image.asset("placeholder"),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget noItemFound(String title, {String description = ''}) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
      child: Column(
        children: [
          Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: myWidget.textColor,
                  size: myHelper.isTablet ? 30.0 : 25.0,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    title,
                    style: TextStyle(
                        color: myWidget.textColor,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins",
                        fontSize: myHelper.isTablet ? 22.0 : 18.0),
                  ),
                ),
              ]),
          SizedBox(
            height: description.isNotEmpty ? padding10 : 0,
          ),
          Text(
            description,
            style: TextStyle(
                color: myWidget.textColor,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
                fontSize: myHelper.isTablet ? fontSize20 : fontSize16),
          )
        ],
      ),
    );
  }

  Widget defaultAppLoader({double? size}) {
    return ThreeBounceLoader(
      color: buttonColor,
      size: size ?? (myHelper.isTablet ? 80 : 45),
    );
  }

  get defaultFontStyle {
    return TextStyle(
      // color: fontColor,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
      fontSize: myHelper.isTablet ? fontSize22 : fontSize18,
    );
  }

  get defaultDropdownTextStyle {
    return TextStyle(
      fontSize: myHelper.isTablet ? fontSize22 : fontSize18,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
    );
  }

  get defaultLabelStyle {
    return TextStyle(
      fontSize: myHelper.isTablet ? fontSize22 : fontSize10,
      color: myWidget.textColor,
      fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
    );
  }

  get defaultLoaderFontStyle {
    return TextStyle(
      color: fontTitleColor,
      fontSize: myHelper.isTablet ? fontSize24 : fontSize20,
      fontWeight: FontWeight.bold,
      fontFamily: "Poppins",
    );
  }

  get defaultHintFontStyle {
    return TextStyle(
      color: myHelper.isDarkMode
          ? myWidget.textColor.withOpacity(0.8)
          : myWidget.textColor.withOpacity(0.4),
      fontSize: myHelper.isTablet ? fontSize22 : fontSize18,
      // fontWeight: FontWeight.w500,
      fontFamily: "Poppins",
    );
  }

  get textColor {
    return Theme.of(Get.context!).textTheme.bodyLarge!.color;
  }

  get inputTextDecoration {
    return InputDecoration(
      contentPadding: const EdgeInsets.fromLTRB(padding16, padding12, 0, 0),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor.withOpacity(0.8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: textColor.withOpacity(0.2)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red.withOpacity(0.5),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: redColor.withOpacity(0.5), width: 1.5),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: textColor.withOpacity(0.2),
        ),
      ),
    );
  }

  get inputTextNoDecoration {
    return const InputDecoration(
      contentPadding: EdgeInsets.all(padding16),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.transparent,
        ),
      ),
    );
  }

  double dropDownMaxHeight({int? length}) {
    if (length == null) return 150;
    return 150 > (length * 56) ? (length * 56) : 150;
  }

  Future<dynamic> selectDate(TextEditingController controller,
      {DateTime? tempPickedDate,
      String? dateFormat,
      bool forPassBookDownload = false}) async {
    var dateNow = DateTime.now();
    return await showModalBottomSheet<DateTime>(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Text(
                      'cancel'.tr,
                      style: myStyle.defaultLabelStyle,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  CupertinoButton(
                    child: Text(
                      'done'.tr,
                      style: myStyle.defaultLabelStyle,
                    ),
                    onPressed: () async {
                      if (tempPickedDate != null) {
                        controller.text = dtHelper.getFormattedDate(
                            tempPickedDate.toString(),
                            outFormat: dateFormat ?? 'dd-MMM-yyyy');
                      } else if (tempPickedDate == null &&
                          forPassBookDownload &&
                          controller.text.isEmpty) {
                        tempPickedDate =
                            DateTime(dateNow.year, dateNow.month, dateNow.day);
                        controller.text = dtHelper.getFormattedDate(
                            tempPickedDate.toString(),
                            outFormat: dateFormat ?? 'dd-MMM-yyyy');
                      }
                      Get.back(result: tempPickedDate);
                    },
                  ),
                ],
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  minimumDate:
                      DateTime(dateNow.year - 100, dateNow.month, dateNow.day),
                  initialDateTime: controller.text.isNotEmpty
                      ? DateFormat('dd-MMM-yyyy').parse(controller.text)
                      : forPassBookDownload
                          ? DateTime(dateNow.year, dateNow.month, dateNow.day)
                          : DateTime(
                              dateNow.year - 18, dateNow.month, dateNow.day),
                  maximumDate: forPassBookDownload
                      ? DateTime(dateNow.year, dateNow.month, dateNow.day)
                      : DateTime(dateNow.year - 18, dateNow.month, dateNow.day),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime dateTime) {
                    tempPickedDate = dateTime;
                    // printLog('tempPickedDate $dateTime');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showStatementDateSelection(
      {required TextEditingController dateControllerStart,
      required TextEditingController dateControllerEnd,
      VoidCallback? onPressed,
      bool isDismissible = true}) {
    Rxn<DateTime> startDate = Rxn<DateTime>();
    Rxn<DateTime> endDate = Rxn<DateTime>();
    return Get.bottomSheet(
      isDismissible: isDismissible,
      SafeArea(
        child: Obx(() => Container(
            padding: const EdgeInsets.symmetric(
                vertical: padding30, horizontal: padding30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: padding10),
                    Expanded(
                      flex: 9,
                      child: Text(
                        'download_passbook'.tr,
                        style: myStyle.myFontStyle(
                            fontSize: fontSize20,
                            fontWeight: FontWeight.w700,
                            color: violetDarkColor),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () => {Get.back()},
                            child: const Icon(
                              Icons.close,
                              size: padding24,
                              color: fontHintColor,
                            )))
                  ],
                ),
                const SizedBox(height: padding6),
                Text(
                  'choose_the_date_range'.tr,
                  style: myStyle.myFontStyle(
                      fontSize: fontSize12,
                      color: fontHintColor,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: padding20),
                MyInputField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    labelStyle: myStyle.myFontStyle(
                        fontSize: fontSize14,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode ? whiteColor : fontHintColor),
                    suffix: const Icon(
                      Icons.calendar_today_outlined,
                      color: primaryColor,
                      size: padding28,
                    ),
                    validator: (value) {
                      return value!.isEmpty ? "select_start_date".tr : null;
                    },
                    controller: dateControllerStart,
                    label: "start_date".tr,
                    hint: "select_start_date".tr,
                    readOnly: true,
                    maxLines: 1,
                    onTap: () async {
                      var result = await selectDate(dateControllerStart,
                          forPassBookDownload: true);
                      if (result != null) {
                        startDate.value = result;
                      }
                    }),
                const SizedBox(height: padding25),
                MyInputField(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    labelStyle: myStyle.myFontStyle(
                        fontSize: fontSize14,
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode ? whiteColor : fontHintColor),
                    suffix: const Icon(
                      Icons.calendar_today_outlined,
                      color: primaryColor,
                      size: padding28,
                    ),
                    validator: (value) {
                      if (startDate.value != null && endDate.value != null) {
                        if (startDate.value!.isAfter(endDate.value!)) {
                          return "end_date_should_be_greater".tr;
                        }
                      }
                      return value!.isEmpty ? "select_end_date".tr : null;
                    },
                    controller: dateControllerEnd,
                    label: "end_date".tr,
                    hint: "select_end_date".tr,
                    readOnly: true,
                    maxLines: 1,
                    onTap: () async {
                      var result = await selectDate(dateControllerEnd,
                          forPassBookDownload: true);
                      if (result != null) {
                        endDate.value = result;
                      }
                    }),
                const SizedBox(height: padding50),
                MyButton(
                    onPressed: (startDate.value != null &&
                            endDate.value != null &&
                            !startDate.value!.isAfter(endDate.value!))
                        ? onPressed
                        : null,
                    title: "download".tr),
              ],
            ))),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  Future<dynamic> uploadFilePopUp() {
    return Get.bottomSheet(
        Wrap(children: [
          Container(
            decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(color: transparentColor),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(padding20),
                    topRight: Radius.circular(padding20))),
            padding: const EdgeInsets.symmetric(
                horizontal: padding20, vertical: padding20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    onTap: () {},
                    title: Text(
                      'Gallery',
                      style: myStyle.defaultFontStyle,
                    ),
                    leading: const Icon(Icons.photo, color: primaryColor),
                  ),
                  ListTile(
                    onTap: () {},
                    title: Text('Camera', style: myStyle.defaultFontStyle),
                    leading: const Icon(Icons.camera, color: primaryColor),
                  ),
                  ListTile(
                      onTap: () {},
                      title: Text('File', style: myStyle.defaultFontStyle),
                      leading:
                          const Icon(Icons.upload_file, color: primaryColor)),
                ]),
          ),
        ]),
        isScrollControlled: true);
  }

  double space() {
    return screenHeight > 650 ? spaceM : spaceS;
  }

  Widget getRupeeText(String amount,
      {double? fontSize,
      FontWeight? fontWeight = FontWeight.w600,
      Color? color}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "$rupeeSymbol ",
          style: myStyle.myFontStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: "",
              color: color),
        ),
        Text(
          myHelper.currencyFormat.format(double.parse(amount)),
          style: myStyle.myFontStyle(
              fontSize: fontSize, fontWeight: fontWeight, color: color),
        )
      ],
    );
  }

  Future<dynamic> showThemeSelection({bool isDismissible = true}) {
    Map<String, String> themeListData = {
      "device_settings": "device_settings".tr,
      "dark_mode": "dark_mode".tr,
      "light_mode": "light_mode".tr
    };
    return Get.bottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: padding16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: padding30),
              Text(
                'dark_mode'.tr,
                style: myStyle.myFontStyle(
                    fontSize: fontSize20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: padding6),
              const Divider(
                color: darkGrayColor,
                thickness: 0.5,
              ),
              const SizedBox(height: padding6),
              Text(
                'choose_how_app_theme_experience_looks'.tr,
                style: myStyle.myFontStyle(
                    fontSize: fontSize14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: padding6),
              Flexible(
                child: ListView.separated(
                  itemCount: themeListData.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var themeValue = themeListData;
                    return Column(
                      children: [
                        ListTile(
                          onTap: () {
                            myLocal.themeValue =
                                themeValue.keys.elementAt(index);
                            Get.changeThemeMode(myLocal.themeMode);
                            Get.back();
                          },
                          title: Text(
                            themeValue.values.elementAt(index),
                            style: myStyle.myFontStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize14),
                          ),
                          trailing: Icon(
                            themeValue.keys.elementAt(index) ==
                                        myLocal.themeValue ||
                                    (!myLocal.themeValue.validString)
                                ? Icons.check_circle
                                : Icons.radio_button_off,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: padding16);
                  },
                ),
              ),
              const SizedBox(height: padding10),
              Text(
                'app_device_mode_theme_description'.tr,
                style: myStyle.myFontStyle(
                    fontSize: fontSize12, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: padding20),
            ],
          ),
        ),
      ),
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(padding20),
          topRight: Radius.circular(padding20),
        ),
      ),
    );
  }

  TargetFocus tutorialTargetFocus(
      {required GlobalKey keyTarget,
      required String title,
      required String description,
      required String page,
      Color? primaryDarkColor,
      ContentAlign? align,
      bool showNextButton = true,
      bool showPrevButton = false,
      bool finishButton = false,
      VoidCallback? onNextPress,
      VoidCallback? onPrevPress,
      VoidCallback? onFinishPress,
      ShapeLightFocus? shape,
      double? radius,
      bool showSkipBottom = false}) {
    return TargetFocus(
      keyTarget: keyTarget,
      color: Get.isDarkMode ? navyDarkColor : primaryDarkColor,
      contents: [
        TargetContent(
          align: align ?? ContentAlign.bottom,
          builder: (context, controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(padding15),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(padding10),
                  ),
                  child: Column(
                    children: [
                      Text(
                        title,
                        style: myStyle.myFontStyle(
                            fontSize: fontSize16,
                            fontWeight: FontWeight.w700,
                            color: whiteColor),
                      ),
                      const SizedBox(height: padding5),
                      Text(
                        description,
                        style: myStyle.myFontStyle(
                            fontSize: fontSize14,
                            fontWeight: FontWeight.w400,
                            color: whiteColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: padding10),
                Container(
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    // child: showNextButton
                    // ?
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (showPrevButton)
                          InkWell(
                            onTap: () {
                              if (onPrevPress != null) {
                                logEvent.showCaseEvent(
                                    page: page,
                                    buttonLabel: "prev".tr,
                                    type: title);
                                onPrevPress();
                                controller.previous();
                              } else {
                                null;
                              }
                            },
                            child: Container(
                              width: screenWidth / 2.5,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(padding5),
                                border:
                                    Border.all(color: whiteColor, width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: padding8, horizontal: padding15),
                                child: Text("prev".tr,
                                    style: myStyle.myFontStyle(
                                        fontSize: fontSize16,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor)),
                              ),
                            ),
                          ),
                        if (showPrevButton && showNextButton)
                          Container(
                            width: padding30,
                          ),
                        if (showNextButton)
                          InkWell(
                            onTap: () {
                              if (onNextPress != null) {
                                logEvent.showCaseEvent(
                                    page: page,
                                    buttonLabel: "next".tr,
                                    type: title);
                                onNextPress();
                                controller.next();
                              } else {
                                null;
                              }
                            },
                            child: Container(
                              width: screenWidth / 2.5,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(padding5),
                                border:
                                    Border.all(color: whiteColor, width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: padding8, horizontal: padding15),
                                child: Text("next".tr,
                                    style: myStyle.myFontStyle(
                                        fontSize: fontSize16,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor)),
                              ),
                            ),
                          ),
                        if (!showNextButton && showPrevButton)
                          Container(
                            width: padding30,
                          ),
                        if (!showNextButton)
                          InkWell(
                            onTap: () {
                              if (onFinishPress != null) {
                                logEvent.showCaseEvent(
                                    page: page,
                                    buttonLabel: "close".tr,
                                    type: title);
                                onFinishPress();
                                controller.next();
                              } else {
                                null;
                              }
                            },
                            child: Container(
                              width: screenWidth / 2.5,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(padding5),
                                border:
                                    Border.all(color: whiteColor, width: 1.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: padding8, horizontal: padding15),
                                child: Text("close".tr,
                                    style: myStyle.myFontStyle(
                                        fontSize: fontSize16,
                                        fontWeight: FontWeight.bold,
                                        color: whiteColor)),
                              ),
                            ),
                          ),
                      ],
                    )),
              ],
            );
          },
        ),
      ],
      alignSkip: showSkipBottom ? Alignment.bottomRight : Alignment.topRight,
      shape: shape ?? ShapeLightFocus.RRect,
      radius: radius ?? padding10,
    );
  }

  calculateAge(String birthDate) {
    var dateNow = DateTime.now();
    var givenDate = birthDate;
    var givenDateFormat = DateTime.parse(givenDate);
    var diff = dateNow.difference(givenDateFormat);
    var year = ((diff.inDays) / 365).round();
    return year.toString();
  }

  Widget getKycRejectionCard(
    String reasons,
  ) {
    return RoundedContainer(
      radius: padding16,
      margin: const EdgeInsets.all(padding16),
      padding: const EdgeInsets.all(padding16),
      backgroundColor: kycRejectBeigeColor,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: padding16, vertical: padding10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'your_kyc_verification_failed'.tr,
              style: myStyle.myFontStyle(
                  color: kycRejectTitleColor,
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize16),
            ),
            const SizedBox(
              height: padding12,
            ),
            Text(
              "${'sorry_kyc_verification_failed'.tr} $reasons ${"please_try_again".tr}.",
              style: myStyle.myFontStyle(
                color: violetDarkColor,
                fontWeight: FontWeight.w400,
                fontSize: fontSize10,
              ),
            ),
            // const SizedBox(
            //   height: padding20,
            // ),
            // MyButton(
            //   onPressed: () => {},
            //   minimumSize: const Size(padding120, padding40),
            //   title: "retry".tr,
            //   textStyle: myStyle.defaultButtonTextStyle(
            //       fontSize: fontSize16, fontWeight: FontWeight.w500),
            // ),
          ],
        ),
      ),
    );
  }

  Widget addMoneyButton(
      {bool? visibility,
      EdgeInsetsGeometry? padding,
      VoidCallback? onTap,
      double? fontSize}) {
    return Visibility(
      visible: visibility ?? false,
      child: InkWell(
        onTap: onTap,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(44),
            child: Container(
              padding: padding,
              color: primaryColor,
              child: Text(
                'add_money'.tr,
                style: myStyle.myFontStyle(
                    color: whiteColor,
                    fontSize: fontSize ?? fontSize10,
                    fontWeight: FontWeight.w600),
              ),
            )),
      ),
    );
  }

  void overlayInfoNote({
    String? message,
    bool descriptionAvailable = false,
    String? title,
    String? firstDesc,
    String? secondDesc,
    String? firstAmount,
    String? secondAmount,
    bool dismissible = true,
  }) {
    Get.dialog(
        barrierDismissible: dismissible,
        WillPopScope(
          onWillPop: () async {
            return dismissible;
          },
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: padding10),
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: padding26, vertical: padding26),
                padding: const EdgeInsets.symmetric(
                    horizontal: padding26, vertical: padding10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Get.theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(padding20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: padding10),
                            child: Text(
                              title ?? "alert".tr,
                              textAlign: TextAlign.start,
                              style: myStyle.myFontStyle(
                                color:
                                    Get.isDarkMode ? whiteColor : primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: fontSizeL,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.close,
                            size: 25,
                          ),
                          padding: const EdgeInsets.only(top: padding10),
                          onPressed: () {
                            Get.back();
                          },
                        )
                      ],
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: padding16),
                        child: descriptionAvailable
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(firstDesc!,
                                          textAlign: TextAlign.start,
                                          style: myStyle.myFontStyle(
                                            fontSize: fontSizeM,
                                          )),
                                      myWidget.getRupeeText(
                                        firstAmount ?? '0',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(secondDesc!,
                                          textAlign: TextAlign.start,
                                          style: myStyle.myFontStyle(
                                            fontSize: fontSizeM,
                                          )),
                                      myWidget.getRupeeText(
                                        secondAmount ?? '0',
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : Text(message ?? '',
                                textAlign: TextAlign.start,
                                style: myStyle.myFontStyle(
                                  fontSize: fontSizeM,
                                ))),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget get _divider {
    return Expanded(
      child: Divider(
        endIndent: 20,
        indent: 10,
        color: Get.isDarkMode ? grayLightColor : blackColor,
        height: padding35,
      ),
    );
  }

  get rbiPopUp {
    return showPopUp(
      'As per the latest RBI circular dated 16th August, 2024, we are revamping our system as per the revised guidelines. Lend fund requests have been temporarily paused on our platform.',
      title: 'Lend Fund Request Temporarily Paused',
    );
  }
}

final myWidget = MyWidget();
