import 'dart:async';

import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../analytics/log_events.dart';
import '../../../config/routes/app_routes.dart';

class MyWebViewController extends GetxController {
  late final WebViewController webController;
  var isLoading = false.obs;

  // String webUrl = "https://www.google.com/";
  late Uri webUri;
  var webTitle = "".obs;
  bool preventBack = false;
  bool showAppBar = true;
  var amount = '';

  //Error handling
  var errorMsg = ''.obs;
  var showError = false.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    // webUrl = Get.arguments["webUrl"];
    if (Get.arguments != null) {
      webUri = Get.arguments["webUri"];
      showAppBar = Get.arguments["showAppbar"] ?? true;
      preventBack = Get.arguments["preventBack"] ?? false;
      amount = Get.arguments["amount"] ?? '0';
    }

    initWebView();
  }

  initWebView() async {
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) async {
            webTitle.value = await webController.getTitle() ?? "";
          },
          onPageFinished: (String url) async {
            webTitle.value = await webController.getTitle() ?? "";
            Map<String, String> params = Uri.parse(url).queryParameters;
            // printLog("params: $params");
            // printLog("webTitle: ${webTitle.value}");
            // if (params.containsKey("transaction_status")) {
            //   printLog("transaction_status: ${params["transaction_status"]}");
            // }
            if (params.containsKey("transaction_status")
                // &&
                // webTitle.value.contains("LiquiLoans")
                ) {
              var status = params["transaction_status"];
              if (status == "success") {
                logEvent.paymentStatus(
                    amount: num.parse(amount.validString ? amount : "0"),
                    transactionId: params["transaction_id"] ?? "N/A",
                    transactionStatus: "Transaction Success",
                    page: "page_${paymentGatewayScreen.substring(1)}");
                logEvent.investFund(
                    amount: num.parse(amount.validString ? amount : "0"),
                    transactionId: params["transaction_id"] ?? "N/A",
                    transactionStatus: "Transaction Success",
                    page: "page_${paymentGatewayScreen.substring(1)}");
                Get.toNamed(transactionStatusScreen, arguments: {
                  "transactionId": params["transaction_id"] ?? "N/A",
                  "title": "transaction_success".tr,
                  "withdrawScreen": false,
                });
              } else {
                Get.back(result: status);
              }
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..enableZoom(true)
      ..loadRequest(webUri); //Uri.parse(webUrl)
  }

  Future<bool> onWillPop() async {
    if (await webController.canGoBack()) {
      webController.goBack();
      return Future.value(preventBack);
    } else {
      return Future.value(true);
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      default:
        updateError();
        break;
    }
  }

  updateError({
    bool isError = false,
    String msg = '',
    String retry = '',
    bool showOverlay = false,
  }) {
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }
}
