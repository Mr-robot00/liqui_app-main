import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';

import '../../../global/widgets/my_title_subtitle.dart';

class BasicDetails extends GetView<ProfileController> {
  const BasicDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => Scaffold(
          appBar: MyAppBar(
            title: "basic_detail".tr,
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            child: controller.basicDetailRes.value.data != null
                ? Padding(
                    padding: const EdgeInsets.all(padding16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyTitleSubtitle(
                          title: 'name'.tr,
                          subTitle: controller
                                  .basicDetailRes.value.data?.profile?.name ??
                              "NA",
                        ),
                        _sizeBox,

                        MyTitleSubtitle(
                          title: 'phone_number'.tr,
                          subTitle: controller.basicDetailRes.value.data
                                  ?.profile?.contactNumber ??
                              "NA",
                        ),
                        _sizeBox,
                        MyTitleSubtitle(
                          title: 'pan_Number'.tr,
                          subTitle: controller
                                  .basicDetailRes.value.data?.profile?.pan ??
                              "NA",
                        ),
                        _sizeBox,
                        MyTitleSubtitle(
                          title: 'email'.tr,
                          subTitle: controller
                                  .basicDetailRes.value.data?.profile?.email ??
                              "NA",
                        ),
                        _sizeBox,
                        MyTitleSubtitle(
                          title: 'gender'.tr,
                          subTitle: controller.getGender == ""
                              ? "NA"
                              : controller.getGender,
                        ),
                        _sizeBox,
                        MyTitleSubtitle(
                          title: 'dob'.tr,
                          subTitle: controller.basicDetailRes.value.data
                                      ?.profile?.dob !=
                                  null
                              ? dtHelper.ddMMMMYYYY(controller
                                  .basicDetailRes.value.data!.profile!.dob!)
                              : "NA",
                        ),
                        _sizeBox,
                        // MyTitleSubtitle(
                        //   title: 'address'.tr,
                        //   subTitle: controller.basicDetailRes.value.data!.address!.currentAddress!.fullAddress!,
                        // ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ));
  }

  Widget get _sizeBox => const SizedBox(height: padding30);
}
