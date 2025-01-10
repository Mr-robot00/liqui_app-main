import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/date_time_helper.dart';

import '../../../../global/analytics/log_events.dart';
import '../../../../global/config/routes/app_routes.dart';
import '../../../../global/networking/my_repositories.dart';
import '../../../../global/utils/helpers/my_helper.dart';
import '../../../../global/utils/storage/my_local.dart';
import '../../deposit_funds/models/investor_scheme_response.dart';
import '../models/investment_summary_response.dart';

class PortfolioTransactionController extends GetxController
    with GetTickerProviderStateMixin {
  late TabController tabController;
  late TabController detailsTabController;
  final List<Tab> myTabs = [];
  final List<Tab> myDetailsTabs = [];
  var defaultIndex = 0;
  var detailsDefaultIndex = 0;
  var showShimmer = false.obs;
  var selectedIndex = 0.obs;
  var investmentSummaryResponse = InvestmentSummaryResponse().obs;
  var schemeWiseData = <SchemeWiseData>[].obs;
  SchemeWiseData? selectedScheme;
  var filteredScheme = <SchemeWiseData>[].obs;
  var transType = [
    'liquid'.tr,
    'pure_lock_in'.tr,
    'flexi_lock_in'.tr,
  ];
  var detailTransType = ['active_transactions'.tr];
  var investorSchemeRes = InvestorSchemeResponse().obs;
  List<InvestorSchemeData> schemeList = [];
  final dateControllerStart = TextEditingController();
  final dateControllerEnd = TextEditingController();

  //Error handling
  var errorMsg = ''.obs;
  var retryError = ''.obs;
  var overlayLoading = true.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    callGetInvestorScheme();
    folioTabController();
    detailFolioTabController();
  }

  @override
  void dispose() {
    tabController.dispose();
    detailsTabController.dispose();
    super.dispose();
  }

  void folioTabController() {
    tabController = TabController(
        vsync: this, initialIndex: defaultIndex, length: transType.length);
    for (var element in transType) {
      myTabs.add(Tab(
        text: element,
      ));
    }
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        updateSelectedIndex(tabController.index);
        var tabTitleListTitle = myTabs[tabController.index].text;
        logEvent.tabPortfolio(
            tabLabel: tabTitleListTitle!,
            page: "page_${portfolioTransactionScreen.substring(1)}");
      }
    });
  }

  void detailFolioTabController() {
    detailsTabController = TabController(
        vsync: this,
        initialIndex: detailsDefaultIndex,
        length: detailTransType.length);
    for (var element in detailTransType) {
      myDetailsTabs.add(Tab(
        text: element,
      ));
    }
    detailsTabController.addListener(() {
      if (detailsTabController.indexIsChanging) {
        updateSelectedIndex(detailsTabController.index);
        var tabTitleListTitle = myDetailsTabs[detailsTabController.index].text;
        logEvent.tabPortfolio(
            tabLabel: tabTitleListTitle!,
            page: "page_${portfolioTransactionDetailScreen.substring(1)}");
      }
    });
  }

  Future<void> onPullRefresh() async {
    callGetInvestmentSummary();
  }

  void callGetInvestmentSummary() {
    final params = {
      'investor_id': myLocal.userId,
    };
    showShimmer.value = true;
    updateError(isError: true, showOverlay: true);
    myRepo.investmentSummary(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'investment_summary');
      showShimmer.value = false;
    }).listen((response) {
      updateError();
      if (response.status!) {
        showShimmer.value = false;
        investmentSummaryResponse.value = response;
        schemeWiseData.value =
            investmentSummaryResponse.value.investmentSummary?.schemeWiseData ??
                [];
        updateSelectedIndex(selectedIndex.value);
      } else {
        updateError(
            isError: true,
            msg: response.message.toString(),
            retry: 'investment_summary');
      }
    });
  }

  void callGetInvestorScheme() async {
    final params = {'investor_id': myLocal.userId};
    showShimmer.value = true;
    updateError(isError: true, showOverlay: true);
    myRepo.getInvestorSchemes(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'investor_scheme');
      showShimmer.value = false;
    }).listen((response) {
      updateError();
      if (response.status!) {
        showShimmer.value = false;
        investorSchemeRes.value = response;
        schemeList = response.data!;
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void callPostDownloadPassbook() async {
    updateError();
    final startTime = dtHelper.getFormattedDate(
      dateControllerStart.value.text,
      inFormat: 'dd-MMM-yyyy',
      outFormat: 'yyyy-MM-dd',
    );

    final endTime = dtHelper.getFormattedDate(
      dateControllerEnd.value.text,
      inFormat: 'dd-MMM-yyyy',
      outFormat: 'yyyy-MM-dd',
    );

    final params = {
      'investor_id': myLocal.userId,
      "start_date": startTime,
      "end_date": endTime,
    };

    EasyLoading.show();
    myRepo.downloadPassbook(params).asStream().handleError((error) {
      updateError();
      EasyLoading.dismiss();
      Get.showSnackBar(error.toString());
    }).listen((response) async {
      updateError();
      EasyLoading.dismiss();
      if (response.status!) {
        Get.back();
        await myHelper.downloadPdf(
          base64: response.data!.file!,
          startDate: startTime,
          endDate: endTime,
        );
      } else {
        Get.showSnackBar(response.message.toString());
      }
    });
  }

  bool get isInvestmentAvailable =>
      investmentSummaryResponse.value.investmentSummary != null &&
      investmentSummaryResponse
          .value.investmentSummary!.schemeWiseData!.isNotEmpty;

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    filteredScheme.value = filterSchemes(transType[index]);
  }

  List<SchemeWiseData> filterSchemes(String type) {
    if (!isInvestmentAvailable) return [];
    String transType = type.trim().toLowerCase();
    if (transType.contains('0 mhp') || transType.contains('liquid')) {
      return schemeWiseData
          .where((element) =>
              (element.lockinTenure == 0) &&
              !(element.lockinBreak != null && element.lockinBreak == 'Yes'))
          .toList();
    } else if (transType.contains('pure lock-in')) {
      return schemeWiseData
          .where((element) =>
              (element.lockinTenure != 0) &&
              !(element.lockinBreak != null && element.lockinBreak == 'Yes'))
          .toList();
    } else if (transType.contains('flexi lock-in')) {
      return schemeWiseData
          .where((element) =>
              element.lockinBreak != null && element.lockinBreak == 'Yes')
          .toList();
    }
    return schemeWiseData;
  }

  validateIfa(ValueChanged<bool> onResult) {
    if (myLocal.ifaId.isNotEmpty) {
      onResult(true);
    } else {
      myHelper.chooseFolio(
          onChanged: () {
            onResult(true);
          },
          page:
              '"page_${portfolioTransactionScreen.substring(1)}", source: "drop_down_invest_fund".tr',
          source: '');
    }
  }

  void clickAddMoney({required String schemeId, required int schemeTypeIndex}) {
    validateIfa((status) {
      if (status) {
        Get.toNamed(depositFundsScreen, arguments: {
          "schemeId": schemeId,
          "schemeTypeIndex": schemeTypeIndex
        });
      }
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'investment_summary':
        callGetInvestmentSummary();
        break;
      case 'investor_scheme':
        callGetInvestorScheme();
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
    // myHelper.hideKeyboard();
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError.value = retry;
  }

  bool isSchemeAvailable({required String schemeId}) {
    for (var element in schemeList) {
      if (element.schemeId.toString() == schemeId) {
        return true;
      }
    }
    return false;
  }

  String transactionStatus(String transactionSubType) {
    switch (transactionSubType) {
      case 'AddMoney':
        return 'invested'.tr;
      case 'Reinvestment':
        return 'reinvestment'.tr;
      case 'SchemeSwitch':
        return 'scheme_switch'.tr;
      default:
        return transactionSubType;
    }
  }

  num get amountRepaid {
    return filteredScheme
        .map((e) => e.totalRedemption)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get redeemedInterest {
    return filteredScheme
        .map((e) => e.redeemedInterest)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get redeemedPrincipal {
    return filteredScheme
        .map((e) => e.redeemedPrincipal)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get principalInvestmentValue {
    return filteredScheme
        .map((e) => e.investedAmount)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get interestEarned {
    return filteredScheme
        .map((e) => e.interestAmount)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get totalAccruedValue {
    return filteredScheme
        .map((e) => e.accruedValue)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get totalAccruedInterest {
    double sum = 0;
    for (SchemeWiseData element in filteredScheme) {
      element.investmentSummary?.forEach((e) {
        sum +=
            (double.tryParse((e.accruedValue ?? 0).toStringAsFixed(2)) ?? 0) -
                (e.balancePrincipal ?? 0);
      });
    }
    return sum;
  }

  num get totalNetPrincipalAmount {
    return filteredScheme
        .map((e) => e.netPrincipalInvestment)
        .fold(0, (previousValue, element) => (previousValue) + (element ?? 0));
  }

  num get totalWithdrawable {
    return (selectedScheme!.redeemedPrincipal ?? 0) +
        (selectedScheme!.redeemedInterest ?? 0);
  }

  num get totalInterest {
    double sum = 0;
    selectedScheme?.investmentSummary?.forEach((e) {
      sum += (double.tryParse((e.accruedValue ?? 0).toStringAsFixed(2)) ?? 0) -
          (e.balancePrincipal ?? 0);
    });
    return sum;
  }
}
