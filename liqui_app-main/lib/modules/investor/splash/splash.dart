import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';

import '../../../global/utils/my_style.dart';
import 'controllers/splash_controller.dart';

class Splash extends GetView<SplashController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Obx(() => Scaffold(
          appBar: const MyAppBar(height: 0),
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          bottomSheet: DecoratedBox(
            decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                !controller.showUpdateAvailable.value
                    ? Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: padding20),
                        child: !controller.isLoading.value
                            ? myWidget.defaultAppLoader()
                            : const SizedBox.shrink(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            bottom: padding50,
                            left: padding10,
                            right: padding10,
                            top: padding10),
                        child: Column(
                          children: [
                            Text(
                              myLocal.appConfig.appUpdateMessage ?? '',
                              textAlign: TextAlign.center,
                              style: myStyle.myFontStyle(
                                  fontSize: fontSizeM,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: padding20),
                            Row(
                              children: [
                                if (!controller.forceUpdate.value)
                                  Flexible(
                                      child: MyOutlinedButton(
                                          margin:
                                              const EdgeInsets.all(padding16),
                                          alignment: Alignment.centerLeft,
                                          onPressed: () =>
                                              {controller.navigateUser()},
                                          title: "update_later".tr)),
                                Flexible(
                                    child: MyButton(
                                        avoidIntrusions: false,
                                        alignment: Alignment.centerRight,
                                        margin: const EdgeInsets.all(padding16),
                                        onPressed: () => {
                                              myHelper.osType == 'ios'
                                                  ? myHelper.openUrl(
                                                      "app_store_url".tr,
                                                      inAppView: false)
                                                  : myHelper.openUrl(
                                                      "play_store_url".tr,
                                                      inAppView: false)
                                            },
                                        title: "update_now".tr)),
                              ],
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            // onRetryPressed: () => controller.handleRetryAction(),
            child: Center(
              child: !controller.showUpdateAvailable.value
                  ? myHelper.getNetworkImage(
                      myLocal.appConfigDetails != "{}"
                          ? myLocal.appConfig.splashPageMedia!.asset!.url!
                          : "",
                      placeholder: 'splash',
                      width: myHelper.isTablet ? 350 : 300,
                      fit: BoxFit.fitWidth,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(padding10),
                      child: SizedBox(
                        child:
                            myHelper.getAssetImage('update', fit: BoxFit.fill),
                      ),
                    ),
            ),
          ),
          // bottomNavigationBar: Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     controller.showUpdateAvailable.value
          //             ? Container(
          //                 margin: const EdgeInsets.only(
          //                     bottom: padding50,
          //                     left: padding10,
          //                     right: padding10,
          //                     top: padding10),
          //                 child: Column(
          //                   children: [
          //                     Text(
          //                       "app_update_msg".tr,
          //                       textAlign: TextAlign.center,
          //                       style: myStyle.myFontStyle(
          //                           fontSize: fontSizeM,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                     const SizedBox(height: padding20),
          //                     Row(
          //                       children: [
          //                         if (controller.forceUpdate.value == "False")
          //                           Flexible(
          //                               child: MyOutlinedButton(
          //                                   margin:
          //                                       const EdgeInsets.all(padding16),
          //                                   alignment: Alignment.centerLeft,
          //                                   onPressed: () =>
          //                                       {controller.nextScreen()},
          //                                   title: "update_later".tr)),
          //                         Flexible(
          //                             child: MyButton(
          //                                 avoidIntrusions: false,
          //                                 alignment: Alignment.centerRight,
          //                                 margin:
          //                                     const EdgeInsets.all(padding16),
          //                                 onPressed: () => {
          //                                       myHelper.osType == 'ios'
          //                                           ? myHelper.openUrl(
          //                                               "app_store_url".tr)
          //                                           : myHelper.openUrl(
          //                                               "play_store_url".tr)
          //                                     },
          //                                 title: "update_now".tr)),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             : Column(
          //                 children: [
          //                   myHelper.getAssetImage('liqui_text',
          //                       color: myHelper.isDarkMode
          //                           ? whiteColor
          //                           : primaryDarkColor),
          //                   Container(
          //                     margin: const EdgeInsets.symmetric(
          //                         vertical: padding20),
          //                     child: myWidget.defaultAppLoader,
          //                   )
          //                 ],
          //               ),
          //   ],
          // ),
        ));
  }
}
