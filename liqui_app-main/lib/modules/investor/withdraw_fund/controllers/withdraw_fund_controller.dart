import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/dashboard/controllers/dashboard_controller.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../global/widgets/index.dart';
import '../../bank_accounts/models/bank_accounts_response.dart';

class WithdrawFundController extends GetxController {
  BankAccountModel? selectedValue;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController folioController = TextEditingController();
  final DashboardController dash = Get.find();
  final ProfileController profile = Get.find();
  FocusNode focusNode = FocusNode();
  var isLoading = false.obs;
  var bankListData = <BankAccountModel>[].obs;
  var selectedValueRes = ''.obs;
  var requestId = ''.obs;
  var linkToken = '';

  //ShowCase View
  late AppShowCases showCaseList;
  TutorialCoachMark? tutorialCoachMark;
  int showCasePosWithdraw = 0;
  var amountToWithdrawKey = GlobalKey();
  var withdrawToBankKey = GlobalKey();

  //Error handling
  var errorMsg = ''.obs;
  var overlayLoading = true.obs;
  var retryError = "";
  var disableButton = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInvestorBankDetails();
    focusNode.addListener(() {
      if (!focusNode.hasFocus && amountController.text.validString) {
        logEvent.inputWithdrawFundAmount(
            page: "page_${withdrawFundScreen.substring(1)}",
            amount: num.parse(amountController.text));
      }
    });
  }

  @override
  void dispose() {
    amountController.dispose();
    folioController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    tutorialCoachMark?.finish();
    super.onClose();
  }

  bool get isWithDrawBalanceZero =>
      dash.dashboardDetails.withdrawableBalance == 0;

  void showTutorial() {
    if (tutorialCoachMark!.targets.isNotEmpty) {
      tutorialCoachMark?.show(context: Get.context!);
    }
  }

  void onSelected(BankAccountModel value) {
    selectedValue = value;
    logEvent.dropDownWithdrawToBank(
        page: "page_${withdrawFundScreen.substring(1)}",
        bank: value.bankName.toString());
    selectedValueRes.value = value.id.toString();
    // printLog(selectedValue?.accountType);
  }

  void validateForm([bool btnClick = false]) {
    if (amountController.text.isEmpty || selectedValue?.id == null) {
      disableButton.value = true;
    } else {
      if (double.parse(amountController.text) >
              dash.dashboardDetails.withdrawableBalance!.toDouble() ||
          double.parse(amountController.text) == 0) {
        disableButton.value = true;
      } else {
        disableButton.value = false;
        if (btnClick && myHelper.isIFAValid()) {
          if (profile.kycUnderReview) {
            myWidget.showPopUp("kyc_under_review".tr, title: "kyc_updates".tr);
          } else if (!profile.kycVerified &&
              !profile.kycUnderReview &&
              !profile.kycRejected) {
            myWidget.kycAlertDialog(
                screenName: withdrawFundScreen.substring(1));
          } else if (profile.kycRejected) {
            myWidget.kycAlertDialog(
                kycRejectionMessage:
                    "${'sorry_kyc_verification_failed'.tr} ${profile.basicDetailRes.value.data!.kycData?[0].kycRejectionReasons} ${"please_try_again".tr}.",
                forKycRejection: true,
                screenName: withdrawFundScreen.substring(1));
          } else {
            createWithdrawalRequest();
          }
        }
      }
    }
  }

  void fetchInvestorBankDetails() async {
    final params = {'investor_id': myLocal.userId};
    updateError(isError: true);
    myRepo
        .fetchInvestorBankDetails(query: params)
        .asStream()
        .handleError((error) {
      updateError(
          isError: true,
          msg: error.toString(),
          retry: 'fetch_investor_bank_details');
    }).listen((response) {
      updateError();
      bankListData.value = response.data!;
      createTutorialWithdraw();
      showTutorial();

      if (bankListData.isNotEmpty) {
        selectedValue = bankListData.firstWhere((p0) => p0.isDefault == "Yes");
        selectedValueRes.value = selectedValue!.id.toString();
      }
    });
  }

  void createWithdrawalRequest() async {
    final params = {
      'investor_id': myLocal.userId,
      "banking_id": selectedValue!.id,
      "reason_id": 0,
      "transaction_source": 'MobileApp', //InvestorDash
      "withdrawal_method": 'Auto',
      "amount": amountController.text,
      "full_redemption": 'No',
      "send_mail": 'No',
      "manual_parameters": null,
    };
    updateError(isError: true, showOverlay: true);
    myRepo.createWithdrawalRequest(params).asStream().handleError((error) {
      //printLog(error.toString());
      updateError(
          isError: true,
          msg: error.toString(),
          retry: 'create_withdraw_request');
    }).listen((response) {
      updateError();
      if (response.status!) {
        linkToken = response.data!.linkToken.toString();
        requestId.value = response.data!.id.toString();
        postSendTxnOTP();
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'create_withdraw_request');
      }
    });
  }

  void postSendTxnOTP() async {
    final params = {
      "investor_id": myLocal.userId,
      "request_id": requestId.value,
      "link_token": linkToken
    };
    updateError(isError: true, showOverlay: true);
    myRepo.sendTxnOTP(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'send_txn_otp');
    }).listen((response) {
      updateError();
      if (response.status!) {
        logEvent.withdrawFundStarted(
            amount: num.parse(amountController.text.validString
                ? amountController.text
                : "0"),
            bankId: selectedValue!.id,
            page: "page_${withdrawFundScreen.substring(1)}");
        Get.toNamed(verifyWithdrawRequestScreen, arguments: {
          'id': requestId.value,
          'linkToken': linkToken,
          "amount": amountController.text
        });
        //navigate to otp screen here
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'send_txn_otp');
      }
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'fetch_investor_bank_details':
        fetchInvestorBankDetails();
        break;
      case 'create_withdraw_request':
        createWithdrawalRequest();
        break;
      case 'send_txn_otp':
        postSendTxnOTP();
        break;
      default:
        updateError();
        break;
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
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }

  ///---------ShowCase View Start-------///
  void createTutorialWithdraw() {
    showCaseList = myLocal.showCaseConfig;
    tutorialCoachMark = TutorialCoachMark(
        targets: _createTargetsWithDraw().reversed.toList(),
        textSkip: "${"skip".tr}  >",
        onFinish: () {
          logEvent.showCaseEvent(
              page: "page_${withdrawFundScreen.substring(1)}",
              buttonLabel: "on_finish_show_case".tr,
              type: "");
          updateShowCaseStateWithdraw();
        },
        onSkip: () {
          logEvent.showCaseEvent(
              page: "page_${withdrawFundScreen.substring(1)}",
              buttonLabel: "on_skip_show_case".tr,
              type: "");
          updateShowCaseStateWithdraw(pos: -1);
        },
        onClickTarget: (target) {
          logEvent.showCaseEvent(
              page: "page_${withdrawFundScreen.substring(1)}",
              buttonLabel: "on_click_target_show_case".tr,
              type: "");
          updateShowCaseStateWithdraw(pos: showCasePosWithdraw);
          showCasePosWithdraw++;
        },
        textStyleSkip: myStyle.myFontStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.bold,
            color: whiteColor),
        showSkipInLastTarget: false);
  }

  void updateShowCaseStateWithdraw({int pos = 100}) {
    var cases = myLocal.showCaseConfig;
    switch (pos) {
      case -1:
        cases.withdrawAmount = false;
        cases.withdrawToBank = false;
        break;
      case 0:
        cases.withdrawAmount = false;
        break;
      case 1:
        cases.withdrawToBank = false;
        break;
      default:
        break;
    }
    myLocal.appShowCases = cases;
  }

  List<TargetFocus> _createTargetsWithDraw() {
    List<TargetFocus> targets = [];

    if (showCaseList.withdrawToBank) {
      showCasePosWithdraw = 1;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${transactionsScreen.substring(1)}",
          keyTarget: withdrawToBankKey,
          title: "withdraw_to_bank".tr,
          description: "select_bank_to_withdraw".tr,
          showPrevButton: showCaseList.withdrawAmount,
          onPrevPress: () => {
                showCasePosWithdraw--,
              },
          showNextButton: false,
          onFinishPress: () => {
                updateShowCaseStateWithdraw(
                  pos: showCasePosWithdraw,
                )
              }));
    }
    if (showCaseList.withdrawAmount) {
      showCasePosWithdraw = 0;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${withdrawFundScreen.substring(1)}",
          keyTarget: amountToWithdrawKey,
          title: "amount_to_withdraw".tr,
          description: "enter_amount_to_withdraw".tr,
          onNextPress: () => {
                updateShowCaseStateWithdraw(pos: showCasePosWithdraw),
                showCasePosWithdraw++,
              }));
    }
    return targets;
  }

  ///---------ShowCase View End-------///
}
