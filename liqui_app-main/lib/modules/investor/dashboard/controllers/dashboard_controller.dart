import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/networking/my_repositories.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/my_widget.dart';
import 'package:liqui_app/modules/investor/dashboard/models/dashboard_summary_response.dart';
import 'package:liqui_app/modules/investor/home/controllers/home_controller.dart';
import 'package:liqui_app/modules/investor/select_folio/controllers/hierarchy_controller.dart';
import 'package:liqui_app/modules/investor/select_folio/models/investor_hierarchy_response.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import '../../home/controllers/max_invest_controller.dart';

class DashboardController extends GetxController {
  final HierarchyController hierarchyCon = Get.find();
  var hierarchyRes = InvestorHierarchyResponse().obs;
  var dashboardRes = DashboardSummaryModel().obs;
  var isLoading = false.obs;
  var showShimmer = false.obs;
  var images = [].obs;

  //Error handling
  var errorMsg = ''.obs;
  var overlayLoading = true.obs;
  var retryError = "";

  //showCase View
  late AppShowCases showCaseList;
  TutorialCoachMark? tutorialCoachMark;
  int showCasePosDashboard = 0;
  var portfolioKey = GlobalKey();
  var withdrawableKey = GlobalKey();
  var lockedKey = GlobalKey();
  var accruedKey = GlobalKey();
  var folioKey = GlobalKey();
  var investKey = GlobalKey();

  @override
  void onInit() {
    callGetInvestorHierarchy();
    initCarouselSliderList();
    super.onInit();
  }

  void showTutorial() {
    if (tutorialCoachMark!.targets.isNotEmpty) {
      tutorialCoachMark!.show(context: Get.context!);
    }
  }

  Future<void> onPullRefresh() async {
    hierarchyCon.ifaData.isNotEmpty
        ? home().updateFolioDetails()
        : callGetInvestorHierarchy();
  }

  HomeController home() => Get.find<HomeController>();

  MinMaxInvestController maxInvestController() =>
      Get.find<MinMaxInvestController>();

  void callGetInvestorHierarchy() {
    updateError(isError: true);
    showShimmer.value = true;
    hierarchyCon.callGetInvestorHierarchy().then((status) async {
      if (Get.currentRoute != otpScreen) home().updateFolioDetails();
      // if(hierarchyCon.showRegisterButton) {
      //   myHelper.chooseFolio(
      //     showAllFolio: true,
      //     onChanged: () {},
      //   );
      // }
      /* if (status[0]) {
        // callGetDashboardSummary();
      } else {
        showShimmer.value = false;
        updateError(isError: true, msg: status[1], retry: 'investor_hierarchy');
      }*/
    });
  }

  void initCarouselSliderList() {
    myLocal.appConfig.dashboardActions!.corouselItems?.forEach((element) {
      images.add(element);
    });
  }

  DashboardDetailsModel get dashboardDetails =>
      dashboardRes.value.dashboardDetails != null
          ? dashboardRes.value.dashboardDetails!
          : DashboardDetailsModel();

