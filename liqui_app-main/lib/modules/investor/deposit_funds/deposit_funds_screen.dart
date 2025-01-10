import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/global/widgets/my_choice_chip.dart';
import 'package:liqui_app/global/widgets/my_debouncer.dart';
import 'package:liqui_app/modules/investor/deposit_funds/controllers/deposit_funds_controller.dart';
import 'package:liqui_app/modules/investor/deposit_funds/models/label_list_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../global/utils/storage/my_local.dart';
import 'models/chart_data.dart';

class DepositFunds extends GetView<DepositFundsController> {
  const DepositFunds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => Scaffold(
          // resizeToAvoidBottomInset: false,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          appBar: MyAppBar(
            title: 'invest_funds'.tr,
            actions: [
              myWidget.folioSelectionRow(
                  margin: const EdgeInsets.symmetric(horizontal: padding10))
            ],
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            onDismissPressed: controller.retryError.value == "max_invest"
                ? null
                : () => controller.updateLoading(),
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
                        schemeWidget(),
                        showSizedBox(sHeight: padding16),
                        Text(
                            controller.selectedSchemeTypeIndex.value == 0
                                ? "withdraw_anytime".tr
                                : controller.selectedSchemeTypeIndex.value == 1
                                    ? "withdraw_specific_tenure".tr
                                    : "",
                            style: myStyle.myFontStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: padding16,
                                color: Get.isDarkMode
                                    ? grayLightColor
                                    : grayDarkColor)),
                        showSizedBox(sHeight: padding16),
                        chooseFolioInput(),
                        showSizedBox(sHeight: padding16),
                        noteWidget(
                            'investment_limit'.tr,
                            controller.maxInvestController.minInvestmentAmount
                                .toString(),
                            controller.maxInvestController.maxInvestmentAmount
                                .toString()),
                        showSizedBox(sHeight: padding10),
                        amountInputField(),
                        showSizedBox(sHeight: padding5),
                        amountChoiceChip(),
                        showSizedBox(sHeight: padding20),
                        payoutChoiceChip(),
                        showSizedBox(sHeight: padding20),
                        lockInSlider(),
                        Visibility(
                            visible: controller.isLockIn,
                            child: showSizedBox(sHeight: padding20)),
                        earnedInterest(),
                        if (controller.amountErrorMsg != null &&
                            controller.divs.isEmpty &&
                            controller.isLockIn)
                          myWidget.noItemFound('no_scheme_available'.tr),
                        licenseWidget(),
                      ],
                    ),
                  ),
                ),
                MyButton(
                  margin: const EdgeInsets.all(padding16),
                  onPressed: !controller.disableButton.value
                      ? () => controller.investNow()
                      : null,
                  title: 'invest_now'.tr,
                ),
              ],
            ),
          ),
        ));
  }

  Widget schemeWidget() {
    return SizedBox(
      key: controller.schemeTypeKey,
      height: padding50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.schemeTypeLabelList.length,
        itemBuilder: (_, index) => Obx(
          () => customChoiceChip(
            chipItemList: controller.schemeTypeLabelList,
            index: index,
            selected: controller.selectedSchemeTypeIndex.value == index,
            selectedValue: controller.selectedSchemeTypeIndex.value,
            horizontalPadding: padding40,
            onSelected: (value) {
              controller.schemeTenure = null;
              controller.filterSchemeChoiceWise(
                  selectedMHPPosition: controller.divs.indexOf(
                controller.selectedMHP.value,
              ));
              if (value) controller.onSchemeTypeChanged(index);
            },
          ),
        ),
      ),
    );
  }

  Widget chooseFolioInput() {
    return MyInputField(
      key: controller.chooseFolioKey,
      controller: controller.folioController..text = myLocal.ifaName,
      label: 'choose_folio'.tr,
      hint: "Selected Folio Name",
      keyboardType: TextInputType.number,
      errorMaxLines: 2,
      labelStyle: myStyle.myFontStyle(
          fontSize: fontSize14,
          fontWeight: FontWeight.w500,
          color: Get.isDarkMode ? whiteColor : fontHintColor),
      onTap: () => {
        myHelper.chooseFolio(
          page: "page_${depositFundsScreen.substring(1)}",
          source: "drop_down_invest_fund".tr,
          showIfaChangeConfirmation: true,
          ifaChangeConfirmationMsg: "add_money_ifa_change_confirmation".tr,
        ),
      },
      readOnly: true,
      suffix: const Icon(Icons.arrow_drop_down, color: primaryColor),
    );
  }

  Widget amountInputField() {
    return Column(
      key: controller.amountToInvestKey,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: padding8),
          child: Row(
            children: [
              Flexible(
                child: Text(
                  'amount_to_invest'.tr + (" (Min. "),
                  style: myStyle.myFontStyle(
                      fontWeight: FontWeight.w500, fontSize: fontSize14),
                ),
              ),
              myWidget.getRupeeText(
                  controller.maxInvestController.minInvestmentAmount.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize12),
              Text(
                "-Max. ",
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w500, fontSize: fontSize12),
              ),
              myWidget.getRupeeText(
                  controller.maxInvestController.maxInvestmentAmount.toString(),
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize12),
              Text(
                ")",
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w500, fontSize: fontSize12),
              ),
            ],
          ),
        ),
        MyInputField(
          errorMaxLines: 2,
          focusNode: controller.focusNode,
          controller: controller.amountController,
          keyboardType: TextInputType.number,
          errorText: controller.amountErrorMsg,
          errorStyle: myStyle.myFontStyle(
              fontWeight: FontWeight.w400,
              fontSize: controller.isLiquid ? fontSize10 : fontSize8,
              color: redColor),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          // label: 'amount_to_invest'.tr +
          //     (" (Min. $rupeeSymbol ${myHelper.currencyFormat.format(controller.dashboardController.minInv)} - Max. $rupeeSymbol ${myHelper.currencyFormat.format(double.parse(controller.maxInvest.value))})")
          // (" (Min.${myWidget.getRupeeText("${controller.dashboardController.minInv}")} - Max. $rupeeSymbol ${myHelper.currencyFormat.format(double.parse(controller.maxInvest.value))})")
          // ,
          hint: '0',
          autoValidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            return controller.amountErrorMsg;
          },
          onChanged: (val) {
            myDeBouncer.run(() {
              if (controller.amountErrorMsg == null) {
                controller.callGetAmountReturn();
              }
              controller.updateButtonStatus();
            });
          },
        ),
      ],
    );
  }

  Widget amountChoiceChip() {
    return SizedBox(
      height: padding50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          //physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.amountList.length,
          itemBuilder: (_, index) => Obx(() => customChoiceChip(
              chipItemList: controller.amountList,
              index: index,
              selected: controller.selectedAmountIndex.value == index,
              selectedValue: controller.selectedAmountIndex.value,
              showSelected: false,
              height: padding35,
              fontFamily: '',
              onSelected: (value) {
                if (controller.amountMap.values.elementAt(index) !=
                    controller.amountController.text) {
                  controller.onAmountChipChanged(index);
                }
              }))),
    );
  }

  Widget payoutChoiceChip() {
    return Obx(
      () => Visibility(
        visible: !controller.isSliderChartDisable.value,
        child: SizedBox(
          height: padding50,
          child: Row(
            key: controller.payOutTypeKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: padding10),
                child: Text('interest_payout'.tr,
                    style: myStyle.myFontStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSize14,
                        color:
                            Get.isDarkMode ? grayLightColor : grayDarkColor)),
              ),
              Container(
                width: padding200,
                alignment: Alignment.bottomCenter,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.payoutTypeList.length,
                  itemBuilder: (_, index) => Obx(
                    () => customChoiceChip(
                      chipItemList: controller.payoutTypeList,
                      index: index,
                      selected:
                          controller.selectedPayoutTypeIndex.value == index,
                      selectedValue: controller.selectedPayoutTypeIndex.value,
                      height: padding32,
                      width: padding85,
                      onSelected: (value) {
                        controller.filterSchemeChoiceWise(
                            selectedMHPPosition: controller.divs.indexOf(
                          controller.selectedMHP.value,
                        ));
                        if (value) controller.onPayoutTypeChanged(index);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget lockInSlider() {
    return Obx(
      () => (controller.isLockIn) && !controller.isSliderChartDisable.value
          ? Column(
              key: controller.lockInTenureKey,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('lock-in_tenure'.tr,
                        style: myStyle.myFontStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: fontSize14,
                            color:
                                Get.isDarkMode ? whiteColor : fontHintColor)),
                    Text(
                      '${controller.selectedSchemeModel?.lockinMonth ?? 0} ${controller.selectedSchemeModel?.lockinType ?? "months".tr}',
                      style: myStyle.myFontStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: fontSize14,
                          color: Get.isDarkMode ? whiteColor : violetDarkColor),
                    ),
                  ],
                ),
                if (controller.divs.length > 1)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: padding20, bottom: padding5),
                    child: SfSlider(
                        min: 0.0,
                        max: controller.divs.length - 1,
                        showTicks: true,
                        stepSize: 1,
                        interval: 1,
                        showLabels: true,
                        value: controller.divs
                            .indexOf(controller.selectedMHP.value),
                        labelFormatterCallback:
                            (dynamic actualValue, String formattedText) {
                          return controller.divs.isNotEmpty
                              ? (controller
                                      .divs[((actualValue as double).toInt())]
                                      .toString() +
                                  controller.divsAddedText[actualValue.toInt()])
                              : '';
                        },
                        onChanged: (newValues) => {
                              controller.schemeTenure = null,
                              controller.folioSchemeId = '',
                              controller.selectedMHP.value =
                                  controller.divs.isNotEmpty
                                      ? controller
                                          .divs[(newValues as double).toInt()]
                                      : 0,
                              controller.filterSchemeChoiceWise(
                                  selectedMHPPosition: newValues.toInt()),
                              //controller.months.value = controller.selectedIndex.value.toString(),
                            }),
                  ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }

  Widget earnedInterest() {
    return Obx(
      () => Visibility(
        visible: controller.amountErrorMsg == null &&
            !controller.isSliderChartDisable.value,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: padding10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.earnedInterestText,
                    style: myStyle.myFontStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: fontSize14,
                    ),
                  ),
                  Obx(() => controller.fetchingInterest.value
                      ? Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: padding5),
                          child: myWidget.defaultAppLoader(size: 20),
                        )
                      : SizedBox(
                          key: controller.interestEarnedKey,
                          child: myWidget.getRupeeText(
                              '${controller.totalInterest}',
                              fontWeight: FontWeight.w700,
                              fontSize: padding24,
                              color: greenDarkColor),
                        )),
                  Row(
                    key: controller.annualizedReturnKey,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${controller.rateOfInterest.value}% ',
                          style: myStyle.myFontStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: padding14,
                              color: Get.isDarkMode
                                  ? whiteColor
                                  : violetDarkColor)),
                      Text('annualized_returns'.tr,
                          style: myStyle.myFontStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: padding14,
                              color: Get.isDarkMode ? whiteColor : blackColor)),
                    ],
                  )
                ],
              ),
              // Flexible(
              //   child: MyOutlinedButton(
              //     key: controller.compareReturnsKey,
              //     minimumSize: const Size(padding30, padding40),
              //     onPressed: () {
              //       logEvent.buttonCompareReturns(
              //           page: "page_${depositFundsScreen.substring(1)}",
              //           schemeType:
              //               controller.isLiquid ? 'liquid'.tr : 'lock-in'.tr,
              //           schemeId:
              //               controller.selectedSchemeModel!.schemeId!.toInt());
              //       if (!controller.isAmountControllerEmpty) {
              //         validateCompareReturn(
              //             controller.selectedMHP.value.toString());
              //       } else {
              //         Get.showSnackBar('Please enter amount to proceed');
              //       }
              //     },
              //     title: 'compare_return'.tr,
              //     textStyle: myStyle.myFontStyle(
              //         fontSize: fontSize12,
              //         fontWeight: FontWeight.w400,
              //         color: primaryColor),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget customChoiceChip(
      {required List<LabelListModel> chipItemList,
      required int index,
      required bool selected,
      required int selectedValue,
      ValueChanged<bool>? onSelected,
      double? horizontalPadding,
      String? fontFamily,
      bool showSelected = true,
      double? height,
      double? width}) {
    final newDisable = chipItemList[index].isDisabled;
    return MyChoiceChip(
      label: Container(
        height: height ?? padding40,
        width: width,
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding ?? padding10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(padding5)),
          border: Border.all(
            color: newDisable ? grayColor : primaryColor,
            width: padding1,
          ),
        ),
        child: Container(
          height: padding40,
          alignment: Alignment.center,
          child: Text(
            chipItemList[index].title,
          ),
        ),
      ),
      selected: selected,
      onSelected: newDisable ? (val) => {} : onSelected,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(padding5))),
      labelStyle: myStyle.myFontStyle(
          fontSize: padding12,
          fontWeight: FontWeight.w500,
          color: newDisable
              ? darkGrayColor
              : showSelected
                  ? selectedValue == index
                      ? whiteColor
                      : primaryColor
                  : primaryColor,
          fontFamily: fontFamily),
      labelPadding: const EdgeInsets.all(0),
      selectedColor:
          showSelected ? primaryColor : Get.theme.scaffoldBackgroundColor,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      disabledColor: newDisable ? grayColor : null,
    );
  }

  Widget circleTitle(Color? color, String title) {
    return Row(
      children: [
        RoundedContainer(
          radius: padding20,
          height: padding10,
          width: padding10,
          backgroundColor: color,
          margin: const EdgeInsets.only(right: padding10),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: padding12),
        )
      ],
    );
  }

  Widget noteWidget(String title, String minAmount, String maxAmount) {
    return Visibility(
      visible: false,
      child: Container(
        color: kycBeigeColor,
        padding: const EdgeInsets.all(padding15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: myStyle.defaultTitleFontStyle,
            ),
            Row(
              children: [
                myWidget.getRupeeText(
                  minAmount,
                  fontSize: fontSize14,
                  color: Get.isDarkMode ? whiteColor : fontDesColor,
                  fontWeight: FontWeight.w800,
                ),
                Text(
                  " - ",
                  style: myStyle.defaultTitleFontStyle,
                ),
                myWidget.getRupeeText(
                  maxAmount,
                  fontSize: fontSize14,
                  color: Get.isDarkMode ? whiteColor : fontDesColor,
                  fontWeight: FontWeight.w800,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showSizedBox({double? sHeight, bool? visibility}) {
    return Visibility(
        visible: visibility ?? true,
        child: SizedBox(height: sHeight ?? padding24));
  }

  Widget licenseWidget() {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: padding10),
        child: Text(
          myLocal.appConfig.netWorthCertificateMessage!,
          style: myStyle.myFontStyle(fontSize: fontSize12),
        ));
  }

  void validateCompareReturn(dynamic month) {
    var principal = num.parse(controller.amountController.text);
    //var roi = num.parse(controller.rateOfInterest.value);
    var tenure = num.parse(month); //in months
    if (controller.isLiquid) {
      tenure = controller.isGrowth ? 12 : 1;
    } else {
      tenure = controller.isGrowth ? tenure : 1;
    }
    //num llInterest = simpleInterestCalculator(principal, roi, tenure);
    num llInterest = num.parse(controller.totalInterest.value);
    num savingInterest = simpleInterestCalculator(
        principal, myLocal.appConfig.savingRoi ?? 0, tenure);
    num fdInterest = simpleInterestCalculator(
        principal, myLocal.appConfig.fdRoi ?? 0, tenure);
    final List<ChartData> llChartData = [
      ChartData(0, 0),
      ChartData(tenure, llInterest),
    ];
    final List<ChartData> savingChartData = [
      ChartData(0, 0),
      ChartData(tenure, fdInterest),
    ];
    final List<ChartData> fdChartData = [
      ChartData(0, 0),
      ChartData(tenure, savingInterest),
    ];
    if (controller.isAmountControllerEmpty || tenure == 0) {
      Get.showSnackBar('select_amount_tenure'.tr);
      return;
    } else {
      Get.bottomSheet(
          SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.scaffoldBackgroundColor,
                  border: Border.all(color: transparentColor),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(padding20),
                      topRight: Radius.circular(padding20))),
              padding: const EdgeInsets.all(padding20),
              child: SafeArea(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showSizedBox(sHeight: padding10),
                      Text(
                        'comparative_returns'.tr,
                        style: myStyle.defaultTitleFontStyle,
                      ),
                      showSizedBox(),
                      // Text(
                      //   '${'if_you_invest'.tr} '
                      //       '${'$rupeeSymbol${controller.amountController.text}'}',
                      //   style: myStyle.defaultFontStyle,
                      // ),
                      Row(
                        children: [
                          Text(
                            '${'if_you_invest'.tr} ',
                            style: myStyle.defaultFontStyle,
                          ),
                          myWidget.getRupeeText(
                              controller.amountController.text,
                              fontSize: fontSize14,
                              color: Get.isDarkMode ? whiteColor : fontDesColor)
                        ],
                      ),
                      showSizedBox(),
                      Text(
                        'with_liquimoney_it_will'.tr,
                      ),
                      showSizedBox(sHeight: padding5),
                      myWidget.getRupeeText(
                          controller.isLockIn
                              ? controller.isGrowth
                                  ? ((num.parse(
                                              controller.totalInterest.value) +
                                          num.parse(controller
                                              .schemeReturnAmount
                                              .principalAmount!)))
                                      .toStringAsFixed(2)
                                  : ((num.parse(controller.totalInterest
                                              .value)) /**
                              (num.parse(controller
                              .selectedIndex.value
                              .toString()))) */
                                          +
                                          num.parse(controller
                                              .schemeReturnAmount
                                              .principalAmount!))
                                      .toStringAsFixed(2)
                              : (controller.schemeReturnAmount.accruedValue!)
                                  .toStringAsFixed(2),
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: padding20),
                      showSizedBox(sHeight: padding32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          circleTitle(Colors.green, 'liqui_money'.tr),
                          circleTitle(violetDarkColor, 'saving_account'.tr),
                          circleTitle(primaryColor, 'fixed_deposit'.tr),
                        ],
                      ),
                      showSizedBox(sHeight: padding30),
                      //Initialize the chart widget
                      SfCartesianChart(
                          primaryXAxis: NumericAxis(
                            title: AxisTitle(
                                text: 'tenure_in_months'.tr,
                                textStyle: myStyle.myFontStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: padding14,
                                    color: redColor)),
                          ),
                          primaryYAxis: NumericAxis(
                              numberFormat: NumberFormat.simpleCurrency(
                                  name: rupeeSymbol)),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<ChartData, dynamic>>[
                            SplineSeries<ChartData, num>(
                              dataSource: llChartData,
                              color: Colors.green,
                              xValueMapper: (ChartData data, _) => data.tenure,
                              yValueMapper: (ChartData data, _) => data.returns,
                              name: 'liquiloans'.tr,
                            ),
                            SplineSeries<ChartData, num>(
                              dataSource: fdChartData,
                              color: violetDarkColor,
                              xValueMapper: (ChartData data, _) => data.tenure,
                              yValueMapper: (ChartData data, _) => data.returns,
                              name: 'fixed_deposit'.tr,
                            ),
                            SplineSeries<ChartData, num>(
                              dataSource: savingChartData,
                              color: primaryColor,
                              xValueMapper: (ChartData data, _) => data.tenure,
                              yValueMapper: (ChartData data, _) => data.returns,
                              name: 'saving'.tr,
                            )
                          ]),
                      Text(
                        'returns_from_other_tools'.tr,
                        style: myStyle.defaultTitleFontStyle,
                      ),
                      showSizedBox(sHeight: padding15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'saving_account'.tr,
                            style: myStyle.defaultFontStyle,
                          ),
                          myWidget.getRupeeText(
                            '${(int.parse(controller.amountController.text) + savingInterest)}'
                                .toString(),
                            fontWeight: FontWeight.w800,
                            fontSize: fontSize14,
                            color: Get.isDarkMode ? whiteColor : fontDesColor,
                            // style: myStyle.defaultTitleFontStyle,
                          ),
                        ],
                      ),
                      showSizedBox(sHeight: padding10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'fixed_deposit'.tr,
                            style: myStyle.defaultFontStyle,
                          ),
                          myWidget.getRupeeText(
                            '${(int.parse(controller.amountController.text) + fdInterest)}'
                                .toString(),
                            fontWeight: FontWeight.w800,
                            fontSize: fontSize14,
                            color: Get.isDarkMode ? whiteColor : fontDesColor,
                          ),
                        ],
                      ),
                      showSizedBox(sHeight: padding10),
                      Text(
                        myLocal.appConfig.roiSourceMessage!,
                        style: myStyle.myFontStyle(
                          fontSize: fontSize14,
                          color: Get.isDarkMode ? whiteColor : fontDesColor,
                        ),
                      )
                    ]),
              ),
            ),
          ),
          isScrollControlled: true);
    }
  }

  num simpleInterestCalculator(num principal, num roi, num tenure) {
    var amount = (principal * (roi / 100)) / 12;
    var interest = (amount * tenure).round();
    // printLog('principal $principal, roi $roi, tenure $tenure, interest $interest');
    return interest;
  }
}
