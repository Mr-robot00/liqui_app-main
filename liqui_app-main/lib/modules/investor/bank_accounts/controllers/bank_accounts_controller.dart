import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/bank_accounts/models/bank_accounts_response.dart';

class BankAccountsController extends GetxController {
  var isLoading = false.obs;
  var bankListData = <BankAccountModel>[].obs;
  var bankingId = ''.obs;
  final TextEditingController folioController = TextEditingController();

  //Error handling
  var errorMsg = ''.obs;
  var overlayLoading = true.obs;
  var retryError = "";

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'fetchInvestorBankDetails':
        fetchInvestorBankDetails();
        break;
      // case 'deleteBankApiCall':
      //   deleteBankApiCall();
      //   break;
      // case 'changeDefaultBanking':
      //   changeDefaultBanking();
      //   break;
      default:
        updateError();
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchInvestorBankDetails();
  }

  @override
  void dispose() {
    folioController.dispose();
    super.dispose();
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
        retry: 'fetchInvestorBankDetails',
      );
    }).listen((response) {
      updateError();
      if (response.status!) {
        bankListData.value = response.data!;
      } else {
        updateError(
          isError: true,
          msg: response.message.toString(),
          retry: 'fetchInvestorBankDetails',
        );
      }
    });
  }

  void deleteBankApiCall() {
    final params = {
      'investor_id': myLocal.userId,
      'banking_id': bankingId.value
    };
    updateError(isError: true, showOverlay: true);
    myRepo.deleteBankApiCall(params).asStream().handleError((error) {
      updateError(
        isError: true,
        msg: error.toString(),
      );
    }).listen((response) {
      updateError();
      if (response.status) {
        logEvent.deleteBank(
            bankId: bankingId.value,
            page: "page_${addBankAccountScreen.substring(1)}");
        fetchInvestorBankDetails();
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void changeDefaultBanking() {
    final params = {
      'investor_id': myLocal.userId,
      'banking_id': bankingId.value
    };
    updateError(isError: true, showOverlay: true);
    myRepo.changeDefaultBankingApiCall(params).asStream().handleError((error) {
      updateError(isError: true, msg: error.toString());
    }).listen((response) {
      updateError();
      if (response.status) {
        fetchInvestorBankDetails();
      } else {
        updateError(isError: true, msg: response.message.toString());
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
}
