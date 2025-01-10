import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';

import '../../../global/constants/index.dart';
import '../../../global/widgets/index.dart';

class TransactionDetails extends GetView {
  const TransactionDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white54,
        appBar: MyAppBar(
          title: 'transaction_details'.tr,
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            backgroundWidget(),
            Positioned(
                bottom: screenHeight / 1.9, right: 10, left: 10, child: card())
          ],
        )));
  }

  Widget backgroundWidget() {
    return Stack(
      children: [
        Container(
            height: screenHeight,
            width: screenWidth,
            color: whiteColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: screenHeight / 2.5,
                    width: screenWidth,
                    color: portfolioCardColor,
                    child: Column(
                      children: [
                        columnTitleDesc('Amount deposited', '2000',
                            margin: const EdgeInsets.only(top: padding40),
                            titleStyle: myStyle.myFontStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: padding14,
                            ),
                            descStyle: myStyle.myFontStyle(
                              color: whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: padding28,
                            )),
                        const SizedBox(
                          height: padding100,
                        ),
                        depositDetails('Lock-In', '9 MONTHS')
                      ],
                    )),
                const Spacer(),
                contactSupport(),
              ],
            )),
      ],
    );
  }

  Widget card() {
    return RoundedContainer(
      height: padding200,
      width: screenWidth,
      backgroundColor: whiteColor,
      shadow: true,
      shadowColor: blackColor.withOpacity(0.2),
      radius: padding8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          columnTitleDesc('Debited From', 'HDFCXXXXXX0050',
              titleStyle: myStyle.defaultHintFontStyle,
              descStyle: myStyle.defaultTitleFontStyle,
              margin: const EdgeInsets.symmetric(vertical: padding20),
              padding: const EdgeInsets.symmetric(horizontal: padding20)),
          const Divider(
            height: padding5,
            color: grayLightColor,
          ),
          columnTitleDesc('UTR', 'SBI000010027920',
              titleStyle: myStyle.defaultHintFontStyle,
              descStyle: myStyle.defaultFontStyle,
              margin: const EdgeInsets.symmetric(vertical: padding10),
              padding: const EdgeInsets.symmetric(horizontal: padding20)),
          columnTitleDesc('When', '7 Aug 2022, 3:16 PM',
              titleStyle: myStyle.defaultHintFontStyle,
              descStyle: myStyle.defaultFontStyle,
              //margin: const EdgeInsets.symmetric(vertical: padding10),
              padding: const EdgeInsets.symmetric(horizontal: padding20)),
        ],
      ),
    );
  }

  Widget contactSupport() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: padding20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'having_issues'.tr,
                  style: myStyle.defaultFontStyle,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: padding20),
                  child: MyOutlinedButton(
                    onPressed: () {},
                    title: 'contact_support'.tr,
                    minimumSize: const Size(padding40, padding40),
                    //padding: const EdgeInsets.symmetric(vertical: padding40),
                  ),
                )
              ],
            ),
            showSizeBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'your_transaction_is_sure'.tr,
                  style: myStyle.defaultFontStyle,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: padding20),
                  child: myHelper.getAssetImage(
                    'secure_payment',
                  ),
                )
              ],
            ),
          ],
        ),
      ),
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

  Widget depositDetails(String depositType, String? lockInPeriod) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: padding20),
      child: Visibility(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'deposit_type'.tr,
                style: myStyle.myFontStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: padding16,
                ),
              ),
              Text(
                depositType,
                style: myStyle.myFontStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: padding16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: padding10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'lock-in_period'.tr,
                style: myStyle.myFontStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w400,
                  fontSize: padding16,
                ),
              ),
              Text(
                lockInPeriod ?? '0',
                style: myStyle.myFontStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: padding16,
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget showSizeBox({double? height}) {
    return SizedBox(
      height: height ?? padding20,
    );
  }
}
