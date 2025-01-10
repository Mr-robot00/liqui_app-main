import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/intro/controllers/intro_controller.dart';
import 'package:video_player/video_player.dart';

import '../../../global/constants/index.dart';

class Intro extends GetView<IntroController> {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            appBar: const MyAppBar(height: 0),
            body: Stack(
              children: [
                PageView.builder(
                  // physics: const NeverScrollableScrollPhysics(),
                  controller: controller.pageController,
                  onPageChanged: (int page) {
                    controller.activePage.value = page;
                  },
                  itemCount: controller.introModelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child: controller.activePage.value == index
                            ? mediaLoader()
                            : Container());
                  },
                ),
              ],
            ),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(padding20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: List<Widget>.generate(
                        controller.introModelList.length,
                        (index) => Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: padding5),
                          child: InkWell(
                            // onTap: () {
                            //   controller.pageController.animateToPage(index,
                            //       duration: const Duration(milliseconds: 30),
                            //       curve: Curves.easeIn);
                            // },
                            child: controller.activePage.value != index
                                ? const CircleAvatar(
                                    radius: padding5,
                                    backgroundColor: grayDarkColor,
                                  )
                                : const RoundedContainer(
                                    radius: 5,
                                    width: 20,
                                    height: 10,
                                    backgroundColor: greyColor,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: padding30),
                    MyButton(
                      title: controller.activePage.value ==
                              controller.introModelList.length - 1
                          ? "continue".tr
                          : 'next'.tr,
                      onPressed: () => controller.navigateToLogin(),
                    ),
                  ],
                )),
          ),
        ));
  }

  Widget mediaLoader() {
    var introModelListIndex =
        controller.introModelList[controller.activePage.value];
    if (introModelListIndex.type == "Video") {
      controller.initVideoController(introModelListIndex.asset!.url!);
      return Padding(
        padding: const EdgeInsets.only(bottom: padding10),
        child: VideoPlayer(controller.videoController!),
      );
    } else {
      controller.pauseVideoController();
      return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: padding50, horizontal: padding20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: myHelper.getNetworkImage(introModelListIndex.asset!.url!,
                  width: screenWidth - 40, fit: BoxFit.contain),
            ),
            const SizedBox(height: padding30),
            Text(
              controller.introModelList[controller.activePage.value].title!,
              style: myStyle.myFontStyle(
                fontWeight: FontWeight.w700,
                fontSize: fontSize28,
              ),
            ),
            const SizedBox(height: padding15),
            Text(
              controller.introModelList[controller.activePage.value].subtitle!,
              style: myStyle.myFontStyle(
                fontWeight: FontWeight.w600,
                fontSize: padding16,
              ),
            ),
          ],
        ),
      );
    }
  }
}
