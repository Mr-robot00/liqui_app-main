import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/global/utils/helpers/hex_color.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:text_scroll/text_scroll.dart';

import 'controllers/dashboard_controller.dart';

class Dashboard extends GetView<DashboardController> {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SafeArea(
      child: Obx(() {
        /// updating the value for try_again for dashboard
        controller.home().dashBoardRetry =
            (controller.isLoading.value && !controller.showShimmer.value) &&
                controller.errorMsg.value.validString;

        return Scaffold(
          appBar: controller.showShimmer.value ? null : customAppBar(),
          body: OverlayScreen(
            isFromMainScreens: true,
            isLoading:
                controller.isLoading.value && !controller.showShimmer.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            child: RefreshIndicator(
              onRefresh: controller.onPullRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: controller.showShimmer.value
                    ? myShimmer.dashboardShimmer
                    : body,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget get body {
    return Column(
      children: [
        if (controller.home().profileCon.basicDetailRes.value.data != null &&
            !controller.home().profileCon.kycVerified &&
            !controller.home().profileCon.kycUnderReview &&
            !controller.home().profileCon.kycRejected)
          kycCard,
        if (controller.home().profileCon.kycVerified)
          Padding(
            padding: const EdgeInsets.all(padding16),
            child: InkWell(
              onTap: () {
                // navigateToDeposit();
                myWidget.rbiPopUp;
              },
              child: myHelper.getNetworkImage(
                  myLocal.appConfig.investBanner!.url!,
                  fit: BoxFit.fill,
                  width: screenWidth),
            ),
          ),
        // if (controller.home().profileCon.kycRejected)
        // myWidget.getKycRejectionCard(
        //     "${controller.home().profileCon.basicDetailRes.value.data!.kycData?[0].kycRejectionReasons}"),
        if ((controller.home().profileCon.kycUnderReview &&
                !controller.home().profileCon.kycRejected) ||
            controller.home().profileCon.kycRejected)
          Padding(
            padding: const EdgeInsets.all(padding16),
            child: myHelper.getAssetImage('kyc_review',
                fit: BoxFit.fill, width: screenWidth),
          ),
        portFolioCard(),
        _rbiGuideLine(),
        actionOptions(),
        if (controller.home().transCon.transPresent) transactionCard(),
        getCarouselSlider()
      ],
    );
  }

  Widget _rbiGuideLine() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: TextScroll(
        'rbi_guide_line'.tr,
        intervalSpaces: 10,
        style: TextStyle(color: Get.isDarkMode ? Colors.white : null),
        velocity: const Velocity(pixelsPerSecond: Offset(50, 0)),
      ),
    );
  }

  PreferredSize customAppBar() {
    return PreferredSize(
      preferredSize: Size(screenWidth, padding70),
      child: Row(
        children: [
          const SizedBox(width: padding15),

          GestureDetector(
            onTap: () => Get.toNamed(myProfileScreen),
            child: controller.home().profileCon.getGender == 'Male'
                ? myHelper.getAssetImage('male')
                : controller.home().profileCon.getGender == 'Female'
                    ? myHelper.getAssetImage('female')
                    : const Icon(Icons.account_circle,
                        size: padding50, color: primaryColor),
          ),
          // CircleAvatar(
          //   backgroundColor: transparentColor,
          //   maxRadius: 25,
          //   child: ClipRRect(
          //     borderRadius: BorderRadius.circular(50.0),
          //     child:
          //         myHelper.getAssetImage('app_icon', height: 60, width: 60),
          //   ),
          // ),
          const SizedBox(width: padding10),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              //margin: const EdgeInsets.only(top: 0),
              //width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth / 2,
                    child: Text(
                      greetingMsg(),
                      style: myStyle.myFontStyle(
                          fontSize: fontSize12,
                          fontWeight: FontWeight.w400,
                          color:
                              Get.isDarkMode ? grayLightColor : grayDarkColor),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: screenWidth / 2,
                    child: Text(
                      myLocal.userDataConfig.userName.validString
                          ? myLocal.userDataConfig.userName
                          : controller
                                  .home()
                                  .profileCon
                                  .basicDetailRes
                                  .value
                                  .data
                                  ?.profile
                                  ?.name ??
                              "",
                      style: myStyle.myFontStyle(
                        fontSize: fontSize14,
                        fontWeight: FontWeight.w700,
                        color: Get.isDarkMode ? whiteColor : blackColor,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            key: controller.folioKey,
            onPressed: () => {
              myHelper.chooseFolio(
                page: "page_${dashboardScreen.substring(1)}",
                source: 'button_select_folio',
                showAllFolio: true,
                onChanged: () {},
              ),
            },
            padding: const EdgeInsets.symmetric(horizontal: padding8),
            child: myWidget.folioSelectionRow(showDroDown: true),
          ),
          const SizedBox(width: padding10),
        ],
      ),
    );
  }

  String greetingMsg() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "${'good_morning'.tr},";
    }
    if (hour < 17) {
      return '${'good_afternoon'.tr},';
    }
    return "${'good_evening'.tr},";
  }

  Widget get kycCard => RoundedContainer(
        radius: 16,
        margin: const EdgeInsets.only(
            top: padding32,
            left: padding16,
            right: padding16,
            bottom: padding16),
        padding: const EdgeInsets.all(padding10),
        backgroundColor: kycBeigeColor,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding16, vertical: padding10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'your_kyc_verification_due'.tr.allInCaps,
                          style: myStyle.myFontStyle(
                            color: redColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: padding8),
                          child: Text(
                            'verify_kyc_start_investing'.tr,
                            style: myStyle.myFontStyle(
                                color: violetDarkColor,
                                fontWeight: FontWeight.w700,
                                fontSize: fontSize18),
                          ),
                        ),
                        MyButton(
                          onPressed: () => {
                            logEvent.verifyKycButton(
                                page: "page_${dashboardScreen.substring(1)}"),
                            myWidget.kycAlertDialog(
                                screenName: dashboardScreen.substring(1))
                          },
                          minimumSize: const Size(padding0, padding40),
                          title: "verify_kyc".tr.allInCaps,
                          textStyle: myStyle.defaultButtonTextStyle(
                              fontSize: fontSize14),
                        ),
                      ],
                    ),
                  ),
                ),
                myHelper.getAssetImage('kycImage', width: 100, height: 120),
              ],
            )
          ],
        ),
      );

  Widget portFolioCard() {
    var dashboardDetails = controller.dashboardDetails;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: padding16, left: padding16, right: padding16),
          child: RoundedContainer(
            radius: padding16,
            backgroundColor: portfolioCardColor,
            child: Column(
              children: [
                RoundedContainer(
                    radius: padding16,
                    // height: 175,
                    shadow: true,
                    shadowColor: violetDarkColor,
                    backgroundColor: portfolioCardColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: padding16, vertical: padding16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'total_portfolio_value'.tr,
                            style: myStyle.myFontStyle(
                              fontSize: fontSize12,
                              fontWeight: FontWeight.w400,
                              color: whiteColor.withOpacity(0.7),
                            ),
                            // style: Get.textTheme.displayMedium
                          ),
                          const SizedBox(height: padding10),
                          Row(
                            children: [
                              SizedBox(
                                key: controller.portfolioKey,
                                child: myWidget.getRupeeText(
                                  "${dashboardDetails.portfolioValue ?? 0}",
                                  color: whiteColor,
                                  fontSize: fontSize20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: padding20),
                              myHelper.getAssetImage('green_up'),
                              const SizedBox(width: padding5),
                              Row(
                                children: [
                                  Text(
                                    myHelper.currencyFormat.format(double.parse(
                                        "${dashboardDetails.annualizedReturnXiir ?? 0}")),
                                    style: myStyle.myFontStyle(
                                        fontSize: fontSize14,
                                        fontWeight: FontWeight.w700,
                                        color: greenColor),
                                  ),
                                  Text(
                                    " % XIRR",
                                    style: myStyle.myFontStyle(
                                      fontSize: fontSize14,
                                      fontWeight: FontWeight.w700,
                                      color: greenColor,
                                    ),
                                    // style: _textTheme.displaySmall,
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: padding32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: titleDescription('withdrawable'.tr,
                                      "${dashboardDetails.withdrawableBalance ?? 0}",
                                      titleStyle: myStyle.myFontStyle(
                                          fontSize: fontSize12,
                                          fontWeight: FontWeight.w400,
                                          color: whiteColor.withOpacity(0.7)),
                                      descriptionStyle: myStyle.myFontStyle(
                                          fontSize: fontSize14,
                                          fontWeight: FontWeight.w400,
                                          color: whiteColor))),
                              const SizedBox(width: padding30),
                              Expanded(
                                child: titleDescription('locked'.tr,
                                    "${dashboardDetails.lockedWithdrawableBalance ?? 0}",
                                    titleStyle: myStyle.myFontStyle(
                                        fontSize: fontSize12,
                                        fontWeight: FontWeight.w400,
                                        color: whiteColor.withOpacity(0.7)),
                                    descriptionStyle: myStyle.myFontStyle(
                                        fontSize: fontSize14,
                                        fontWeight: FontWeight.w400,
                                        color: whiteColor)),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding16, vertical: padding20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'accrued_interest'.tr,
                            style: myStyle.myFontStyle(
                                fontSize: fontSize14,
                                fontWeight: FontWeight.w600,
                                color: whiteColor),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: padding15,
                                color: Colors.white70,
                              ),
                              const SizedBox(
                                width: padding5,
                              ),
                              Text(
                                'net_withdraw_interest'.tr,
                                style: myStyle.myFontStyle(
                                    fontSize: fontSize14,
                                    color: Colors.white70),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        key: controller.accruedKey,
                        child: myWidget.getRupeeText(
                          "${dashboardDetails.accruedInterest ?? 0}",
                          color: greenColor,
                          fontSize: fontSize16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget actionOptions() {
    final child = <Widget>[];
    if (myLocal.appConfig.actionWidgetData != null &&
        myLocal.appConfig.actionWidgetData!.isNotEmpty) {
      var actions = myLocal.appConfig.actionWidgetData!;
      if (!controller.enableInvestFund) {
        actions = actions.where((v) => v.deeplink != "invest-fund").toList();
      }
      if ((controller.dashboardDetails.withdrawableBalance ?? 0) <= 0) {
        actions = actions.where((v) => v.deeplink != "withdraw-fund").toList();
      }

      for (int i = 0; i < actions.length; i++) {
        child.add(createActionButton(
          actions[i].logo!.url ?? "",
          actions[i].title!.replaceAll('\\n', '\n'), //.replaceFirst(" ", "\n"),
          HexColor(actions[i].backgroundColor!.hex!),
          actions[i].deeplink!,
        ));
      }
    }

    return Container(
      height: 140,
      margin: const EdgeInsets.only(top: padding32),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.80,
        mainAxisSpacing: padding16,
        crossAxisSpacing: padding16,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: padding16),
        shrinkWrap: true,
        children: child,
      ),
    );
  }

  Widget createActionButton(
      String imagePath, String label, Color color, String clickId) {
    return Material(
      key: clickId == "invest-fund" ? controller.investKey : null,
      color: Get.isDarkMode ? blackLightColor : color,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(padding8),
        ),
      ),
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(padding8),
        ),
        onTap: () => onClick(clickId),
        child: RoundedContainer(
          radius: 8,
          backgroundColor: transparentColor,
          padding: const EdgeInsets.only(
              top: padding12, right: padding10, left: padding10),
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: padding4),
              myHelper.getNetworkImage(imagePath, width: 48, height: 48),
              const SizedBox(height: padding12),
              Text(
                label,
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w600, fontSize: fontSize14
                    // color: Get.isDarkMode?Colors.black:fontDesColor
                    ),
                // style: Get.textTheme.titleLarge
              ),
              const SizedBox(height: padding12),
            ],
          ),
        ),
      ),
    );
  }

  void onClick(String id) {
    switch (id) {
      case "invest-fund":
        // validateIfa((status) {
        //   if (status) {
        //     logEvent.buttonAddMoney(
        //         page: "page_${dashboardScreen.substring(1)}",
        //         source: "page_${dashboardScreen.substring(1)}");
        //     Get.toNamed(depositFundsScreen);
        //   }
        // }, id);

        myWidget.rbiPopUp;
        break;
      case "withdraw-fund":
        validateIfa((status) {
          if (status) {
            logEvent.buttonWithdrawMoney(
                page: "page_${dashboardScreen.substring(1)}");
            Get.toNamed(withdrawFundScreen);
          }
        }, id);
        break;
      case "start-sip":
        logEvent.buttonWithdrawMoney(
            page: "page_${dashboardScreen.substring(1)}");
        myWidget.showPopUp("coming_soon".tr);
        break;
    }
  }

  void validateIfa(ValueChanged<bool> onResult, String? id) {
    if (myLocal.ifaId.isNotEmpty) {
      onResult(true);
    } else {
      myHelper.chooseFolio(
          page: "page_${dashboardScreen.substring(1)}",
          source: "button_$id",
          onChanged: () {
            onResult(true);
          });
    }
  }

  void navigateToDeposit({Map? data}) {
    validateIfa((status) {
      // print(data);
      if (status) {
        Get.toNamed(
          depositFundsScreen,
          arguments: {
            "schemeType": 'lock-in'.tr,
            'amount': data?['amount'],
            'lockInTenure': data?['lockInTenure'],
          },
        );
      }
    }, "deposit_fund");
  }

  Widget titleDescription(String title, String description,
      {TextStyle? titleStyle,
      double? width,
      double? height,
      TextStyle? descriptionStyle,
      MainAxisAlignment? mainAxisAlignment}) {
    return SizedBox(
      width: width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          const SizedBox(height: padding10),
          SizedBox(
            key: title == 'withdrawable'.tr
                ? controller.withdrawableKey
                : controller.lockedKey,
            child: myWidget.getRupeeText(
              description,
              fontSize: descriptionStyle?.fontSize,
              color: descriptionStyle?.color,
              fontWeight: descriptionStyle?.fontWeight,
            ),
          )
        ],
      ),
    );
  }

  Widget transactionCard() {
    return Padding(
      padding: const EdgeInsets.only(
          top: padding16, left: padding16, right: padding16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'last_transaction'.tr,
                // style: myStyle.myFontStyle(
                //     fontWeight: FontWeight.bold, fontSize: fontSizeM),
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w700, fontSize: fontSize14),
              ),
              TextButton(
                onPressed: () => {
                  controller.home().changeTabIndex(controller
                      .home()
                      .bottomNavigatorList
                      .indexWhere(
                          (element) => element.title == "transaction".tr))
                },
                child: Text(
                  'all_transactions'.tr,
                  style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize12,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: padding10),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(padding8),
            ),
            child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(padding8),
                ),
                //onTap: () {},
                leading: const CircleAvatar(
                  backgroundColor: grayLightColor,
                  child: Icon(Icons.account_balance, color: primaryColor),
                ),
                title: Text(
                  controller.home().transCon.txnTypeLabel(
                      controller
                          .home()
                          .transCon
                          .transRes
                          .value
                          .transactions!
                          .last
                          .transactionSubType,
                      controller
                          .home()
                          .transCon
                          .transRes
                          .value
                          .transactions!
                          .last
                          .transactionSubSubType),
                  style: myStyle.myFontStyle(
                      fontWeight: FontWeight.w400, fontSize: fontSize14),
                ),
                subtitle: Text(
                    dtHelper.ddMMMMYYYY(controller
                        .home()
                        .transCon
                        .transRes
                        .value
                        .transactions!
                        .last
                        .transactionDate!),
                    style: myStyle.myFontStyle(
                        fontWeight: FontWeight.w400, fontSize: fontSize14)),
                trailing: myWidget.getRupeeText(
                  controller
                      .home()
                      .transCon
                      .transRes
                      .value
                      .transactions!
                      .last
                      .amount
                      .toString(),
                  fontSize: fontSize16,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ],
      ),
    );
  }

  Widget getCarouselSlider() {
    if (myLocal.appConfig.dashboardActions != null &&
        myLocal.appConfig.dashboardActions!.corouselItems != null &&
        myLocal.appConfig.dashboardActions!.corouselItems!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              top: padding32,
              left: padding16,
              right: padding16,
              bottom: padding16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myLocal.appConfig.dashboardActions!.title!,
                style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize16,
                  color: Get.isDarkMode ? whiteColor : violetDarkColor,
                ),
              ),
              Text(
                myLocal.appConfig.dashboardActions!.subtitle!,
                style: myStyle.myFontStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize14,
                  color:
                      Get.isDarkMode ? whiteColor : greyColor.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        imageSlider(),
        const SizedBox(height: padding10)
      ],
    );
  }

  Widget imageSlider() {
    return CarouselSlider(
      items: controller.images
          .map(
            (image) => Padding(
              padding: const EdgeInsets.all(padding8),
              child: InkWell(
                onTap: () async {
                  logEvent.mediaCarouselItem(
                      page: "page_${dashboardScreen.substring(1)}",
                      carouselLabel: image.title ?? '');
                  navigateToDeposit(data: image.data);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(padding0),
                  child: myHelper.getNetworkImage(image.image!.url!,
                      width: screenWidth, fit: BoxFit.fill),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 180,
        viewportFraction: 0.9,
        autoPlay: true,
        onPageChanged: (index, reason) {},
      ),
    );
    // return SizedBox(
    //   height: 180,
    //   child: PageView.builder(
    //       itemCount: images.length,
    //       controller: PageController(initialPage: 0, viewportFraction: 0.9),
    //       onPageChanged: (page) {},
    //       itemBuilder: (context, pagePosition) {
    //         return ClipRRect(
    //           borderRadius: BorderRadius.circular(padding8),
    //           child: myHelper.getAssetImage(images[pagePosition],
    //               padding: padding8, fit: BoxFit.fill),
    //         );
    //       }),
    // );
  }
}
