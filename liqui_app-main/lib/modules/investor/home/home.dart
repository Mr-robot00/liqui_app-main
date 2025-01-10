import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';

import 'controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Scaffold(
        // appBar: const MyAppBar(height: 0),
        body: SafeArea(
            // top: false,
            child: Obx(
          () => IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.tabWidgetList),
        )),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              unselectedItemColor: grayDarkColor,
              selectedItemColor: primaryColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              unselectedFontSize: fontSize10,
              selectedFontSize: fontSize10,
              onTap: controller.changeTabIndex,
              currentIndex: controller.selectedIndex.value,
              type: BottomNavigationBarType.fixed,
              // backgroundColor: Get.isDarkMode ? primaryDarkColor : whiteColor,
              elevation: 5,
              items: controller.getNavigationBar()),
        ));
  }
}
