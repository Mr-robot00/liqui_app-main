import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/pages/index.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/modules/investor/dashboard/controllers/dashboard_controller.dart';
import 'package:liqui_app/modules/investor/home/controllers/max_invest_controller.dart';
import 'package:liqui_app/modules/investor/home/models/bottom_navigator_model.dart';
import 'package:liqui_app/modules/investor/portfolio_transaction/controllers/portfolio_transaction_controller.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';
import 'package:liqui_app/modules/investor/transactions/controllers/transactions_controller.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  DashboardController dashCon = Get.find();
  ProfileController profileCon = Get.find();
  TransactionsController transCon = Get.find();
  MinMaxInvestController maxInvestCon = Get.find();
  PortfolioTransactionController portfolioTransController = Get.find();
  List<BottomNavigatorModel> bottomNavigatorList = [];
  List<Widget> tabWidgetList = [];

  @override
  void onInit() {
    super.onInit();

    /// add data to bottom navigator
    bottomNavigatorList.add(BottomNavigatorModel(
        title: 'dashboard'.tr,
        icon: myHelper.svgIcon('assets/images/dashboard.svg',
            height: 24, width: 24),
        activeIcon: myHelper.svgIcon('assets/images/dashboard.svg',
            color: Get.isDarkMode ? whiteColor : primaryColor,
            height: 24,
            width: 24),
        navigateTo: const Dashboard()));
    bottomNavigatorList.add(BottomNavigatorModel(
        title: 'investments'.tr,
        icon: myHelper.svgIcon('assets/images/folio_transaction.svg',
            height: 24, width: 24),
        activeIcon: myHelper.svgIcon('assets/images/folio_transaction.svg',
            color: Get.isDarkMode ? whiteColor : primaryColor,
            height: 24,
            width: 24),
        navigateTo: const PortfolioTransaction()));
    bottomNavigatorList.add(BottomNavigatorModel(
        title: 'transaction'.tr,
        icon: myHelper.svgIcon('assets/images/transaction.svg',
            height: 24, width: 24),
        activeIcon: myHelper.svgIcon('assets/images/transaction.svg',
            color: Get.isDarkMode ? whiteColor : primaryColor,
            height: 24,
            width: 24),
        navigateTo: const Transactions()));
    bottomNavigatorList.add(BottomNavigatorModel(
        title: 'profile'.tr,
        icon: myHelper.svgIcon('assets/images/profile.svg',
            height: 24, width: 24),
        activeIcon: myHelper.svgIcon('assets/images/profile.svg',
            color: Get.isDarkMode ? whiteColor : primaryColor,
            height: 24,
            width: 24),
        navigateTo: const Profile()));

    /// add data for tab navigation
    for (var element in bottomNavigatorList) {
      tabWidgetList.add(element.navigateTo);
    }
  }

  List<BottomNavigationBarItem> getNavigationBar() {
    List<BottomNavigationBarItem> tabBarList = [];
    for (var element in bottomNavigatorList) {
      tabBarList.add(BottomNavigationBarItem(
        label: element.title,
        icon: element.icon,
        activeIcon: element.activeIcon,
      ));
    }
    return tabBarList;
  }

  /// which pages need to update on try_again
  bool dashBoardRetry = false;
  bool transactionsRetry = false;
  bool profileRetry = false;

  //update details on folio change
  updateFolioDetails() {
    dashCon.callGetDashboardSummary();
    transCon.callGetTransactions();
    profileCon.onPullRefresh();
    portfolioTransController.callGetInvestmentSummary();
    maxInvestCon.callGetMinMaxInvestment();
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    if (bottomNavigatorList[index].title == 'dashboard'.tr) {
      logEvent.tabBottomNavigation(
          pageLabel: 'dashboard'.tr, page: "page_${homeScreen.substring(1)}");
    }
    if (bottomNavigatorList[index].title == 'transaction'.tr) {
      logEvent.tabBottomNavigation(
          pageLabel: 'transaction'.tr, page: "page_${homeScreen.substring(1)}");
      transCon.createTutorialTransaction();
      transCon.showTutorialTransaction();
    }
    if (bottomNavigatorList[index].title == 'investments'.tr) {
      logEvent.tabBottomNavigation(
          pageLabel: 'investments'.tr, page: "page_${homeScreen.substring(1)}");
    }
    if (bottomNavigatorList[index].title == 'profile'.tr) {
      logEvent.tabBottomNavigation(
          pageLabel: 'profile'.tr, page: "page_${homeScreen.substring(1)}");
      profileCon.createTutorialProfile();
      profileCon.showTutorialProfile();
    }
    update();
  }

  void tryAgain() {
    if (dashBoardRetry) dashCon.callGetDashboardSummary();
    if (transactionsRetry) transCon.handleRetryAction();
    if (profileRetry) profileCon.handleRetryAction();
    maxInvestCon.callGetMinMaxInvestment();
  }
}