  void callGetDashboardSummary() async {
    final params = {
      'investor_id': myLocal.userId,
    };
    if (myLocal.fetchFolios) params["fetch_folios"] = "true";
    if (!myLocal.fetchFolios) params["ifa_id"] = myLocal.ifaId;
    showShimmer.value = true;
    updateError(isError: true);
    myRepo.dashboardSummary(query: params).asStream().handleError((error) {
      showShimmer.value = false;
      updateError(
          isError: true, msg: error.toString(), retry: 'dashboard_summary');
    }).listen((response) {
      showShimmer.value = false;
      updateError();
      if (response.status!) {
        dashboardRes.value = response.dashboardSummary!;
        Future.delayed(const Duration(milliseconds: 700), () {
          createTutorialDashboard();
          showTutorial();
        });
      } else {
        updateError(
            isError: true, msg: response.message!, retry: 'dashboard_summary');
      }
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError) {
      case 'investor_hierarchy':
        callGetInvestorHierarchy();
        break;
      case 'dashboard_summary':
        callGetDashboardSummary();
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

  bool get enableInvestFund => (!isLoading.value &&
      maxInvestController().maxInvestmentAmount >
          maxInvestController().minInvestmentAmount);

  ///----------ShowCase View Start---------///
  void updateShowCaseStateDashboard({int pos = 100}) {
    var cases = myLocal.showCaseConfig;
    switch (pos) {
      case -1:
        cases.portfolio = false;
        cases.withdrawableDash = false;
        cases.lockedDash = false;
        cases.accruedDash = false;
        cases.investNow = false;
        cases.chooseFolioDash = false;
        break;
      case 0:
        cases.chooseFolioDash = false;
        break;
      case 1:
        cases.portfolio = false;
        break;
      case 2:
        cases.withdrawableDash = false;
        break;
      case 3:
        cases.lockedDash = false;
        break;
      case 4:
        cases.accruedDash = false;
        break;
      case 5:
        cases.investNow = false;
        break;
      default:
        break;
    }
    myLocal.appShowCases = cases;
  }

  void createTutorialDashboard() {
    showCaseList = myLocal.showCaseConfig;
    tutorialCoachMark = TutorialCoachMark(
        targets: _createTargetsDashboard().reversed.toList(),
        textSkip: "${"skip".tr}  >",
        onFinish: () {
          logEvent.showCaseEvent(
              page: "page_${dashboardScreen.substring(1)}",
              buttonLabel: "on_finish_show_case".tr,
              type: "");
          updateShowCaseStateDashboard();
        },
        onSkip: () {
          logEvent.showCaseEvent(
              page: "page_${dashboardScreen.substring(1)}",
              buttonLabel: "on_skip_show_case".tr,
              type: "");
          updateShowCaseStateDashboard(pos: -1);
        },
        onClickTarget: (target) {
          logEvent.showCaseEvent(
              page: "page_${dashboardScreen.substring(1)}",
              buttonLabel: "on_click_target_show_case".tr,
              type: "");
          updateShowCaseStateDashboard(pos: showCasePosDashboard);
          showCasePosDashboard++;
        },
        showSkipInLastTarget: false,
        textStyleSkip: myStyle.myFontStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.bold,
            color: whiteColor));
  }

  List<TargetFocus> _createTargetsDashboard() {
    List<TargetFocus> targets = [];
    if (showCaseList.investNow) {
      showCasePosDashboard = 5;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: investKey,
          title: "add_money".tr,
          description: "add_money_investment".tr,
          showNextButton: false,
          showPrevButton: showCaseList.accruedDash,
          page: "page_${dashboardScreen.substring(1)}",
          onPrevPress: () => {
                showCasePosDashboard--,
              },
          onFinishPress: () => {
                updateShowCaseStateDashboard(
                  pos: showCasePosDashboard,
                )
              }));
    }
    if (showCaseList.accruedDash) {
      showCasePosDashboard = 4;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: accruedKey,
          title: "Accrued_value".tr,
          description: "your_Accrued_value".tr,
          showPrevButton: showCaseList.lockedDash,
          page: "page_${dashboardScreen.substring(1)}",
          onPrevPress: () => {
                showCasePosDashboard--,
              },
          onNextPress: () => {
                updateShowCaseStateDashboard(pos: showCasePosDashboard),
                showCasePosDashboard++,
              }));
    }
    if (showCaseList.lockedDash) {
      showCasePosDashboard = 3;

      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: lockedKey,
          title: "locked_value".tr,
          description: "your_locked_value".tr,
          showPrevButton: showCaseList.withdrawableDash,
          page: "page_${dashboardScreen.substring(1)}",
          onPrevPress: () => {
                showCasePosDashboard--,
              },
          onNextPress: () => {
                updateShowCaseStateDashboard(pos: showCasePosDashboard),
                showCasePosDashboard++,
              }));
    }
    if (showCaseList.withdrawableDash) {
      showCasePosDashboard = 2;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: withdrawableKey,
          title: "withdrawable_value".tr,
          description: "your_withdrawable_value".tr,
          showPrevButton: showCaseList.portfolio,
          page: "page_${dashboardScreen.substring(1)}",
          onPrevPress: () => {
                showCasePosDashboard--,
              },
          onNextPress: () => {
                updateShowCaseStateDashboard(pos: showCasePosDashboard),
                showCasePosDashboard++,
              }));
    }
    if (showCaseList.portfolio) {
      showCasePosDashboard = 1;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: portfolioKey,
          title: "total_portfolio_value".tr,
          description: "your_portfolio_value".tr,
          page: "page_${dashboardScreen.substring(1)}",
          showPrevButton: showCaseList.chooseFolioDash,
          onPrevPress: () => {
                showCasePosDashboard--,
              },
          onNextPress: () => {
                updateShowCaseStateDashboard(pos: showCasePosDashboard),
                showCasePosDashboard++,
              }));
    }
    if (showCaseList.chooseFolioDash) {
      showCasePosDashboard = 0;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: folioKey,
          title: "select_folio".tr,
          description: "select_your_folio".tr,
          showSkipBottom: true,
          page: "page_${dashboardScreen.substring(1)}",
          onNextPress: () => {
                logEvent.showCaseEvent(
                    page: "page_${dashboardScreen.substring(1)}",
                    buttonLabel: "next".tr,
                    type: "select_folio".tr),
                updateShowCaseStateDashboard(pos: showCasePosDashboard),
                showCasePosDashboard++,
              }));
    }
    return targets;
  }

  ///----------ShowCase View End---------///
}
