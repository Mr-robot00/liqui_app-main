import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';

import 'controllers/transactions_controller.dart';

class Transactions extends GetView<TransactionsController> {
  const Transactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SafeArea(
      top: false,
      child: Obx(() {
        /// updating the value for try_again for dashboard
        controller.homeController.transactionsRetry =
            (controller.isLoading.value && !controller.showShimmer.value) &&
                controller.errorMsg.value.validString;

        return OverlayScreen(
          isFromMainScreens: true,
          isLoading:
              controller.isLoading.value && !controller.showShimmer.value,
          errorMessage: controller.errorMsg.value,
          onRetryPressed: () => controller.handleRetryAction(),
          child: Scaffold(
            appBar: customAppBar,
            body: body,
          ),
        );
      }),
    );
  }

  AppBar get customAppBar {
    return AppBar(
      backgroundColor: violetDarkColor,
      titleSpacing: 0,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: padding24),
        height: screenHeight * 0.18,
        width: screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: padding24),
            Text(
              'transactions'.tr,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize20,
                  color: whiteColor),
            ),
            const SizedBox(height: padding24),
            Text(
                // '${"total".tr} ${controller.myTabs[controller.selectedIndex.value].text} ${"amount".tr}',
                titleText,
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: fontSize12,
                    color: grayLightColor.withOpacity(0.7))),
            const SizedBox(height: padding8),
            myWidget.getRupeeText(
                controller.selectedIndex.value == 0
                    ? (controller
                            .dashboard()
                            .dashboardDetails
                            .portfolioValue
                            ?.toStringAsFixed(2) ??
                        "0.00")
                    : controller.totalAmount.toStringAsFixed(2),
                fontWeight: FontWeight.w700,
                fontSize: fontSize20,
                color: whiteColor),
          ],
        ),
      ),
      toolbarHeight: screenHeight * 0.18,
      bottom: TabBar(
        controller: controller.tabController,
        tabs: controller.myTabs,
        labelColor: primaryColor,
        unselectedLabelColor: whiteColor,
        onTap: controller.updateSelectedIndex,
        indicatorPadding: const EdgeInsets.only(left: 15, right: 15),
        indicatorWeight: padding4,
      ),
    );
  }

  String get titleText {
    var tabTitleList = myLocal
        .appConfig.transactionTabs![controller.selectedIndex.value].tabHeader;
    return tabTitleList!;
  }

  Widget get body {
    return controller.showShimmer.value
        ? myShimmer.transactionsShimmer
        : TabBarView(
            controller: controller.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.myTabs.map((Tab tab) {
              return Obx(() => transactionList);
            }).toList());
  }

  Widget get transactionList {
    return RefreshIndicator(
      onRefresh: controller.onPullRefresh,
      child: Stack(
        children: [
          ListView.builder(
              itemCount: controller.transactions.length,
              physics: const AlwaysScrollableScrollPhysics(),
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                final trans = controller.transactions[index];
                // final transactionStatus = controller.txnStatus(
                //   trans.transactionSubType!,
                //   trans.displayStatus,
                // );
                return Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: padding16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: padding14),
                              Row(
                                children: [
                                  myWidget.getRupeeText(
                                    '${trans.amount}',
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSize16,
                                    color: Get.isDarkMode
                                        ? whiteColor
                                        : fontTitleColor,
                                  ),
                                  SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: RawMaterialButton(
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        final list = controller
                                            .getWithdrawDetails(index);
                                        myWidget.overlayInfoNote(
                                          descriptionAvailable: true,
                                          title: 'withdrawal_breakup'.tr,
                                          firstDesc: '${'principal'.tr}: ',
                                          secondDesc: '${'interest'.tr}: ',
                                          firstAmount: list[0].toString(),
                                          secondAmount: list[1].toString(),
                                        );
                                      },
                                      child: Icon(
                                        Icons.info_outline,
                                        size: 16,
                                        color: darkGrayColor.withOpacity(0.7),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              controller.selectedIndex.value == 0
                                  ? Text(
                                      controller.txnTypeLabel(
                                          trans.transactionSubType,
                                          trans.transactionSubSubType),
                                      // trans.transactionSubType == "AddMoney"
                                      //     ? "credited".tr
                                      //     : trans.transactionSubType ==
                                      //             "WithdrawMoney"
                                      //         ? "debited".tr
                                      //         : (trans.transactionSubType !=
                                      //                     null &&
                                      //                 trans.transactionSubSubType ==
                                      //                     "monthly_interest_repayment"
                                      //                         .tr)
                                      //             ? "interest_payout".tr
                                      //             : "",
                                      style: myStyle.myFontStyle(
                                          color: Get.isDarkMode
                                              ? primaryColor
                                              : portfolioCardColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSize12),
                                    )
                                  : Text(
                                      dtHelper
                                          .ddMMMMYYYY(trans.transactionDate!),
                                      style: myStyle.myFontStyle(
                                          color: Get.isDarkMode
                                              ? primaryColor
                                              : portfolioCardColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSize12),
                                    ),
                              controller.selectedIndex.value == 0
                                  ? Text(
                                      dtHelper
                                          .ddMMMMYYYY(trans.transactionDate!),
                                      style: myStyle.myFontStyle(
                                          color: Get.isDarkMode
                                              ? grayLightColor
                                              : darkGrayColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: fontSize12),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: padding14),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: padding16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: padding5),
                              RoundedContainer(
                                radius: 45,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: padding10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: padding8, vertical: padding4),
                                backgroundColor: controller
                                    .txnStatusColor(trans.displayStatus)
                                    .withOpacity(0.2),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: padding16),
                                  child: Text(
                                    controller.txnStatus(
                                        trans.transactionSubType!,
                                        trans.displayStatus),
                                    style: myStyle.myFontStyle(
                                        color: controller.txnStatusColor(
                                            trans.displayStatus),
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSize12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: padding5),
                              Visibility(
                                visible: (trans.settlementUtr != null) &&
                                    (trans.transactionSubType ==
                                            'WithdrawMoney' &&
                                        trans.displayStatus == 'Processed'),
                                //visible: true,
                                child: Row(
                                  children: [
                                    Text(
                                      "${'utr_no'.tr} ",
                                      style: myStyle.myFontStyle(
                                          fontSize: fontSize12),
                                    ),
                                    Text(
                                      trans.settlementUtr
                                          .toString(), //'SBIN323032038826'
                                      style: myStyle.myFontStyle(
                                          fontSize: fontSize12),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${'current_value'.tr} ",
                                    style: myStyle.myFontStyle(
                                        fontSize: fontSize12),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(right: padding5),
                                    child: myWidget.getRupeeText(
                                        trans.currentValueAsOnTxnDate
                                            .toString(),
                                        fontSize: fontSize12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: padding5),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: padding2,
                      color: Get.isDarkMode
                          ? grayColor.withOpacity(0.5)
                          : grayLightColor,
                    )
                  ],
                );
              }),
          if (controller.transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(padding16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "no_transactions_to_display".tr,
                      style: myStyle.myFontStyle(fontSize: fontSize16),
                    ),
                    // const SizedBox(height: padding16),
                    // MyButton(
                    //   onPressed: controller.onPullRefresh,
                    //   title: "refresh".tr,
                    //   minimumSize: const Size(0, 40),
                    // ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget get dateWiseTrans {
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //     margin: const EdgeInsets.symmetric(vertical: 10),
                  //     child: Text(
                  //       'MM YYYY',
                  //       style: myStyle.myFontStyle(color: grayDarkColor),
                  //     )),
                  ListView.builder(
                      itemCount: controller.transactions.length,
                      physics: const ClampingScrollPhysics(),
                      // shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var trans = controller.transactions[index];
                        return Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(width: padding16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: padding14),
                                      myWidget.getRupeeText(
                                        '${trans.amount}',
                                        fontWeight: FontWeight.w700,
                                        fontSize: fontSize20,
                                        color: fontTitleColor,
                                      ),
                                      Text(
                                        dtHelper
                                            .ddMMMMYYYY(trans.transactionDate!),
                                        style: myStyle.myFontStyle(
                                            color: portfolioCardColor,
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSize14),
                                      ),
                                      const SizedBox(height: padding14),
                                    ],
                                  ),
                                ),
                                RoundedContainer(
                                  radius: 45,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: padding10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: padding8, vertical: padding4),
                                  backgroundColor: controller
                                      .txnStatusColor(trans.displayStatus)
                                      .withOpacity(0.2),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: padding16),
                                    child: Text(
                                      controller.txnStatus(
                                          trans.transactionSubType!,
                                          trans.displayStatus),
                                      style: myStyle.myFontStyle(
                                          color: controller.txnStatusColor(
                                              trans.displayStatus),
                                          fontWeight: FontWeight.bold,
                                          fontSize: fontSize14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: padding2,
                              color: grayLightColor,
                            )
                          ],
                        );
                      }),
                ],
              );
            }),
      ],
    );
  }
}
