import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/splash/models/app_config_response.dart';
import 'package:video_player/video_player.dart';

class IntroController extends GetxController {
  Timer? timer;
  final activePage = 0.obs;
  final PageController pageController = PageController(initialPage: 0);
  VideoPlayerController? videoController;
  final List<IntroPageInfo> introModelList = [];

  @override
  void onInit() {
    addDataToModel();
    super.onInit();
  }

  @override
  void onReady() {
    //animatePage();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  void initVideoController(String path) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(path));
    videoController!.addListener(() {});
    await videoController!.initialize().then((value) async {
      await videoController!.play();
      await videoController!.setLooping(true);
    });
  }

  void pauseVideoController() async {
    await videoController?.dispose();
  }

  void animatePage() {
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (Timer timer) {
        if (activePage.value < introModelList.length) {
          if (activePage.value == introModelList.length - 1) {
            activePage.value = 0;
          } else {
            activePage.value++;
          }
        } else {
          activePage.value = 0;
        }
        pageController.animateToPage(activePage.value,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn);
      },
    );
  }

  void addDataToModel() {
    if (myLocal.appConfigDetails != "{}") {
      myLocal.appConfig.introPageInfo?.forEach((element) {
        introModelList.add(element);
      });
    }
  }

  void navigateToLogin() async {
    await videoController?.dispose();
    if (activePage.value != introModelList.length - 1) {
      pageController.animateToPage(activePage.value + 1,
          duration: const Duration(milliseconds: 30), curve: Curves.easeIn);
    } else {
      logEvent.installEvent();
      myLocal.firstTimeUser = false;
      Get.offNamed(loginScreen);
    }
  }

  int getActivePage() {
    var page = activePage.value;
    if (activePage.value < introModelList.length) {
      if (activePage.value == introModelList.length - 1) {
        page = 0;
      } else {
        page++;
      }
    } else {
      page = 0;
    }
    return page;
  }
}
