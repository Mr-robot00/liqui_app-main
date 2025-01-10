import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/branch_setup.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/device_local_auth.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:liqui_app/modules/investor/profile/models/basic_detail_response.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  var showShimmer = false.obs;
  var basicDetailRes = BasicDetailResponse().obs;
  dynamic docs = <dynamic>[];
  var appVersion = "";
  var appBuild = "";
  var referralCode = "";
  String nextKycScreen = "";
  var switchValue = false.obs;
  var deviceAuthAvailable = false;
  var themeValue = "".obs;

  //ShowCase View
  late AppShowCases showCaseList;
  TutorialCoachMark? tutorialCoachMark;
  int showCasePosProfile = 0;
  var investorIdKey = GlobalKey();
  var profileDetailsKey = GlobalKey();
  var appLockKey = GlobalKey();

  HomeController get homeController => Get.find<HomeController>();

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  void handleRetryAction() {
    // updateLoading();
    switch (retryError) {
      case 'basic_detail':
        callGetBasicDetail();
        break;
      case 'get_referral':
        callGetReferral();
        break;
      default:
        updateError();
        break;
    }
  }

  @override
  void onInit() {
    setAppVersionBuild();
    switchValue.value = myLocal.enableAppLock;
    themeValue.value = myLocal.themeValue;
    setDeviceAuthAvailable();
    super.onInit();
  }

  void showTutorialProfile() {
    if (basicDetailRes.value.data != null && basicDetailRes.value.status!) {
      if (tutorialCoachMark!.targets.isNotEmpty) {
        tutorialCoachMark!.show(context: Get.context!);
      }
    }
  }

  setDeviceAuthAvailable() async {
    deviceAuthAvailable = await deviceLocalAuth.isBiometricAvailable();
  }

  void enableAppLock() async {
    if (await deviceLocalAuth.authenticateUser()) {
      switchValue.value = true;
      myLocal.enableAppLock = true;
      Get.showSnackBar("screen_lock_enabled".tr);
    } else {
      myWidget.showPopUp("device_lock_issue".tr, dismissible: false);
    }
  }

  void setAppVersionBuild() async {
    appVersion = await myHelper.appVersion;
    appBuild = await myHelper.appBuildNumber;
  }

  String get appVerBuild => "Version: $appVersion($appBuild)";

  Future<void> onPullRefresh() async {
    callGetBasicDetail();
  }

  String get getGender => basicDetailRes.value.data != null
      ? basicDetailRes.value.data!.profile!.gender ?? ""
      : "";

  bool get kycVerified =>
      basicDetailRes.value.data != null &&
      basicDetailRes.value.data!.profile!.kycStatus == "Verified";

  bool get kycUnderReview => kycVerified
      ? false
      : (nextKycScreen.validString && nextKycScreen == "review");

  bool get kycRejected =>
      basicDetailRes.value.data != null &&
          basicDetailRes.value.data?.profile?.kycStatus == "NotVerified" ||
      basicDetailRes.value.data?.profile?.kycStatus == "Rejected";

  bool get addressPresent =>
      basicDetailRes.value.data != null &&
      (basicDetailRes.value.data?.address?.currentAddress) is! List;

  CurrentAddress get currentAdd =>
      basicDetailRes.value.data?.address?.currentAddress as CurrentAddress;

  Future<List<dynamic>> callGetBasicDetail({bool fromKycDialog = false}) async {
    var result = [];
    final params = {'investor_id': myLocal.userId};
    updateError(isError: !fromKycDialog);
    showShimmer.value = !fromKycDialog;
    myRepo.fetchBasicDetail(query: params).asStream().handleError((error) {
      result = [false, error.toString()];
      // if (fromKycDialog) {
      //   Get.showSnackBar(error.toString());
      // }
      updateError(isError: true, msg: error.toString(), retry: 'basic_detail');
      showShimmer.value = false;
    }).listen((response) {
      updateError();
      showShimmer.value = false;
      result = [response.status!, response.message];
      if (response.status!) {
        basicDetailRes.value = response;
        //if (!referralUrl.value.validString) callGetReferral();
        var address = basicDetailRes.value.data?.address?.currentAddress;
        bool addPresent = address is! List;
        if (myLocal.userDataConfig.userGender.isEmpty ||
            myLocal.userDataConfig.userDob.isEmpty) {
          var userdata = myLocal.userDataConfig;
          userdata.userPAN = basicDetailRes.value.data!.profile!.pan!;
          userdata.userGender =
              basicDetailRes.value.data!.profile!.gender ?? "";
          userdata.userDob = basicDetailRes.value.data!.profile!.dob ?? '';
          myLocal.userData = userdata;
          logEvent.setUserAttributes(
              investorId: myLocal.investorId,
              userName: myLocal.userDataConfig.userName,
              mobileNumber: myLocal.userDataConfig.userNumber,
              emailId: myLocal.userDataConfig.userEmail);
        }

        // myLocal.userPAN = basicDetailRes.value.data!.profile!.pan!;

        if (!kycVerified) {
          var documents = basicDetailRes.value.data!.document!;
          var banks = basicDetailRes.value.data!.banking!;
          var ckycVerified = response.data!.profile!.ckycNumber.validString;
          bool bankDocPresent = documents
              .where((doc) => doc.documentCategory == 'Banking')
              .isNotEmpty;
          bool identityDocPresent = ckycVerified ||
              documents
                  .where((doc) => doc.documentCategory == 'ProofOfIdentity')
                  .isNotEmpty;
          bool addressDocPresent = ckycVerified ||
              documents
                  .where((doc) => doc.documentCategory == 'ProofOfAddress')
                  .isNotEmpty;
          bool bankVerfied = banks
              .where((bankvalue) => bankvalue.kycStatus == 'Verified')
              .isNotEmpty;
          if (!addPresent) {
            nextKycScreen = addAddressScreen;
          } else if (basicDetailRes.value.data!.banking!.isEmpty) {
            nextKycScreen = addBankAccountScreen;
          } else if (!bankDocPresent && !bankVerfied) {
            nextKycScreen = uploadBankDocumentScreen;
          } else if (!identityDocPresent) {
            nextKycScreen = uploadPanDocumentScreen;
          } else if (!addressDocPresent) {
            nextKycScreen = uploadAddressDocumentScreen;
          } else if (basicDetailRes.value.data!.profile!.eAgreementStatus ==
              null) {
            nextKycScreen = signInAgreementScreen;
          } else {
            nextKycScreen = "review";
            // if (fromKycDialog) {
            //   myWidget.showPopUp("kyc_under_review".tr,
            //       title: "kyc_updates".tr);
            // }
          }
          // if (fromKycDialog && nextKycScreen != "review") {
          //   Get.toNamed(nextKycScreen,
          //       arguments: (nextKycScreen == addAddressScreen ||
          //               nextKycScreen == addBankAccountScreen)
          //           ? {"fromKyc": true}
          //           : null);
          // }
        } else {
          nextKycScreen = "";
        }
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'basic_detail');
      }
    });
    while (result.isEmpty) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return result;
  }

  void referFriend() {
    if (referralCode.isEmpty) {
      callGetReferral();
    } else {
      shareReferralLink();
    }
  }

  void callGetReferral() async {
    final params = {'investor_id': myLocal.userId};
    updateError(isError: true, showOverlay: true);
    myRepo.fetchReferralUrl(query: params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'get_referral');
    }).listen((response) {
      if (response.status!) {
        referralCode = response.data!.referralCode!;
        shareReferralLink();
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'get_referral');
      }
    });
  }

  void shareReferralLink() async {
    try {
      if (await myHelper.hasNetwork) {
        if (referralCode.isNotEmpty) {
          buildLink();
        } else {
          Get.showSnackBar('referral_url_error'.tr);
        }
      } else {
        Get.showSnackBar(noInternetMessage);
      }
    } catch (e) {
      updateError();
    }
  }

  void buildLink() async {
    if (!isLoading.value) {
      updateError(isError: true, showOverlay: true);
    }
    BranchLinkProperties props = BranchLinkProperties(
        channel: "app_referral", feature: "referral", campaign: "referral");
    props.addControlParam("referral_code", referralCode);
    var link = await branchIO.generateDeepLinks(props);
    updateError();
    if (link.validString) {
      var message = "${myLocal.appConfig.referralMessage!}\n$link";
      myHelper.share(
        message,
        subject: 'refer_friend'.tr,
      );
    } else {
      Get.showSnackBar('referral_url_error'.tr);
    }
  }

  void callPostLogOut() async {
    final params = {
      'investor_id': myLocal.userId,
      'device_id': myLocal.deviceUniqueId,
      'fcm_token': myLocal.fcmDeviceToken,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.logOutApiCall(params).asStream().handleError((error) {
      // updateError(isError: true, msg: error.toString());
      myHelper.logoutUser(reLogin: false);
    }).listen((response) {
      updateError();
      if (response.status) {
        myHelper.logoutUser(reLogin: false);
      } else {
        myHelper.logoutUser(reLogin: false);
        // updateError(isError: true, msg: response.message.toString());
      }
    });
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

  ///---------ShowCase View Start---------///
  void updateShowCaseStateProfile({int pos = 100}) {
    var cases = myLocal.showCaseConfig;
    switch (pos) {
      case -1:
        cases.investorId = false;
        cases.myProfile = false;
        cases.appLock = false;
        break;
      case 0:
        cases.investorId = false;
        break;
      case 1:
        cases.myProfile = false;
        break;
      case 2:
        cases.appLock = false;
        break;
      default:
        break;
    }
    myLocal.appShowCases = cases;
  }

  void createTutorialProfile() {
    showCaseList = myLocal.showCaseConfig;
    tutorialCoachMark = TutorialCoachMark(
        targets: _createTargetsProfile().reversed.toList(),
        textSkip: "${"skip".tr}  >",
        onFinish: () {
          logEvent.showCaseEvent(
              page: "page_${profileScreen.substring(1)}",
              buttonLabel: "on_finish_show_case".tr,
              type: "");
          updateShowCaseStateProfile();
        },
        onSkip: () {
          logEvent.showCaseEvent(
              page: "page_${profileScreen.substring(1)}",
              buttonLabel: "on_skip_show_case".tr,
              type: "");
          updateShowCaseStateProfile(pos: -1);
        },
        onClickTarget: (target) {
          logEvent.showCaseEvent(
              page: "page_${profileScreen.substring(1)}",
              buttonLabel: "on_click_target_show_case".tr,
              type: "");
          updateShowCaseStateProfile(pos: showCasePosProfile);
          showCasePosProfile++;
        },
        textStyleSkip: myStyle.myFontStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.bold,
            color: whiteColor),
        showSkipInLastTarget: false);
  }

  List<TargetFocus> _createTargetsProfile() {
    List<TargetFocus> targets = [];
    if (showCaseList.appLock && deviceAuthAvailable) {
      showCasePosProfile = 2;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${profileScreen.substring(1)}",
          keyTarget: appLockKey,
          title: "enable_disable_app_lock".tr,
          description: "put_app_security_for_app_lock".tr,
          showNextButton: false,
          showPrevButton: showCaseList.myProfile,
          onPrevPress: () => {
                showCasePosProfile--,
              },
          onFinishPress: () => {
                updateShowCaseStateProfile(pos: showCasePosProfile),
                showCasePosProfile,
              }));
    }
    if (showCaseList.myProfile) {
      showCasePosProfile = 1;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${profileScreen.substring(1)}",
          keyTarget: profileDetailsKey,
          title: "profile_details".tr,
          description: "your_profile_details".tr,
          showNextButton: deviceAuthAvailable ? true : false,
          showPrevButton: showCaseList.investorId,
          onPrevPress: () => {
                showCasePosProfile--,
              },
          onNextPress: () => {
                updateShowCaseStateProfile(
                  pos: showCasePosProfile++,
                ),
              },
          onFinishPress: () => {
                updateShowCaseStateProfile(pos: showCasePosProfile),
                showCasePosProfile,
              }));
    }
    if (showCaseList.investorId) {
      showCasePosProfile = 0;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${profileScreen.substring(1)}",
          keyTarget: investorIdKey,
          title: "investor_id".tr,
          description: "your_investor_id".tr,
          showSkipBottom: true,
          onNextPress: () => {
                updateShowCaseStateProfile(pos: showCasePosProfile),
                showCasePosProfile++,
              }));
    }
    return targets;
  }

  ///---------ShowCase View End---------///
}
