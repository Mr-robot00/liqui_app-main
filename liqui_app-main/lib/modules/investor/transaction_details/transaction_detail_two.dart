import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/modules/investor/transaction_details/controllers/transaction_details_controller.dart';

import '../../../global/utils/my_style.dart';
import '../../../global/widgets/index.dart';

class TransactionDetailTwo extends GetView<TransactionDetailController> {
  final labelList = ['When', 'Opening', 'Closing', 'Amount'];

  TransactionDetailTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => OverlayScreen(
          isLoading: controller.isLoading.value,
          errorMessage: controller.errorMsg.value,
          onRetryPressed: () => controller.handleRetryAction(),
          onDismissPressed: () => controller.updateLoading(),
          //showRetryButton: controller.retryError.va,
          child: Scaffold(
              backgroundColor: Colors.white54,
              appBar: MyAppBar(
                title: 'transaction_details'.tr,
              ),
              body: SingleChildScrollView(
                  child: Column(
                children: [
                  Container(
                    height: screenHeight / 4,
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(horizontal: padding20),
                    color: portfolioCardColor,
                    child: Padding(
                      padding: const EdgeInsets.only(top: padding40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              columnTitleDesc('amount_deposited'.tr,
                                  rupeeSymbol + controller.currentValue,
                                  titleStyle: myStyle.myFontStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: padding18,
                                  ),
                                  descStyle: myStyle.myFontStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: padding24,
                                  )),
                              RoundedContainer(
                                padding: const EdgeInsets.all(padding5),
                                radius: padding20,
                                backgroundColor: greenColor,
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_outlined,
                                      color: whiteColor,
                                    ),
                                    const SizedBox(
                                      width: padding5,
                                    ),
                                    Text(
                                      'Completed',
                                      style: myStyle.myFontStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w800,
                                        fontSize: padding16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: controller.utr.isNotEmpty,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: padding20),
                              child: Text('UTR No. ${controller.utr}',
                                  style: myStyle.myFontStyle(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: padding14,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  transactionList()
                ],
              ))),
        ));
  }

  Widget transactionList() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: padding20, vertical: padding10),
          color: backgroundColor,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                  labelList.length,
                  (index) => Expanded(
                        child: Text(
                          labelList[index],
                          style: myStyle.myFontStyle(
                              color: darkGrayColor, fontSize: padding16),
                          textAlign: TextAlign.center,
                        ),
                      ))),
        ),
        ListView.builder(
            itemCount: controller.transactionModel.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: padding20, vertical: padding10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dtHelper.ddMMyyyy(controller
                                .transactionModel[index].transactionDate!),
                            textAlign: TextAlign.center,
                            style: transactionStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            rupeeSymbol +
                                controller
                                    .transactionModel[index].openingBalance!
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: transactionStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            rupeeSymbol +
                                controller
                                    .transactionModel[index].closingBalance!
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: transactionStyle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            rupeeSymbol +
                                controller.transactionModel[index].amount!
                                    .toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            style: transactionStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: padding20,
                  )
                ],
              );
            }),
      ],
    );
  }

  Widget columnTitleDesc(String title, String desc,
      {EdgeInsets? margin,
      EdgeInsets? padding,
      TextStyle? titleStyle,
      TextStyle? descStyle}) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Text(desc, style: descStyle),
        ],
      ),
    );
  }

  TextStyle get transactionStyle => myStyle.myFontStyle(
        color: Get.isDarkMode ? whiteColor : fontDesColor,
        fontSize: padding16,
      );
}
