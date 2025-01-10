import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/transaction_status/controller/transaction_status_controller.dart';

class TransactionStatus extends GetView<TransactionStatusController> {
  const TransactionStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    children.add(const SizedBox(
      height: padding50,
    ));
    children.add(
      Center(
          child:
              myHelper.getAssetImage('success_icon', width: 110, height: 110)),
    );
    children.add(const SizedBox(
      height: padding30,
    ));
    children.add(Center(child: columnSuccessDesc()));
    children.add(const SizedBox(
      height: padding30,
    ));
    children.add(columnTitleDesc(
        controller.withdrawScreen.value
            ? 'amt_requested'.tr
            : 'amt_invested'.tr,
        controller.selectedAmount));

    children.add(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            controller.withdrawScreen.value
                ? 'crediting_to'.tr
                : 'locking_tenure'.tr,
            style: myStyle.myFontStyle(
                color: Get.isDarkMode ? grayLightColor : darkGrayColor,
                fontSize: padding14,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: padding5,
        ),
        Row(
          children: [
            controller.withdrawScreen.value
                ? const Icon(
                    Icons.account_balance,
                    size: padding30,
                    color: primaryColor,
                  )
                : const SizedBox.shrink(),
            controller.withdrawScreen.value
                ? const SizedBox(
                    width: padding10,
                  )
                : const SizedBox.shrink(),
            Text(
              controller.withdrawScreen.value
                  ? controller.selectedBankName
                  : controller.depositController.investmentTenure,
              style: myStyle.defaultLabelStyle,
              textAlign: TextAlign.start,
            )
          ],
        ),
        const SizedBox(
          height: padding20,
        )
      ],
    ));

    children.add(Text(
        controller.withdrawScreen.value
            ? 'amt_credited_msg'.tr
            : '${'txn_ref_num'.tr}: ${controller.transactionId}',
        style: myStyle.myFontStyle(
            color: Get.isDarkMode ? grayLightColor : darkGrayColor,
            fontSize: padding14,
            fontWeight: FontWeight.w400)));

    children.add(Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MyButton(
              margin: const EdgeInsets.symmetric(
                  horizontal: padding10, vertical: padding5),
              onPressed: () => Get.offAllNamed(homeScreen),
              title: "back_to_dashboard".tr),
          // if (!controller.withdrawScreen.value)
          //   MyButton(
          //       margin: const EdgeInsets.all(padding10),
          //       onPressed: () => printLog("invest More"),
          //       title: "invest_more".tr),
        ],
      ),
    ));

    Future<bool> onWillPop() async {
      return false;
    }

    //
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: MyAppBar(
          title: controller.title.value,
          leading: InkWell(
            child: const Icon(Icons.close),
            onTap: () => Get.offAllNamed(homeScreen), //dashboard screen name
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: padding20, vertical: padding10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
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
                  color: Get.isDarkMode ? grayLightColor : darkGrayColor,
                  fontSize: fontSize14,
                  fontWeight: FontWeight.w400)),
          const SizedBox(
            height: padding5,
          ),
          myWidget.getRupeeText(
            description,
            color: Get.isDarkMode ? grayLightColor : fontDesColor,
            fontWeight: FontWeight.w700,
            fontSize: fontSize20,
          )
        ],
      ),
    );
  }

  Widget columnSuccessDesc() {
    return Column(
      children: [
        Text(
          'congratulations'.tr,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : greyColor,
              fontSize: fontSize16,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: padding8,
        ),
        Text(
          controller.withdrawScreen.value
              ? 'your_withdrawal_request'.tr
              : 'investment_successful'.tr,
          style: myStyle.myFontStyle(
              color: Get.isDarkMode ? whiteColor : greyColor,
              fontSize: fontSize16,
              fontWeight: FontWeight.w400),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
