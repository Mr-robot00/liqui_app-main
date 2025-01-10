import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/widgets/index.dart';

import '../../../global/utils/helpers/date_time_helper.dart';
import '../../../global/utils/my_style.dart';
import 'controllers/portfolio_transaction_controller.dart';

class PortfolioTransactionDetail
    extends GetView<PortfolioTransactionController> {
  const PortfolioTransactionDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [customAppBar],
          body: Column(
            children: [tranchCard()],
          ),
        ),
      ),
    );
  }

  SliverAppBar get customAppBar {
    return SliverAppBar(
      expandedHeight: 385,
      pinned: true,
      backgroundColor: secondaryColor,
      title: Text(
        "investment_details".tr,
      ),
      titleTextStyle: myStyle.myFontStyle(
          color: whiteColor, fontWeight: FontWeight.bold, fontSize: padding20),
      leading: InkWell(
          onTap: Get.back,
          child: const Icon(
            Icons.arrow_back,
            color: whiteColor,
          )),
      flexibleSpace: FlexibleSpaceBar(
        background: schemeDetail(),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            controller: controller.detailsTabController,
            tabs: controller.myDetailsTabs,
            labelColor: whiteColor,
            indicatorColor: primaryColor,
            indicatorPadding: const EdgeInsets.only(left: 15, right: 15),
            indicatorWeight: padding4,
            unselectedLabelColor: primaryColor,
            onTap: controller.updateSelectedIndex,
          ),
        ),
      ),
    );
  }

  Widget schemeDetail() {
    return Container(
      padding:
          const EdgeInsets.only(left: padding20, right: padding20, top: 84),
      color: secondaryColor,
      child: controller.selectedScheme != null
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'current_value'.tr,
                              style: myStyle.myFontStyle(color: grayLightColor),
                            ),
                            const SizedBox(
                              width: padding5,
                            ),
                            InkWell(
                              onTap: () => {
                                myWidget.overlayInfoNote(
                                    descriptionAvailable: true,
                                    firstDesc: 'Net Principal Amount:',
                                    secondDesc: 'Accrued Interest:',
                                    firstAmount: controller
                                        .selectedScheme!.netPrincipalInvestment
                                        .toString(),
                                    secondAmount: controller
                                        .selectedScheme!.interestAmount
                                        .toString(),
                                    title: 'current_value'.tr),
                              },
                              child: Icon(
                                Icons.info_outline,
                                size: 16,
                                color: (whiteColor.withOpacity(0.7)),
                              ),
                            ),
                          ],
                        ),
                        myWidget.getRupeeText(
                            controller.selectedScheme!.accruedValue.toString(),
                            fontWeight: FontWeight.w700,
                            fontSize: fontSize24,
                            color: whiteColor),
                      ],
                    ),
                    myWidget.addMoneyButton(
                        fontSize: fontSize14,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 10.0),
                        visibility: (controller.transType[
                                    controller.selectedIndex.value] !=
                                "flexi_lock_in".tr) &&
                            controller.isSchemeAvailable(
                                schemeId: controller.selectedScheme!.schemeId
                                    .toString()),
                        onTap: () {
                          // logEvent.buttonAddMoney(
                          //     page:
                          //         "page_${portfolioTransactionDetailScreen.substring(1)}",
                          //     source:
                          //         "page_${portfolioTransactionDetailScreen.substring(1)}");
                          // controller.clickAddMoney(
                          //     schemeId: controller.selectedScheme!.schemeId
                          //         .toString(),
                          //     schemeTypeIndex: controller.transType[
                          //                 controller.selectedIndex.value] ==
                          //             "liquid".tr
                          //         ? 0
                          //         : 1);

                          myWidget.rbiPopUp;
                        })
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    rowTitle(
                        title: "total_investment".tr,
                        value: controller.selectedScheme!.investedAmount
                            .toString(),
                        opacity: 0.7,
                        onPressed: () => myWidget.overlayInfoNote(
                            message: 'Total Investment',
                            title: 'total_investment'.tr)),
                    rowTitle(
                        title: "MHP",
                        value:
                            "${controller.selectedScheme!.lockinTenure.toString()} Months",
                        opacity: 0.7,
                        isAmount: false,
                        onPressed: () => myWidget.overlayInfoNote(
                            message: 'Minimum Holding Period', title: 'MHP')),
                    rowTitle(
                        title: "XIRR/SI",
                        value:
                            "${controller.selectedScheme!.investmentRoi.toString()}%",
                        opacity: 0.7,
                        isAmount: false,
                        onPressed: () => myWidget.overlayInfoNote(
                            message: 'annualized_returns'.tr,
                            title: 'XIRR/SI')),
                    rowTitle(
                        title: "total_interest".tr,
                        value: controller.totalInterest.toString(),
                        opacity: 0.7,
                        onPressed: () => myWidget.overlayInfoNote(
                            message: 'Total Interest Earned',
                            title: "total_interest".tr)),
                    rowTitle(
                      title: "amount_withdrawn".tr,
                      value: controller.totalWithdrawable.toString(),
                      opacity: 0.7,
                      onPressed: () => myWidget.overlayInfoNote(
                          descriptionAvailable: true,
                          firstDesc: 'Principal:',
                          secondDesc: 'Interest:',
                          firstAmount: controller
                              .selectedScheme!.redeemedPrincipal
                              .toString(),
                          secondAmount: controller
                              .selectedScheme!.redeemedInterest
                              .toString(),
                          title: 'amount_withdrawn'.tr),
                    ),
                  ],
                )
              ],
            )
          : Container(),
    );
  }

  Widget tranchCard() {
    return Expanded(
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
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
                          title: controller.transactionStatus(controller
                                  .selectedScheme!
                                  .investmentSummary![index]
                                  .transactionSubType ??
                              'NA'),
                          description: controller.selectedScheme!
                              .investmentSummary![index].netPrincipalInvestment
                              .toString(),
                          infoButton: showInfoButton(controller.transactionStatus(
                              controller.selectedScheme!.investmentSummary![index].transactionSubType ??
                                  'NA')),
                          overlayTitle: controller.transactionStatus(controller
                                  .selectedScheme!
                                  .investmentSummary![index]
                                  .transactionSubType ??
                              'NA'),
                          overlayDesc: 'please_download_passbook'.tr),
                      SizedBox(width: screenWidth / 10),
                      columnTitleDesc(
                          title: 'current_value'.tr,
                          description: controller.selectedScheme!
                              .investmentSummary![index].accruedValue
                              .toString()),
                    ],
                  ),
                  const SizedBox(
                    height: padding10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dtHelper.ddMMMMYYYY(controller.selectedScheme!
                            .investmentSummary![index].maturityStartDate
                            .toString()),
                        style: myStyle.myFontStyle(
                            fontSize: fontSize12,
                            fontWeight: FontWeight.w400,
                            color: Get.isDarkMode ? whiteColor : grayDarkColor),
                      ),
                      Text(
                          '${'maturing_on'.tr} ${dtHelper.ddMMMMYYYY(controller.selectedScheme!.investmentSummary![index].maturityEndDate.toString())}',
                          style: myStyle.myFontStyle(
                              fontSize: fontSize12,
                              fontWeight: FontWeight.w400,
                              color:
                                  Get.isDarkMode ? whiteColor : grayDarkColor))
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => Container(
                height: padding2,
                color: Get.isDarkMode
                    ? grayColor.withOpacity(0.5)
                    : grayLightColor,
              ),
          itemCount: controller.selectedScheme!.investmentSummary!.length),
    );
  }

  Widget rowTitle(
      {required String title,
      required String value,
      bool isAmount = true,
      double? opacity,
      VoidCallback? onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: padding6),
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
              InkWell(
                onTap: onPressed,
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: (whiteColor.withOpacity(opacity ?? 1)),
                ),
              ),
            ],
          ),
          isAmount
              ? myWidget.getRupeeText(
                  value,
                  color: whiteColor,
                  fontSize: fontSize12,
                  fontWeight: FontWeight.w400,
                )
              : Text(
                  value,
                  style: myStyle.myFontStyle(
                    color: whiteColor,
                    fontSize: fontSize12,
                    fontWeight: FontWeight.w400,
                  ),
                )
        ],
      ),
    );
  }

  bool showInfoButton(String status) {
    switch (status) {
      case 'Reinvestment':
      case 'SchemeSwitch':
        return true;
      default:
        return false;
    }
  }

  Widget columnTitleDesc(
      {required String title,
      required String description,
      String? overlayTitle,
      String? overlayDesc,
      bool? infoButton,
      double? tFont,
      double? descFont,
      CrossAxisAlignment? crossAxisAlignment}) {
    return SizedBox(
      width: screenWidth / 3.25,
      child: Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title,
                  style: myStyle.myFontStyle(
                      fontSize: fontSize12,
                      fontWeight: FontWeight.w400,
                      color: Get.isDarkMode ? whiteColor : grayDarkColor)),
              const SizedBox(
                width: padding5,
              ),
              Visibility(
                visible: infoButton ?? false,
                child: InkWell(
                  onTap: () => {
                    myWidget.overlayInfoNote(
                        title: overlayTitle, message: overlayDesc)
                  },
                  child: Icon(
                    Icons.info_outline,
                    size: 16,
                    color: Get.isDarkMode ? whiteColor : grayDarkColor,
                  ),
                ),
              ),
            ],
          ),
          myWidget.getRupeeText(description,
              fontWeight: FontWeight.bold,
              fontSize: descFont ?? fontSize14,
              color: Get.isDarkMode ? whiteColor : fontDesColor)
        ],
      ),
    );
  }
}
