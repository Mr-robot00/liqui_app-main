import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/portfolio_transaction/controllers/portfolio_transaction_controller.dart';

import '../../../global/constants/app_constants.dart';
import '../../../global/utils/my_style.dart';

class PortfolioTransaction extends GetView<PortfolioTransactionController> {
  const PortfolioTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SafeArea(
        child: Obx(
      () => OverlayScreen(
          isLoading:
              controller.isLoading.value && !controller.showShimmer.value,
          errorMessage: controller.errorMsg.value,
          onRetryPressed: () => controller.handleRetryAction(),
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    // The flexible app bar with the tabs
                    customAppBar,
                  ],
              // The content of each tab
              body: body())),
    ));
  }

  SliverAppBar get customAppBar {
    return SliverAppBar(
        expandedHeight: 200,
        pinned: true,
        backgroundColor: violetDarkColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'my_portfolio'.tr,
              style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize20,
                  color: whiteColor),
            ),
            TextButton(
              onPressed: () {
                controller.dateControllerStart.text = "";
                controller.dateControllerEnd.text = "";
                myWidget.showStatementDateSelection(
                    dateControllerStart: controller.dateControllerStart,
                    dateControllerEnd: controller.dateControllerEnd,
                    onPressed: () => controller.callPostDownloadPassbook());
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: RoundedContainer(
                border: true,
                backgroundColor: transparentColor,
                borderColor: whiteColor,
                radius: 4,
                padding: const EdgeInsets.symmetric(
                    vertical: padding5, horizontal: padding10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.file_download_outlined,
                      color: whiteColor,
                    ),
                    Text(
                      "passbook".tr,
                      style: myStyle.myFontStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: Container(
            margin: const EdgeInsets.symmetric(horizontal: padding16),
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text('total_current_value'.tr,
                      style: myStyle.myFontStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: fontSize12,
                          color: backgroundColor.withOpacity(0.7))),
                  //const SizedBox(height: padding8),
                  myWidget.getRupeeText(
                      controller
                              .investmentSummaryResponse
                              .value
                              .investmentSummary
                              ?.totalSummary
                              ?.dashboardSummary
                              ?.portfolioValue
                              .toString() ??
                          '0.0',
                      fontWeight: FontWeight.w700,
                      fontSize: fontSize24,
                      color: whiteColor),
                  const SizedBox(height: padding2),
                  Text(
                      '${controller.investmentSummaryResponse.value.investmentSummary?.totalSummary?.dashboardSummary?.annualizedReturnXiir.toString() ?? '0'}% XIRR'
                          .tr,
                      style: myStyle.myFontStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: fontSize16,
                          color: greenColor)),
                ],
              ),
            ),
          ),
        ),
        bottom: TabBar(
          controller: controller.tabController,
          tabs: controller.myTabs,
          labelColor: primaryColor,
          indicatorColor: primaryColor,
          indicatorPadding: const EdgeInsets.only(left: 35, right: 35),
          indicatorWeight: padding4,
          unselectedLabelColor: whiteColor,
          onTap: controller.updateSelectedIndex,
        ));
  }

  Widget body() {
    return controller.showShimmer.value
        ? myShimmer.portfolioTransactionShimmer
        : TabBarView(
            controller: controller.tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: controller.myTabs.map((Tab tab) {
              return Obx(() => investmentList());
            }).toList());
  }

  Widget portfolioCard() {
    return Container(
      margin: const EdgeInsets.only(
          left: padding16, right: padding16, top: padding16, bottom: padding20),
      padding: const EdgeInsets.only(
          left: padding16, right: padding16, top: padding20, bottom: padding20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: portfolioCardColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              columnTitleDesc(
                  title: 'principal_investment'.tr,
                  description: controller.totalNetPrincipalAmount.toString(),
                  tFont: fontSize12,
                  descFont: fontSize16,
                  whiteText: true),
              SizedBox(width: screenWidth / 10),
              columnTitleDesc(
                  title: 'current_value'.tr,
                  description: controller.totalAccruedValue.toString(),
                  tFont: fontSize12,
                  descFont: fontSize16,
                  alignment: CrossAxisAlignment.start,
                  whiteText: true)
              //Get.isDarkMode ? whiteColor :
            ],
          ),
          const SizedBox(
            height: padding20,
          ),
          rowTitle(
            title: 'amount_withdrawn'.tr,
            value: controller.amountRepaid.toString(),
            opacity: 0.7,
            onPressed: () => myWidget.overlayInfoNote(
                descriptionAvailable: true,
                firstDesc: 'Principal:',
                secondDesc: 'Interest:',
                firstAmount: controller.redeemedPrincipal.toString(),
                secondAmount: controller.redeemedInterest.toString(),
                title: 'amount_withdrawn'.tr),
          ),
          rowTitle(
              title: 'interest_earned'.tr,
              value: controller.totalAccruedInterest.toString(),
              opacity: 0.7,
              showIcon: false,
              onPressed: () => myWidget.overlayInfoNote(
                  descriptionAvailable: true,
                  firstDesc: 'Net Principal Amount:',
                  secondDesc: 'Accrued Interest:',
                  firstAmount: controller.totalNetPrincipalAmount.toString(),
                  secondAmount:
                      controller.totalAccruedInterest.toStringAsFixed(2),
                  title: 'current_value'.tr)),
        ],
      ),
    );
  }

  Widget investmentList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (controller.filteredScheme.isNotEmpty) ...[
          portfolioCard(),
          Container(
              width: screenWidth,
              margin: const EdgeInsets.only(left: padding10),
              child: Text(
                'active_schemes'.tr,
                style: myStyle.myFontStyle(fontWeight: FontWeight.w400),
              )),
          divider(nHeight: padding10),
        ],
        investmentCard(),
      ],
    );
  }

  Widget investmentCard() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: controller.onPullRefresh,
        child: Stack(
          children: [
            ListView.separated(
              shrinkWrap: true,
              itemCount: controller.filteredScheme.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Container(
                height: padding2,
                color: Get.isDarkMode
                    ? grayColor.withOpacity(0.5)
                    : grayLightColor,
              ),
              itemBuilder: (BuildContext context, int index) {
                var item = controller.filteredScheme[index];
                return InkWell(
                  onTap: () {
                    controller.selectedScheme = item;
                    logEvent.portfolioSelectScheme(
                        schemeId: item.schemeId.toString(),
                        schemeType: controller
                            .transType[controller.selectedIndex.value]
                            .toLowerCase(),
                        page:
                            "page_${portfolioTransactionScreen.substring(1)}");
                    Get.toNamed(
                      portfolioTransactionDetailScreen,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: padding5, horizontal: padding20),
                    padding: const EdgeInsets.symmetric(vertical: padding10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            columnTitleDesc(
                                title: 'invested'.tr,
                                description: controller
                                    .filteredScheme[index].investedAmount
                                    .toString(),
                                tFont: fontSize12,
                                descFont: fontSize14,
                                whiteText: Get.isDarkMode),
                            SizedBox(width: screenWidth / 10),
                            columnTitleDesc(
                                title: 'current_value'.tr,
                                description: controller
                                    .filteredScheme[index].accruedValue
                                    .toString(),
                                tFont: fontSize12,
                                descFont: fontSize14,
                                whiteText: Get.isDarkMode),
                          ],
                        ),
                        const SizedBox(
                          height: padding16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    '${controller.filteredScheme[index].investmentRoi.toString()}% ROI',
                                    style: myStyle.myFontStyle(
                                        color: Get.isDarkMode
                                            ? whiteColor
                                            : portfolioCardColor,
                                        fontSize: fontSize12,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${controller.filteredScheme[index].lockinTenure.toString()} MHP',
                                  style: myStyle.myFontStyle(
                                    color: Get.isDarkMode
                                        ? whiteColor
                                        : portfolioCardColor,
                                    fontSize: fontSize12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Icon(
                                  Icons.circle,
                                  size: 5,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                    '${controller.filteredScheme[index].payoutType}',
                                    style: myStyle.myFontStyle(
                                        color: Get.isDarkMode
                                            ? whiteColor
                                            : portfolioCardColor,
                                        fontSize: fontSize12,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            myWidget.addMoneyButton(
                                visibility: (controller.transType[
                                            controller.selectedIndex.value] !=
                                        "flexi_lock_in".tr) &&
                                    controller.isSchemeAvailable(
                                        schemeId: item.schemeId.toString()),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 8.0),
                                onTap: () {
                                  // logEvent.buttonAddMoney(
                                  //     page:
                                  //         "page_${portfolioTransactionScreen.substring(1)}",
                                  //     source:
                                  //         "page_${portfolioTransactionScreen.substring(1)}");
                                  // controller.clickAddMoney(
                                  //     schemeId: item.schemeId.toString(),
                                  //     schemeTypeIndex: controller.transType[
                                  //                 controller
                                  //                     .selectedIndex.value] ==
                                  //             "liquid".tr
                                  //         ? 0
                                  //         : 1);
                                  myWidget.rbiPopUp;
                                }),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            if (controller.filteredScheme.isEmpty)
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
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget rowTitle(
      {required String title,
      required String value,
      bool showIcon = true,
      bool isAmount = true,
      double? opacity,
      VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: padding8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: myStyle.myFontStyle(
                    fontSize: fontSize14,
                    fontWeight: FontWeight.w400,
                    color: whiteColor.withOpacity(opacity ?? 1)),
              ),
              const SizedBox(
                width: padding5,
              ),
              Visibility(
                visible: showIcon,
                child: InkWell(
                  onTap: onPressed,
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: whiteColor.withOpacity(opacity ?? 1),
                  ),
                ),
              ),
            ],
          ),
          isAmount
              ? myWidget.getRupeeText(value,
                  color: whiteColor,
                  fontSize: fontSize12,
                  fontWeight: FontWeight.w400)
              : Text(
                  value,
                  style: myStyle.myFontStyle(
                      color: whiteColor,
                      fontSize: fontSize12,
                      fontWeight: FontWeight.w400),
                )
        ],
      ),
    );
  }

  Widget columnTitleDesc(
      {required String title,
      required String description,
      double? tFont,
      double? descFont,
      CrossAxisAlignment? alignment,
      bool whiteText = false}) {
    return SizedBox(
      width: screenWidth / 3.0,
      child: Column(
        crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: whiteText
                ? myStyle.myFontStyle(
                    fontSize: tFont ?? fontSize14,
                    color: Get.isDarkMode
                        ? whiteColor
                        : whiteColor.withOpacity(0.7))
                : myStyle.myFontStyle(
                    fontSize: fontSize12,
                    fontWeight: FontWeight.w400,
                    color: grayDarkColor),
          ),
          myWidget.getRupeeText(description,
              fontWeight: FontWeight.bold,
              fontSize: descFont ?? fontSize14,
              color: whiteText ? whiteColor : fontDesColor),
        ],
      ),
    );
  }

  Widget divider({double? nHeight, double? nWidth}) {
    return Divider(
      height: nHeight ?? 5,
      color: grayColor,
    );
  }
}
