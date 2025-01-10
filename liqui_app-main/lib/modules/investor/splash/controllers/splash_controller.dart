import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/graphql_query.dart';
import 'package:liqui_app/global/utils/helpers/device_local_auth.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/my_widget.dart';

import '../../../../global/networking/my_repositories.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  int liveVersion = 0;
  var isLoading = false.obs;
  var forceUpdate = false.obs;

  //Error handling
  var errorMsg = ''.obs;
  var overlayLoading = true.obs;
  var showUpdateAvailable = false.obs;
  var retryError = "";

  @override
  void onInit() {
    super.onInit();
    // Timer(const Duration(seconds: 1), () => navigateUser());
    WidgetsBinding.instance.addObserver(this);
    callAppConfig();
  }

  @override
  onClose() {
    super.onClose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed &&
        myLocal.enableAppLock &&
        (!showUpdateAvailable.value) &&
        !Platform.isIOS) {
      Get.back();
      navigateUser();
    }
  }

  void callAppConfig() async {
    myRepo
        .appConfig({"query": GraphqlQuery.postRetrieveConstantData()})
        .asStream()
        .handleError((error) {
          if (myLocal.appConfigDetails != "{}") {
            checkAppUpdate();
          } else {
            updateError(
                isError: true, msg: error.toString(), retry: 'app_config');
          }
        })
        .listen((response) {
          updateError();
          // printLog('App Config ${jsonEncode(response)}');
          myLocal.appConfigDetails = jsonEncode(response.data!.mobileAppConfig);
          checkAppUpdate();
        });
  }

  void checkAppUpdate() async {
    var appVersionConfig = myLocal.appConfig.appVersions!;
    var appVersion = int.parse(await myHelper.appBuildNumber);
    if (myHelper.osType == 'ios') {
      liveVersion = int.parse(appVersionConfig.ios!.buildNumber!);
      forceUpdate.value = appVersionConfig.ios!.forceUpdate ?? false;
    } else {
      liveVersion = int.parse(appVersionConfig.android!.buildNumber!);
      forceUpdate.value = appVersionConfig.android!.forceUpdate ?? false;
    }
    if (appVersion < liveVersion) {
      showUpdateAvailable.value = true;
      // nextScreen();
    } else {
      nextScreen();
    }
  }

  void nextScreen() {
    Timer(const Duration(seconds: 0), () => navigateUser());
  }

  void navigateUser() async {
    if (myLocal.firstTimeUser) {
      Get.offNamed(introScreen);
    } else {
      if (myLocal.isLoggedIn) {
        if (myLocal.enableAppLock) {
          authenticateUser();
        } else {
          navigateToHome();
        }
      } else {
        Get.offNamed(loginScreen);
      }
    }
  }

  void authenticateUser() async {
    if (await deviceLocalAuth.authenticateUser()) {
      navigateToHome();
    } else {
      myWidget.showConfirmationPopUp("verify_security_msg".tr,
          onConfirmPressed: authenticateUser,
          confirmButtonLabel: "unlock".tr,
          dismissible: false,
          onCancelPressed: exitApp,
          showCancelButton: !Platform.isIOS);
    }
  }

  navigateToHome() {
    // logEvent.setUserIdentify(investorId: myLocal.investorId);
    // logEvent.setUserAttributes(
    //     investorId: myLocal.investorId,
    //     userName: myLocal.userName,
    //     mobileNumber: myLocal.userNumber,
    //     emailId: myLocal.userEmail);
    Get.offNamed(homeScreen);
  }

  void exitApp() {
    SystemNavigator.pop();
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
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }
}
