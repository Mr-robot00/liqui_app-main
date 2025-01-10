import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

class LoginController extends GetxController {
  final TextEditingController mobileController = TextEditingController();
  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'IN');
  var counter = 0.obs;
  var disableButton = true.obs;
  var isLoading = false.obs;
  bool accountExistsVerified = false;
  bool accountExist = false;
  var prevNumber = "".obs;
  Timer? timer;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    myLocal.clearAppLock();
  }

  @override
  void dispose() {
    mobileController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void updateButtonState() {
    disableButton.value = !mobileController.text.isMobileNumberValid ||
        (counter > 0 && prevNumber.value == mobileController.text);

    if (mobileController.text.length == 10) myHelper.hideKeyboard();
    if (mobileController.text.length > 10) {
      mobileController.text = mobileController.text.substring(0, 10);
      updateButtonState();
    }
  }

  void validateForm() {
    if (mobileController.text.isMobileNumberValid) {
      if (prevNumber.value == mobileController.text && accountExistsVerified) {
        callSendOTP();
      } else {
        callCheckSignupFlow();
      }
    } else {
      Get.showSnackBar("enter_mobile_number_error".tr);
    }
  }

  void callCheckSignupFlow() async {
    final params = {'contact_number': mobileController.text};
    prevNumber.value = mobileController.text;
    updateError(isError: true, showOverlay: true);
    myRepo.checkSignupFlow(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'check_signup_flow');
    }).listen((response) {
      updateError();
      accountExistsVerified = true;
      accountExist = response.status;
      callSendOTP();
    });
  }

  void callSendOTP() async {
    final params = {'contact_number': mobileController.text};
    updateError(isError: true, showOverlay: true);
    myRepo
        .sendOTP(params, accountExist: accountExist)
        .asStream()
        .handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'send_otp');
    }).listen((response) {
      updateError();
      if (response.status!) {
        Get.toNamed(otpScreen, arguments: {
          "mobile_number": mobileController.text,
          "accountExist": accountExist
        });
      } else {
        if (response.data != null && response.data!.otpTime != 0) {
          counter.value = response.data!.otpTime!.toInt();
          startTimer();
          updateButtonState();
        } else {
          Get.showSnackBar(response.message ?? "something_went_wrong".tr);
        }
        /*if (response.message.contains("seconds")) {
          var seconds = response.message.substring(16, 19);
          counter.value = int.parse(seconds);
          startTimer();
          updateButtonState();
        }*/
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (counter.value > 0) {
          counter.value--;
        } else {
          timer.cancel();
          updateButtonState();
        }
      },
    );
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'check_signup_flow':
        callCheckSignupFlow();
        break;
      case 'send_otp':
        callSendOTP();
        break;
      default:
        updateError();
        break;
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void updateError({
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
