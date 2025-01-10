import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/user_data_model.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';

class OtpController extends GetxController {
  final TextEditingController otpController = TextEditingController();
  var isLoading = false.obs;
  var mobileNumber = '';
  var accountExist = true;
  bool autoSendOtp = false;
  var counter = 0.obs;
  var resendButton = false.obs;
  var disableButton = false.obs;
  Timer? timer;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      mobileNumber = Get.arguments['mobile_number'] ?? '';
      accountExist = Get.arguments['accountExist'] ?? true;
      autoSendOtp = Get.arguments['sendOtp'] ?? false;
    }
    if (autoSendOtp) callSendOTP();
    initTimer();
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  // @override
  // void listenForCode() async {
  //   smsAutoFill.unregisterListener();
  //   await smsAutoFill.listenForCode();
  // }

  void callVerifySignUpOtp() async {
    logEvent.btnVerifyOtp(
        page: "page_${otpScreen.substring(1)}",
        source: "page_${loginScreen.substring(1)}",
        type: "signup");
    final params = {
      'contact_number': mobileNumber,
      'otp': otpController.text,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifySignUpOtp(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'verify_sign_up_otp');
    }).listen((response) {
      updateError();
      if (response.status) {
        myWidget.customDialog(
            'device_verified',
            'mobile_verification_successful'.tr,
            '${'fetching_your_info'.tr}...');
        Future.delayed(const Duration(seconds: 2), () {
          Get.offNamed(createInvestorScreen,
              arguments: {'context': otpScreen, "mobile_number": mobileNumber});
        });
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void callVerifySignInOtp() async {
    logEvent.btnVerifyOtp(
        page: "page_${otpScreen.substring(1)}",
        source:
            autoSendOtp ? "auto_logout" : "page_${loginScreen.substring(1)}",
        type: "login");
    final params = {
      'email': mobileNumber,
      'password': otpController.text,
      'role_id': '2',
      "loginType": 'mobile',
      'device_id': myLocal.deviceUniqueId,
      'fcm_token': myLocal.fcmDeviceToken,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifySignInOtp(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'verify_sign_in_otp');
    }).listen((response) {
      updateError();
      if (response.status!) {
        myLocal.authToken = response.data?.token ?? 'Invalid token';
        callGetInvestorDetails();
        // Get.showSnackBar('Sign In Successfully');
      } else {
        if (response.message!.contains("seconds")) {
          var seconds = response.message!.substring(16, 19);
          counter.value = int.parse(seconds);
          startTimer();
          //updateButtonState();
        } else {
          updateError(
            isError: true,
            msg: response.message.toString(), /* retry: 'verify_sign_in_otp'*/
          );
        }
      }
    });
  }

  void callSendOTP() async {
    if (otpController.text.isNotEmpty) otpController.clear();
    final params = {'contact_number': mobileNumber};
    updateError(isError: true, showOverlay: true);
    myRepo
        .sendOTP(params, accountExist: accountExist)
        .asStream()
        .handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'send_otp');
    }).listen((response) {
      updateError();
      if (response.status!) {
        Get.showSnackBar(response.message!);
        initTimer();
        startTimer();
      } else {
        // if (response.message!.contains("seconds")) {
        //   var seconds = response.message!.substring(16, 19);
        //   counter.value = int.parse(seconds);
        if (response.data != null && response.data!.otpTime != 0) {
          counter.value = response.data!.otpTime!.toInt();
          startTimer();
          updateButtonState();
        } else {
          Get.showSnackBar(response.message ?? "something_went_wrong".tr);
        }
      }
    });
  }

  void callGetInvestorDetails() async {
    updateError(isError: true, showOverlay: true);
    myRepo.investorRoleDetails().asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'investor_details');
    }).listen((response) async {
      updateError();
      if (response.status!) {
        final invDetails = response.investorRoleDetails!;
        final investorId = invDetails.currentRole!.userId.toString();
        var investorName = invDetails.name ?? '';
        var investorEmail = invDetails.email ?? "";
        myLocal.isLoggedIn = true;
        var userdata = UserData(
            userId: investorId,
            userName: investorName,
            userNumber: mobileNumber,
            userEmail: investorEmail);
        myLocal.userData = userdata;
        myLocal.userId = investorId;
        await logEvent.setUserIdentify(investorId: investorId);
        logEvent.setUserAttributes(
            investorId: investorId,
            userName: investorName,
            emailId: investorEmail,
            mobileNumber: mobileNumber);
        //Future.delayed(const Duration(seconds: 1), () {
        await logEvent.login(
            mobileNumber: mobileNumber,
            investorId: investorId,
            emailId: invDetails.email,
            page: "page_${loginScreen.substring(1)}");
        //});
        Get.offAllNamed(homeScreen);
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void verifyOtp() {
    if (otpController.text.length == 6) {
      if (accountExist) {
        callVerifySignInOtp();
      } else {
        callVerifySignUpOtp();
      }
    } else {
      Get.showSnackBar('enter_six_digit_otp'.tr);
    }
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'verify_sign_in_otp':
        callVerifySignInOtp();
        break;
      case 'verify_sign_up_otp':
        callVerifySignUpOtp();
        break;
      case 'investor_details':
        callGetInvestorDetails();
        break;
      case 'send_otp':
        callSendOTP();
        break;
      default:
        updateError();
        break;
    }
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (counter.value > 0) {
          counter.value--;
          resendButton.value = false;
        } else {
          timer.cancel();
          updateButtonState();
          resendButton.value = true;
        }
      },
    );
  }

  updateButtonState() {
    var status = (counter > 0 && otpController.text.length == 6);
    disableButton.value = status;
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  initTimer() {
    counter.value = 120;
  }

  updateError({
    bool isError = false,
    String msg = '',
    String retry = '',
    bool showOverlay = false,
  }) {
    // myHelper.hideKeyboard();
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
