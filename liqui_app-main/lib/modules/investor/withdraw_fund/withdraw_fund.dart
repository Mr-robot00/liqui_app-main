import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/withdraw_fund/controllers/withdraw_fund_controller.dart';

import '../../../global/constants/index.dart';

class WithdrawFund extends GetView<WithdrawFundController> {
  // @override
  // final controller = Get.put(WithdrawFundController());

  // final TransactionsController trans = Get.find();

  const WithdrawFund({Key? key}) : super(key: key);

  updateFolioDetails() {
    controller.amountController.clear();
    controller.fetchInvestorBankDetails();
    controller.validateForm();
  }

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => Scaffold(
          appBar: MyAppBar(
            title: 'withdraw_screen'.tr,
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
            onDismissPressed: () => controller.updateLoading(),
            backgroundColor: controller.overlayLoading.value
                ? Get.isDarkMode
                    ? Colors.black54
                    : Colors.white54
                : Get.theme.scaffoldBackgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding20, vertical: padding10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyInputField(
                          controller: controller.folioController
                            ..text = myLocal.ifaName,
                          label: 'choose_folio'.tr,
                          hint: "Selected Folio Name",
                          labelStyle: myStyle.myFontStyle(
                              fontSize: fontSize14,
                              fontWeight: FontWeight.w500,
                              color:
                                  Get.isDarkMode ? whiteColor : fontHintColor),
                          keyboardType: TextInputType.number,
                          onTap: () => {
                            myHelper.chooseFolio(
                              page: "page_${withdrawFundScreen.substring(1)}",
                              source: "drop_down_withdraw_fund".tr,
                              showIfaChangeConfirmation: true,
                              ifaChangeConfirmationMsg:
                                  "withdraw_ifa_change_confirmation".tr,
                              onChanged: () => updateFolioDetails(),
                            ),
                          },
                          readOnly: true,
                          suffix: const Icon(Icons.arrow_drop_down,
                              color: primaryColor),
                        ),
                        const SizedBox(height: padding24),
                        noteWidget('withdraw_limit'.tr,
                            "${controller.dash.dashboardDetails.withdrawableBalance}"),
                        // const SizedBox(height: padding24),

                        const SizedBox(height: padding10),
                        Padding(
                          padding: const EdgeInsets.only(bottom: padding8),
                          child: Row(
                            children: [
                              Text(
                                'amount_to_withdraw'.tr + (" (Max. "),
                                style: myStyle.myFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSize14),
                              ),
                              myWidget.getRupeeText(
                                  "${controller.dash.dashboardDetails.withdrawableBalance}",
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSize14),
                              Text(
                                ")",
                                style: myStyle.myFontStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSize14),
                              ),
                            ],
                          ),
                        ),
                        MyInputField(
                          focusNode: controller.focusNode,
                          key: controller.amountToWithdrawKey,
                          counterValue: "",
                          controller: controller.amountController,
                          // label: 'amount_to_withdraw'.tr +
                          //     (" (Max. $rupeeSymbol ${myHelper.currencyFormat.format(controller.dash.dashboardDetails.withdrawableBalance)})"),
                          hint: "enter_withdrawal_amt".tr,
                          hintStyle: myStyle.myFontStyle(
                              fontSize: fontSize14, color: grayDarkColor),
                          errorStyle: myStyle.myFontStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: fontSize10,
                              color: redColor),
                          readOnly: controller.isWithDrawBalanceZero,
                          onChanged: (v) {
                            controller.validateForm();
                          },

                          maxLength: !controller.isWithDrawBalanceZero
                              ? controller
                                  .dash.dashboardDetails.withdrawableBalance
                                  .toString()
                                  .length
                              : null,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (v) {
                            // controller.validateForm();
                            if (controller.isWithDrawBalanceZero) {
                              return null;
                            }
                            if (v!.isEmpty) {
                              return "enter_withdrawal_amt".tr;
                            } else {
                              if (double.parse(v) >
                                      controller.dash.dashboardDetails
                                          .withdrawableBalance!
                                          .toDouble() ||
                                  double.parse(v) == 0) {
                                return "${"your_withdrawal_amt".tr} ${controller.dash.dashboardDetails.withdrawableBalance}";
                              } else {
                                return null;
                              }
                            }
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^(\d+)?\.?\d{0,2}')),
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d*')),
                            FilteringTextInputFormatter.deny(RegExp('^0+'))
                          ],
                        ),
                        if (controller.isWithDrawBalanceZero)
                          Padding(
                            padding: const EdgeInsets.only(top: padding16),
                            child: Text(
                              "${"your_withdrawal_amt".tr} ${controller.dash.dashboardDetails.withdrawableBalance}",
                              style: myStyle.myFontStyle(
                                  color: redColor, fontSize: padding16),
                            ),
                          ),
                        const SizedBox(
                          height: padding24,
                        ),
                        Text('withdraw_to'.tr,
                            style: myStyle.myFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSize14,
                                color: Get.isDarkMode
                                    ? grayLightColor
                                    : greyColor)),
                        const SizedBox(
                          height: padding10,
                        ),
                        IgnorePointer(
                          ignoring: controller.isWithDrawBalanceZero,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            key: controller.withdrawToBankKey,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor:
                                  Get.isDarkMode ? fontDesColor : filledColor,
                            ),
                            value: controller.selectedValue,
                            hint: Text('select_bank'.tr,
                                style: myStyle.myFontStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Get.isDarkMode
                                        ? grayLightColor
                                        : darkGrayColor)),
                            onChanged: (newValue) {
                              controller.onSelected(newValue!);
                              controller.validateForm();
                            },
                            selectedItemBuilder: (BuildContext txt) {
                              return controller.bankListData
                                  .map<Widget>((item) {
                                return DropdownMenuItem(
                                    value: item,
                                    child: bankDropDowRowItem(
                                        item.bankName!, item.isDefault!));
                              }).toList();
                            },
                            items: controller.bankListData
                                .map<DropdownMenuItem>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: padding16,
                                      vertical: padding16),
                                  // height: 10,
                                  color: controller.selectedValueRes.value ==
                                          value.id.toString()
                                      ? Colors.black12
                                      : null,
                                  child: bankDropDowRowItem(
                                      value.bankName!, value.isDefault!,
                                      isDropDown: true),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MyButton(
                    margin: const EdgeInsets.all(padding16),
                    onPressed: controller.disableButton.value
                        ? null
                        : () => controller.validateForm(true),
                    title: "withdraw".tr)
              ],
            ),
          ),
        ));
  }

  Widget bankDropDowRowItem(String bankName, String isDefault,
      {bool isDropDown = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isDropDown) ...[
          const Icon(
            Icons.account_balance,
            size: padding20,
            color: primaryColor,
          ),
          const SizedBox(
            width: padding10,
          ),
        ],
        Text(
          bankName.toString(),
          style: myStyle.myFontStyle(
            fontWeight: FontWeight.w400,
            fontSize: isDropDown ? fontSize12 : fontSize14,
            color: Get.isDarkMode ? whiteColor : blackColor,
          ),
        ),
        const SizedBox(
          width: padding20,
        ),
        if (isDropDown && isDefault == 'Yes')
          myHelper.getAssetImage('primary', height: padding20, fit: BoxFit.fill)
      ],
    );
  }

  Widget noteWidget(String title, String amount) {
    return Visibility(
      visible: false,
      child: Container(
        color: lightYellowColor,
        padding: const EdgeInsets.symmetric(
            vertical: padding10, horizontal: padding10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w400, color: darkGrayColor),
            ),
            myWidget.getRupeeText(
              amount,
              fontWeight: FontWeight.w400,
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
