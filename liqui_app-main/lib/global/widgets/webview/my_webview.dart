import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/global/widgets/webview/controllers/my_webview_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends GetView<MyWebViewController> {
  const MyWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(
        () => Scaffold(
          appBar: MyAppBar(
            title: controller.webTitle.value,
            height: controller.showAppBar ? kToolbarHeight : 0,
          ),
          body: OverlayScreen(
            isLoading: controller.isLoading.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            onDismissPressed: () => Get.back(result: false),
            backgroundColor: controller.overlayLoading.value
                ? Get.isDarkMode?Colors.black54:Colors.white54
                : Get.theme.scaffoldBackgroundColor,
            child: WebViewWidget(
              controller: controller.webController,
            ),
          ),
        ),
      ),
    );
  }
}
