import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

import '../../../../global/constants/app_constants.dart';
import '../../../../global/utils/helpers/my_helper.dart';
import '../../../global/widgets/index.dart';
import '../bank_accounts/controllers/bank_accounts_controller.dart';

class BankAccounts extends GetView<BankAccountsController> {
  // final TransactionsController trans = Get.find();
  // final DashboardController dash = Get.find();
  // final ProfileController profile = Get.find();

  const BankAccounts({Key? key}) : super(key: key);

  void updateFolioDetails() {
    controller.fetchInvestorBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(
      () => Scaffold(
        appBar: MyAppBar(
          title: 'my_bank_account'.tr,
          actions: [
            myWidget.folioSelectionRow(
              margin: const EdgeInsets.symmetric(horizontal: padding10),
            ),
          ],
        ),
        body: OverlayScreen(
          isLoading: controller.isLoading.value,
          errorMessage: controller.errorMsg.value,
          onRetryPressed: () => controller.handleRetryAction(),
          backgroundColor: controller.overlayLoading.value
              ? Get.isDarkMode
                  ? Colors.black54
                  : Colors.white54
              : Get.theme.scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyInputField(
                  controller: controller.folioController
                    ..text = myLocal.ifaName,
                  label: 'choose_folio'.tr,
                  hint: "Selected Folio Name",
                  keyboardType: TextInputType.number,
                  onTap: () => {
                    myHelper.chooseFolio(
                      page: "page_${bankAccountsScreen.substring(1)}",
                      source: 'button_my_bank_account',
                      onChanged: () => updateFolioDetails(),
                    ),
                  },
                  readOnly: true,
                  suffix:
                      const Icon(Icons.arrow_drop_down, color: primaryColor),
                ),
                const SizedBox(
                  height: padding16,
                ),
                Text('your_bank_accounts'.tr,
                    style: myStyle.myFontStyle(
                        fontWeight: FontWeight.bold, fontSize: padding16)),
                Expanded(
                    child: controller.bankListData.isNotEmpty
                        ? ListView.separated(
                            // the number of items in the list
                            itemCount: controller.bankListData.length,
                            physics: const BouncingScrollPhysics(),
                            // display each item of the product list
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.symmetric(vertical: padding16),
                            itemBuilder: (context, index) {
                              return Card(
                                key: ValueKey(
                                    controller.bankListData[index].toString()),
                                child: Padding(
                                  padding: const EdgeInsets.all(padding10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "account_details".tr,
                                                  style: myStyle.myFontStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Get.isDarkMode
                                                          ? grayLightColor
                                                          : greyColor),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: padding8,
                                                          bottom: padding8),
                                                  child: Text(
                                                    controller
                                                        .bankListData[index]
                                                        .accountNumber
                                                        .toString(),
                                                    style: myStyle.myFontStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Get.isDarkMode
                                                          ? grayLightColor
                                                          : greyColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: padding16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.account_balance,
                                                  size: padding50,
                                                  color: primaryColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.bankListData[index].ifsc
                                                .toString(),
                                            style: myStyle.myFontStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Get.isDarkMode
                                                    ? whiteColor
                                                    : blackColor),
                                          ),
                                          Text(
                                            controller
                                                .bankListData[index].bankName
                                                .toString(),
                                            style: myStyle.myFontStyle(
                                                fontWeight: FontWeight.w500,
                                                color: Get.isDarkMode
                                                    ? whiteColor
                                                    : fontHintColor),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          if (controller
                                                  .bankListData[index].kycStatus
                                                  .toString() ==
                                              'NotVerified')
                                            Text(
                                              'not_verified'.tr,
                                              style: myStyle.myFontStyle(
                                                fontWeight: FontWeight.w500,
                                                color: redColor,
                                              ),
                                            )
                                          else if (controller
                                                  .bankListData[index].isDefault
                                                  .toString() ==
                                              'Yes')
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: padding10,
                                                  bottom: padding10),
                                              child: myHelper.getAssetImage(
                                                'primary',
                                              ),
                                            )
                                          else
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors.blue,
                                                textStyle: myStyle.myFontStyle(
                                                    fontSize: padding15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () {
                                                controller.bankingId.value =
                                                    controller
                                                        .bankListData[index].id
                                                        .toString();
                                                controller
                                                    .changeDefaultBanking();
                                              },
                                              child: Text('make_primary'.tr),
                                            ),
                                          if (controller
                                                  .bankListData[index].isDefault
                                                  .toString() !=
                                              'Yes')
                                            TextButton(
                                              style: TextButton.styleFrom(
                                                foregroundColor: redColor,
                                                textStyle: myStyle.myFontStyle(
                                                    fontSize: padding15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onPressed: () {
                                                controller.bankingId.value =
                                                    controller
                                                        .bankListData[index].id
                                                        .toString();
                                                controller.deleteBankApiCall();
                                              },
                                              child: Text('delete'.tr),
                                            ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: padding16,
                              );
                            },
                          )
                        : myWidget.noItemFound("No record found")),
                MyOutlinedButton(
                    avoidIntrusions: true,
                    margin: const EdgeInsets.symmetric(vertical: padding16),
                    onPressed: () {
                      if (myHelper.isIFAValid()) {
                        logEvent.buttonAddBankAccount(
                            page: "page_${bankAccountsScreen.substring(1)}");
                        Get.toNamed(addBankAccountScreen,
                            arguments: {"add_another_bank": true});
                      }
                    },
                    title: "add_bank".tr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
