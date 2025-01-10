import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/my_widget.dart';
import 'package:liqui_app/modules/investor/dashboard/controllers/dashboard_controller.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../global/networking/my_repositories.dart';
import '../models/transactions_response.dart';

class TransactionsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = [];

  late TabController tabController;
  var transRes = TransactionsResponse().obs;
  var isLoading = false.obs;
  var showShimmer = false.obs;
  int defaultIndex = 0;
  var selectedIndex = 0.obs;
  var transactions = <TransactionModel>[].obs;
  var transType = [
    'All',
    'AddMoney',
    'Monthly Interest Repayment',
    'WithdrawMoney'
  ];

  //ShowCase View
  late AppShowCases showCaseList;
  TutorialCoachMark? tutorialCoachMark;
  int showCasePosTransaction = 0;
  var allTransactionKey = GlobalKey();
  var investmentTransactionKey = GlobalKey();
  var interestTransactionKey = GlobalKey();
  var withdrawTransactionKey = GlobalKey();

  HomeController get homeController => Get.find<HomeController>();

  //Error handling
  var errorMsg = ''.obs;
  var retryError = "";
  var overlayLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
        vsync: this,
        initialIndex: defaultIndex,
        length: myLocal.appConfig.transactionTabs!.length);
    myLocal.appConfig.transactionTabs?.forEach((element) {
      myTabs.add(Tab(
        key: getKey(element.title!),
        text: element.title!,
      ));
    });
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        updateSelectedIndex(tabController.index);
        var tabTitleListTitle = myTabs[tabController.index].text;
        logEvent.tabTransaction(
            tabLabel: tabTitleListTitle!,
            page: "page_${transactionsScreen.substring(1)}");
      }
    });
    // callGetTransactions();
  }

  DashboardController dashboard() => Get.find<DashboardController>();

  getKey(String title) {
    switch (title) {
      case 'All':
        return allTransactionKey;
      case 'Investment':
        return investmentTransactionKey;
      case 'Interest':
        return interestTransactionKey;
      case 'Withdraw':
        return withdrawTransactionKey;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void showTutorialTransaction() {
    if (transRes.value.transactions != null && transRes.value.status!) {
      if (tutorialCoachMark!.targets.isNotEmpty) {
        tutorialCoachMark!.show(context: Get.context!);
      }
    }
  }

  List getWithdrawDetails(int index) {
    num redeemedPrincipal = 0;
    num redeemedInterest = 0;
    transactions[index].npi?.forEach((element) {
      redeemedPrincipal += element.redeemedPrincipal ?? 0;
      redeemedInterest += element.redeemedInterest ?? 0;
    });
    return [redeemedPrincipal, redeemedInterest];
  }

  Future<void> onPullRefresh() async {
    callGetTransactions();
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
    transactions.value = returnTransactionList(transType[index]);
  }

  List<TransactionModel> returnTransactionList(String txnType) {
    if (!transPresent) return [];
    switch (txnType) {
      case 'AddMoney':
        return transRes.value.transactions!
            .where((trans) =>
                trans.transactionType! == "Credit" &&
                (trans.transactionSubType! == "AddMoney" ||
                    trans.transactionSubType! == "Reinvestment"))
            .toList()
            .reversed
            .toList();
      case 'WithdrawMoney':
        return transRes.value.transactions!
            .where((trans) =>
                trans.transactionType! == "Debit" &&
                // trans.transactionSubType! != "VirtualRedemption" &&
                trans.transactionSubSubType! != "Monthly Interest Repayment")
            .toList()
            .reversed
            .toList();
      case 'Monthly Interest Repayment':
        return transRes.value.transactions!
            .where((trans) =>
                trans.transactionType! == "Debit" &&
                trans.transactionSubSubType! == txnType)
            .toList()
            .reversed
            .toList();
      default:
        return transRes.value.transactions?.reversed.toList() ?? [];
    }
  }

  List<TransactionModel> filterTransactionList(String type, String subType) {
    return transRes.value.transactions!
        .where((trans) =>
            trans.transactionType! == type &&
            trans.transactionSubType! == subType)
        .toList()
        .reversed
        .toList();
  }

  num get totalAmount {
    var amountList = <num>[];
    for (var element in transactions) {
      if (((element.transactionType == "Credit" &&
                  element.displayStatus == "Received") ||
              (element.transactionType == "Debit" &&
                  element.displayStatus == "Processed" &&
                  element.transactionSubType != "VirtualRedemption" &&
                  element.transactionSubType != "Penalty" &&
                  element.transactionSubType != "MonthlyInterestPayout")) &&
          selectedIndex.value != 0) {
        amountList.add(element.amount!);
      }
    }
    return amountList.fold(0, (previous, current) => previous + current);
  }

  String txnTypeLabel(String? type, String? subType) {
    switch (type) {
      case "AddMoney":
        return "credited".tr;
      case "WithdrawMoney":
      case "MonthlyInterestPayout":
        if (subType == "Monthly Interest Repayment") {
          return "interest_payout".tr;
        } else {
          return "debited".tr;
        }
      default:
        return type ?? "NA";
    }
  }

  String txnStatus(String? type, String? status) {
    if (type == 'AddMoney') {
      switch (status) {
        case "In Progress":
          return "Requested";
        case "Received":
          return "Invested";
        case "Rejected":
          return "Rejected";
        default:
          return status ?? "NA";
      }
    } else if (type == 'WithdrawMoney') {
      switch (status) {
        case "In Progress":
          return "Requested";
        case "Processed":
          return "Paid out";
        case "Rejected":
          return "Rejected";
        default:
          return status ?? "NA";
      }
    } else {
      switch (status) {
        case "In Progress":
          return "Requested";
        default:
          return status ?? "NA";
      }
    }
  }

  Color txnStatusColor(String? status) {
    switch (status) {
      case "In Progress":
        return yellowColor;
      case "Received":
      case "Processed":
        return greenColor;
      case "Rejected":
        return redColor;
      default:
        return grayColor;
    }
  }

  bool get transPresent =>
      transRes.value.transactions != null &&
      transRes.value.transactions!.isNotEmpty;

  void callGetTransactions() async {
    final params = {
      'investor_id': myLocal.userId,
    };
    if (myLocal.fetchFolios) params["fetch_folios"] = "true";
    if (!myLocal.fetchFolios) params["ifa_id"] = myLocal.ifaId;
    showShimmer.value = true;
    updateError(isError: true);
    myRepo.transactions(query: params).asStream().handleError((error) {
      showShimmer.value = false;
      updateError(isError: true, msg: error.toString(), retry: 'transactions');
    }).listen((response) {
      showShimmer.value = false;
      updateError();
      if (response.status!) {
        response.transactions!
            .sort((a, b) => a.transactionDate!.compareTo(b.transactionDate!));
        transRes.value = response;
        updateSelectedIndex(selectedIndex.value);
      } else {
        updateError(
            isError: true, msg: response.message!, retry: 'transactions');
      }
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'transactions':
        callGetTransactions();
        break;
      default:
        updateError();
        break;
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  updateError(
      {bool isError = false,
      String msg = '',
      String retry = '',
      bool showOverlay = false}) {
    overlayLoading.value = showOverlay;
    isLoading.value = isError;
    errorMsg.value = msg;
    retryError = retry;
  }

  ///--------ShowCase View Start------///
  void updateShowCaseStateTransaction({int pos = 100}) {
    var cases = myLocal.showCaseConfig;
    switch (pos) {
      case -1:
        cases.allTransaction = false;
        cases.investmentTransaction = false;
        cases.interest = false;
        cases.withdrawTransaction = false;
        break;
      case 0:
        cases.allTransaction = false;
        break;
      case 1:
        cases.investmentTransaction = false;
        break;
      case 2:
        cases.interest = false;
        break;
      case 3:
        cases.withdrawTransaction = false;
        break;
      default:
        break;
    }
    myLocal.appShowCases = cases;
  }

  void createTutorialTransaction() {
    showCaseList = myLocal.showCaseConfig;
    tutorialCoachMark = TutorialCoachMark(
        targets: _createTargetsTransaction().reversed.toList(),
        textSkip: "${"skip".tr}  >",
        onFinish: () {
          logEvent.showCaseEvent(
              page: "page_${transactionsScreen.substring(1)}",
              buttonLabel: "on_finish_show_case".tr,
              type: "");
          updateShowCaseStateTransaction();
        },
        onSkip: () {
          logEvent.showCaseEvent(
              page: "page_${transactionsScreen.substring(1)}",
              buttonLabel: "on_skip_show_case".tr,
              type: "");
          updateShowCaseStateTransaction(pos: -1);
        },
        onClickTarget: (target) {
          logEvent.showCaseEvent(
              page: "page_${transactionsScreen.substring(1)}",
              buttonLabel: "on_click_target_show_case".tr,
              type: "");
          updateShowCaseStateTransaction(pos: showCasePosTransaction);
          showCasePosTransaction++;
        },
        textStyleSkip: myStyle.myFontStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.bold,
            color: whiteColor),
        showSkipInLastTarget: false);
  }

  List<TargetFocus> _createTargetsTransaction() {
    List<TargetFocus> targets = [];

    if (showCaseList.withdrawTransaction) {
      showCasePosTransaction = 3;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${transactionsScreen.substring(1)}",
          keyTarget: withdrawTransactionKey,
          title: "withdraw_transaction".tr,
          description: "all_withdraw_transaction".tr,
          showNextButton: false,
          showPrevButton: showCaseList.interest,
          onPrevPress: () => {
                showCasePosTransaction--,
              },
          onFinishPress: () => {
                updateShowCaseStateTransaction(
                  pos: showCasePosTransaction,
                ),
              }));
    }
    if (showCaseList.interest) {
      showCasePosTransaction = 2;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${transactionsScreen.substring(1)}",
          keyTarget: interestTransactionKey,
          title: "interest_transaction".tr,
          description: "all_interest_transaction".tr,
          showPrevButton: showCaseList.investmentTransaction,
          onPrevPress: () => {
                showCasePosTransaction--,
              },
          onNextPress: () => {
                updateShowCaseStateTransaction(pos: showCasePosTransaction),
                showCasePosTransaction++,
              }));
    }
    if (showCaseList.investmentTransaction) {
      showCasePosTransaction = 1;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${transactionsScreen.substring(1)}",
          keyTarget: investmentTransactionKey,
          title: "investment_transaction".tr,
          description: "all_investment_transaction".tr,
          showPrevButton: showCaseList.allTransaction,
          onPrevPress: () => {
                showCasePosTransaction--,
              },
          onNextPress: () => {
                updateShowCaseStateTransaction(pos: showCasePosTransaction),
                showCasePosTransaction++,
              }));
    }
    if (showCaseList.allTransaction) {
      showCasePosTransaction = 0;
      targets.add(myWidget.tutorialTargetFocus(
          page: "page_${transactionsScreen.substring(1)}",
          keyTarget: allTransactionKey,
          title: "all_transactions".tr,
          description: "its_all_investment".tr,
          onNextPress: () => {
                updateShowCaseStateTransaction(pos: showCasePosTransaction),
                showCasePosTransaction++,
              }));
    }
    return targets;
  }

  ///--------ShowCase View End------///
}
