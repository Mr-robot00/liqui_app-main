import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

class VerifyWithdrawRequestController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var isLoading = false.obs;
  var bankingId = ''.obs;
  var id = ''.obs;
  var linkToken = '';
  var amount = '';

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var disableButton = true.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      id.value = Get.arguments['id'].toString();
      linkToken = Get.arguments['linkToken'].toString();
      amount = Get.arguments['amount'] ?? '0';
    }
    super.onInit();
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'post_verify_txn_otp':
        verifyTxnOtp();
        break;
      case "send_txn_otp":
        postSendTxnOTP();
        break;
      default:
        updateError();
        break;
    }
  }

  void postSendTxnOTP() async {
    if (otpController.text.isNotEmpty) otpController.clear();
    final params = {
      "investor_id": myLocal.userId,
      "request_id": id.value,
      "link_token": linkToken
    };
    updateError(isError: true, showOverlay: true);
    myRepo.sendTxnOTP(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'send_txn_otp');
    }).listen((response) {
      updateError();
      if (response.status!) {
        Get.showSnackBar(response.message!);
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'send_txn_otp');
      }
    });
  }

  void verifyTxnOtp() async {
    logEvent.btnVerifyOtp(
        page: "page_${verifyWithdrawRequestScreen.substring(1)}",
        source: "page_${withdrawFundScreen.substring(1)}",
        type: "withdraw_fund");
    final params = {
      "investor_id": myLocal.userId,
      "request_id": id.value,
      "link_token": linkToken,
      "otp": otpController.text
    };
    updateError(isError: true, showOverlay: true);
    myRepo.postVerifyTxnOtp(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString());
    }).listen((response) {
      updateError();
      if (response.status) {
        logEvent.withdrawFund(
            linkToken: linkToken,
            amount: num.parse(amount.validString?amount:"0"),
            page: "page_${verifyWithdrawRequestScreen.substring(1)}");
        Get.toNamed(transactionStatusScreen, arguments: {
          "title": "withdrawal_request".tr,
          "withdrawScreen": true
        });
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void validateForm({bool verifyOtp = true}) {
    if (otpController.text.length != 6) {
      disableButton.value = true;
    } else {
      disableButton.value = false;
      if (verifyOtp) verifyTxnOtp();
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  updateError({
    bool isError = false,
    String msg = '',
    String retry = '',
    bool showOverlay = false,
  }) {
    myHelper.hideKeyboard();
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }
}
