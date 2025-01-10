import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/bank_accounts/controllers/bank_accounts_controller.dart';
import 'package:liqui_app/modules/investor/signup/add_bank_account/models/add_bank_account_response.dart';

import '../../../../../global/networking/my_repositories.dart';
import '../../../../../global/utils/helpers/my_helper.dart';
import '../../../../../global/widgets/my_widget.dart';

class AddBankAccountController extends GetxController {
  final accountNumberController = TextEditingController();
  final accountNameController = TextEditingController();
  final bankNameController = TextEditingController();
  final ifscController = TextEditingController();

  final accountNumberFocusNode = FocusNode();

  var branchName = '';
  var accountFetchBy = '';
  var fetchAccountHolderNameError = ''.obs;
  var fetchBankNameError = ''.obs;
  var disableButton = true.obs;

  var addBank = false.obs;
  var fromKycPopUp = false.obs;

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var isLoading = false.obs;
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      addBank.value = Get.arguments['add_another_bank'] ?? false;
      fromKycPopUp.value = Get.arguments['fromKyc'] ?? false;
    }
  }

  @override
  void dispose() {
    accountNumberController.dispose();
    accountNameController.dispose();
    bankNameController.dispose();
    ifscController.dispose();

    accountNumberFocusNode.dispose();
    super.dispose();
  }

  void callIFSCode() async {
    final params = {
      'investor_id': myLocal.userId,
      'ifsc_code': ifscController.text
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifyIFSC(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'verify_ifsc');
    }).listen((response) {
      updateError();
      if (response.status!) {
        bankNameController.text = response.data?.bank ?? '';
        branchName = response.data?.branch ?? '';
        accountNumberFocusNode.requestFocus();
      } else {
        fetchBankNameError.value = response.message ?? '';
        //updateError(isError: true, msg: response.message.toString());
      }
      updateButtonState();
    });
  }

  void callBankDetails() async {
    final params = {
      'investor_id': myLocal.userId,
      'bank_account_number': accountNumberController.text,
      'ifsc_code': ifscController.text
    };
    updateError(isError: true, showOverlay: true);
    myRepo.verifyBankDetails(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString(), retry: 'verify_bank');
    }).listen((response) {
      updateError();
      if (response.status!) {
        accountNameController.text = response.data?.accountName ?? '';
        accountFetchBy = 'Api';
        fetchAccountHolderNameError.value = '';
      } else {
        fetchAccountHolderNameError.value = response.message ?? '';
        //updateError(isError: true, msg: response.message.toString());
      }
      updateButtonState();
    });
  }

  void callCreateBanking() async {
    final params = {
      'investor_id': myLocal.userId,
      'account_type': 'Saving',
      'bank_name': bankNameController.text,
      'branch_name': branchName,
      'ifsc': ifscController.text,
      'account_number': accountNumberController.text,
      "account_holder_name": accountNameController.text,
      "is_default": "yes",
      "banking_fetched_by": accountFetchBy
    };
    updateError(isError: true, showOverlay: true);
    myRepo.addBankAccount(params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'create_banking');
    }).listen((response) {
      updateError();
      if (response.status!) {
        logEvent.addBank(
            ifscCode: ifscController.text,
            bankName: bankNameController.text,
            source: fromKycPopUp.value
                ? "kyc_popup"
                : addBank.value
                    ? "page_${bankAccountsScreen.substring(1)}"
                    : "page_${addAddressScreen.substring(1)}",
            page: "page_${addBankAccountScreen.substring(1)}");
        myWidget.customDialog(
            'bank_verified',
            'bank_account_added_successful'.tr,
            '${'fetching_your_info'.tr}...');
        Future.delayed(const Duration(seconds: 2), () async {
          var res = response.data as AddBankAccountModel;
          if ((res.nameMatchPercent ?? 0) >= 60) {
            if (addBank.value) {
              final bank = Get.find<BankAccountsController>();
              bank.fetchInvestorBankDetails();
              Get.until((route) => Get.currentRoute == bankAccountsScreen);
            } else {
              callGetBasicDetail();
            }
          } else {
            if (addBank.value) {
              final bank = Get.find<BankAccountsController>();
              bank.fetchInvestorBankDetails();
            }
            Get.toNamed(uploadBankDocumentScreen,
                arguments: {"add_another_bank": addBank.value});
          }
        });
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  callGetBasicDetail() async {
    updateError(isError: true, showOverlay: true);
    try {
      var result =
          await myRepo.fetchBasicDetail(query: {'investor_id': myLocal.userId});
      updateError();
      if (result.status!) {
        Get.toNamed(result.data!.profile!.ckycNumber.validString
            ? signInAgreementScreen
            : uploadPanDocumentScreen);
      } else {
        updateError(
            isError: true, msg: result.message!, retry: 'profile_details');
      }
    } catch (e) {
      updateError(isError: true, msg: e.toString(), retry: 'profile_details');
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  String? get accountHolderNameErrorMsg {
    return fetchAccountHolderNameError.value.validString
        ? fetchAccountHolderNameError.value
        : null;
  }

  String? get bankNameError {
    return fetchBankNameError.value.validString
        ? fetchBankNameError.value
        : null;
  }

  updateTextError(String value, RxString error) {
    if (value.isNotEmpty) {
      error.value = '';
    }
    updateButtonState();
  }

  void updateButtonState() {
    var isDisabled = ifscController.text.length != 11 ||
        bankNameController.text.isEmpty ||
        accountNumberController.text.length < 10 ||
        accountNameController.text.length < 3;
    disableButton.value = isDisabled;
    // printLog('ifsc ${ifscController.text.length != 11},'
    //     ' bankName ${bankNameController.text.isEmpty},'
    //     'Acc num ${accountNumberController.text.length < 10},'
    //     'Acc Name ${accountNameController.text.length < 3}');
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'verify_ifsc':
        callIFSCode();
        break;
      case 'verify_bank':
        callBankDetails();
        break;
      case 'create_banking':
        callCreateBanking();
        break;
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
    myHelper.hideKeyboard();
    isLoading.value = isError;
    overlayLoading.value = showOverlay;
    errorMsg.value = msg;
    retryError.value = retry;
  }
}
