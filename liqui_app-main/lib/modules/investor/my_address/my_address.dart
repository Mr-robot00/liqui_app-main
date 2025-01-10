import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';

import '../../../global/constants/index.dart';
import '../../../global/widgets/index.dart';

class MyAddress extends GetView<ProfileController> {
  const MyAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var address = controller.basicDetailRes.value.data?.address?.currentAddress;
    // var currentAdd = CurrentAddress();
    // bool addPresent = address is! List;
    // if (addPresent) {
    //   currentAdd = controller.basicDetailRes.value.data?.address?.currentAddress
    //       as CurrentAddress;
    // }
    // printLog(jsonEncode(currentAdd));
    context.theme;
    return Obx(() => Scaffold(
          appBar: MyAppBar(
            title: "your_address".tr,
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(padding16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('address_reach'.tr,
                            style: myStyle.myFontStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontSize16,
                                color:
                                    Get.isDarkMode ? whiteColor : blackColor)),
                        // Text('choose_address'.tr,
                        //     style: myStyle.myFontStyle(
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: fontSize14,
                        //         color: greyColor)),

                        const SizedBox(height: padding10),
                        if (controller.addressPresent)
                          ListView.separated(
                            itemCount: 1,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                  child: ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: padding16, vertical: padding2),
                                title: Text(
                                  controller.currentAdd.fullAddress.toString(),
                                  style: myStyle.myFontStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Get.isDarkMode
                                          ? whiteColor
                                          : blackColor),
                                ),
                                trailing: controller.currentAdd.addressType
                                            .toString() ==
                                        "Current"
                                    ? const Icon(
                                        Icons.check_circle,
                                        size: padding26,
                                        color: greenColor,
                                      )
                                    : null,
                              ));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: padding10,
                              );
                            },
                            shrinkWrap: true,
                          ),
                        if (!controller.addressPresent)
                          myWidget.noItemFound("No record found"),
                      ]),
                ),
                if (!controller.addressPresent)
                  MyOutlinedButton(
                      avoidIntrusions: true,
                      margin: const EdgeInsets.all(padding16),
                      onPressed: () {
                        Get.toNamed(addAddressScreen,
                            arguments: {"fromKyc": true});
                      },
                      title: "add_address".tr)
              ],
            ),
          ),
        ));
  }
}
