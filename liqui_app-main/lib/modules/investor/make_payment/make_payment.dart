import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/make_payment/controllers/make_payment_controller.dart';

import '../../../global/constants/app_constants.dart';

class MakePayment extends GetView<MakePaymentController> {
  const MakePayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: MyAppBar(
        title: 'payment_mode'.tr,
      ),
      body: Obx(
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                horizontal: padding24, vertical: padding10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: padding24, vertical: padding20),
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: greenColor.withOpacity(0.2),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(padding8))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      columnTitleDesc(
                        'investment_amount'.tr,
                        controller.selectedAmount,
                      ),
                      columnTitleDesc(
                        'investment_type'.tr,
                        controller.investmentType,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: padding30,
                ),
                Text(
                  'available_methods'.tr,
                  style: myStyle.defaultTitleFontStyle,
                ),
                const SizedBox(
                  height: padding20,
                ),
                ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final paymentGatewayList =
                          myLocal.appConfig.paymentGateways![index];
                      return Card(
                        child: ListTile(
                          leading: SizedBox(
                              height: padding40,
                              width: padding40,
                              child: myHelper.getNetworkImage(
                                  paymentGatewayList.logo!.url!,
                                  fit: BoxFit.fitWidth)),
                          title: Text(
                            paymentGatewayList.title!,
                            style: myStyle.myFontStyle(color: primaryColor),
                            textScaleFactor: 1.2,
                          ),
                          onTap: () => controller
                              .makePayment(paymentGatewayList.gatewayId!),
                        ),
                      );
                    },
                    itemCount: myLocal.appConfig.paymentGateways!.length),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget columnTitleDesc(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: padding24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: myStyle.myFontStyle(
                  color: Get.isDarkMode ? whiteColor : fontDesColor,
                  fontSize: padding14,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: padding5,
          ),
          title == 'investment_amount'.tr
              ? myWidget.getRupeeText(description,
                  color: Get.isDarkMode ? whiteColor : greyColor,
                  fontSize: padding20,
                  fontWeight: FontWeight.w700)
              : Text(
                  description,
                  style: myStyle.myFontStyle(
                      color: Get.isDarkMode ? whiteColor : greyColor,
                      fontSize: padding20,
                      fontWeight: FontWeight.w700),
                )
        ],
      ),
    );
  }
}
