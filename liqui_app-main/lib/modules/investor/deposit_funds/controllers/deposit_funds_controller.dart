import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/networking/api_path.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/my_widget.dart';
import 'package:liqui_app/modules/investor/deposit_funds/models/get_returns_response.dart';
import 'package:liqui_app/modules/investor/deposit_funds/models/investor_scheme_response.dart';
import 'package:liqui_app/modules/investor/deposit_funds/models/label_list_model.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../global/networking/my_repositories.dart';
import '../../../../global/utils/helpers/my_helper.dart';
import '../../home/controllers/max_invest_controller.dart';

class DepositFundsController extends GetxController {
  //DashboardController dashboardController = Get.find();
  ProfileController profile = Get.find();
  MinMaxInvestController maxInvestController = Get.find();
  final amountController = TextEditingController();
  final folioController = TextEditingController();
  var investorSchemeRes = InvestorSchemeResponse().obs;
  var totalInterest = '0'.obs;
  var rateOfInterest = '0'.obs;
  var selectedMHP = 0.obs;
  var fetchingInterest = false.obs;
  var schemeReturnAmount = SchemeReturnData();
  var disableButton = true.obs;
  var isSliderChartDisable = true.obs;
  var selectedSchemeTypeIndex = 0.obs;
  var selectedPayoutTypeIndex = 0.obs;
  var selectedAmountIndex = 0.obs;
  var folioSchemeId = '';
  FocusNode focusNode = FocusNode();
  InvestorSchemeData? selectedSchemeModel;
  InvestorSchemeData? folioSchemeModel;
  List<LabelListModel> schemeTypeLabelList = [];
  List<LabelListModel> payoutTypeList = [];
  List<LabelListModel> amountList = [];

  String? schemeAmount;
  String? schemeTenure;

  // lockin slider
  var divs = <int>[].obs;
  final divsAddedText = <String>[].obs;

  List<InvestorSchemeData> schemeList = [];
  // var schemeItems = <DropdownMenuItem>[].obs;
  Map<String, String> amountMap = {
    '₹10K': '10000',
    '₹20K': '20000',
    '₹50K': '50000',
    '₹1Lakh': '100000',
    '₹2Lakh': '200000',
  };

  //ShowCase View
  late AppShowCases showCaseList;
  TutorialCoachMark? tutorialCoachMark;
  int showCasePosDeposit = 0;
  var schemeTypeKey = GlobalKey();
  var amountToInvestKey = GlobalKey();
  var payOutTypeKey = GlobalKey();
  var interestEarnedKey = GlobalKey();
  var annualizedReturnKey = GlobalKey();
  var chooseFolioKey = GlobalKey();
  // var compareReturnsKey = GlobalKey();
  var lockInTenureKey = GlobalKey();

  //Error handling
  var errorMsg = ''.obs;
  var overlayLoading = true.obs;
  var retryError = ''.obs;
  var isLoading = false.obs;

  bool get isLiquid => selectedSchemeTypeIndex.value == 0;

  bool get isLockIn => selectedSchemeTypeIndex.value == 1;

  bool get isGrowth => selectedPayoutTypeIndex.value == 0;

  bool get isMonthly => selectedPayoutTypeIndex.value == 1;

  bool get isAmountControllerEmpty => amountController.text.isEmpty;

  StreamSubscription? eventSchemeApiCalling;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments["schemeType"] == 'lock-in'.tr) {
        selectedSchemeTypeIndex.value = 1;
      }
      folioSchemeId = Get.arguments["schemeId"] ?? '';
      // print('FolioSchemeId $folioSchemeId');

      if (folioSchemeId.validString) {
        selectedSchemeTypeIndex.value = Get.arguments["schemeTypeIndex"] ?? 0;
      }
    }
    focusNode.addListener(() {
      if (!focusNode.hasFocus && amountController.text.validString) {
        logEvent.inputInvestFundAmount(
            page: "page_${depositFundsScreen.substring(1)}",
            amount: num.parse(amountController.text),
            schemeType: isLiquid ? 'liquid'.tr : 'lock-in'.tr,
            schemeId: selectedSchemeModel!.schemeId!.toInt());
      }
    });

    if ((Get.arguments as Map?)?.keys.contains('amount') ?? false) {
      if (Get.arguments['amount'] != null) {
        schemeAmount = Get.arguments['amount'];
      }
    }
    if ((Get.arguments as Map?)?.keys.contains('lockInTenure') ?? false) {
      if (Get.arguments['lockInTenure'] != null) {
        schemeTenure = Get.arguments['lockInTenure'];
      }
    }
    checkInvestmentLimitFetched();

    /// on_change of amount
    amountController.addListener(
      () => filterSchemeChoiceWise(
        selectedMHPPosition: divs.indexOf(selectedMHP.value),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    folioController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void showTutorial() {
    if (investorSchemeRes.value.data != null &&
        investorSchemeRes.value.status! &&
        schemeList.isNotEmpty) {
      if (tutorialCoachMark!.targets.isNotEmpty) {
        tutorialCoachMark?.show(context: Get.context!);
      }
    }
  }

  @override
  void onClose() {
    tutorialCoachMark?.finish();
    eventSchemeApiCalling?.cancel();
  }

  void checkInvestmentLimitFetched() {
    if (!maxInvestController.loading) {
      if (maxInvestController.minMaxInvestmentAmountFetched.value) {
        amountController.text = schemeAmount ??
            maxInvestController.minInvestmentAmount.toInt().toString();
        schemeAmount = null;

        getAmountChoiceChip();
        callGetInvestorScheme();
      } else {
        callGetMaximumValue();
      }
    } else {
      updateError(isError: true);
    }
  }

  void investmentDataFetched(bool status, {String? msg}) {
    updateError();
    if (status) {
      checkInvestmentLimitFetched();
    } else {
      updateError(
          isError: true,
          msg: msg ?? "something_went_wrong".tr,
          retry: "max_invest");
    }
  }

  void callGetMaximumValue() {
    updateError(isError: true);
    maxInvestController.callGetMinMaxInvestment().then((value) {
      updateError();
      if (value[0]) {
        if (schemeList.isEmpty) {
          callGetInvestorScheme();
          getAmountChoiceChip();
        }
        amountController.text =
            maxInvestController.minInvestmentAmount.toInt().toString();
      } else {
        updateError(isError: true, msg: value[1], retry: 'max_invest');
      }
    });
  }

  void callGetInvestorScheme({bool clearList = false}) async {
    // if (clearList) schemeItems.clear();
    final params = {'investor_id': myLocal.userId};
    updateError(isError: true);
    myRepo.getInvestorSchemes(query: params).asStream().handleError((error) {
      updateError(
          isError: true, msg: error.toString(), retry: 'investor_scheme');
    }).listen((response) {
      updateError();
      if (response.status!) {
        investorSchemeRes.value = response;
        schemeList = [];
        // printLog("schemes before: ${response.data!.length}");
        var skipSchemes = myLocal.appConfig.skipSchemesData != null
            ? baseUrl == stgBaseUrl
                ? myLocal.appConfig.skipSchemesData!.stage!
                : myLocal.appConfig.skipSchemesData!.prod!
            : [];

        for (InvestorSchemeData scheme in response.data!) {
          if (!skipSchemes.contains(scheme.schemeId) &&
              (scheme.qualityValue?.toLowerCase().contains('s2') ?? false)) {
            schemeList.add(scheme);
          }
        }
        // printLog("schemes after: ${schemeList.length}");
        // for (var scheme in schemeList) {
        //   printLog("scheme: ${jsonEncode(scheme)}");
        // }
        // schemeList = response.data!;
        Future.delayed(const Duration(milliseconds: 700), () {
          createTutorialDeposit();
          showTutorial();
        });
        setInitialData();
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  // bool isFirst = true;
  void callGetAmountReturn() async {
    fetchingInterest.value = true;
    final params = {
      'investor_id': myLocal.userId,
      'amount': amountController.text.toString(),
      'scheme_id': selectedSchemeModel?.schemeId.toString(),
    };

    myRepo.getReturns(query: params).asStream().handleError((error) {
      fetchingInterest.value = false;
      updateError(isError: true, msg: error.toString(), retry: 'return_amount');
    }).listen((response) {
      fetchingInterest.value = false;
      updateError();
      if (response.status!) {
        schemeReturnAmount = response.schemeReturnData!;
        if (isLockIn && isGrowth) {
          totalInterest.value =
              schemeReturnAmount.interestAmount!.toStringAsFixed(2);
          totalInterest.value =
              (num.parse(totalInterest.value).toStringAsFixed(2));
        } else {
          totalInterest.value =
              schemeReturnAmount.interestAmount!.toStringAsFixed(2);
        }
        updateButtonStatus();
        // if (!isFirst) {
        // focusNode.requestFocus();
        // isFirst = false;
        // }
      } else {
        updateError(isError: true, msg: response.message.toString());
      }
    });
  }

  void getAmountChoiceChip() {
    num maximumInvestValue = maxInvestController.maxInvestmentAmount;
    if (maximumInvestValue > 0) {
      if (maximumInvestValue < 10000) {
        amountList = [];
      } else if (maximumInvestValue >= 10000 && maximumInvestValue < 20000) {
        amountList = [LabelListModel(label: '₹10K', disabled: false)];
      } else if (maximumInvestValue >= 20000 && maximumInvestValue < 50000) {
        amountList = [
          LabelListModel(label: '₹10K', disabled: false),
          LabelListModel(label: '₹20K', disabled: false)
        ];
      } else if (maximumInvestValue >= 50000 && maximumInvestValue < 100000) {
        amountList = [
          LabelListModel(label: '₹10K', disabled: false),
          LabelListModel(label: '₹20K', disabled: false),
          LabelListModel(label: '₹50K', disabled: false)
        ];
      } else if (maximumInvestValue >= 100000 && maximumInvestValue < 200000) {
        amountList = [
          LabelListModel(label: '₹10K', disabled: false),
          LabelListModel(label: '₹20K', disabled: false),
          LabelListModel(label: '₹50K', disabled: false),
          LabelListModel(label: '₹1Lakh', disabled: false)
        ];
      } else if (maximumInvestValue >= 200000) {
        amountList = [
          LabelListModel(label: '₹10K', disabled: false),
          LabelListModel(label: '₹20K', disabled: false),
          LabelListModel(label: '₹50K', disabled: false),
          LabelListModel(label: '₹1Lakh', disabled: false),
          LabelListModel(label: '₹2Lakh', disabled: false)
        ];
      }
    }
  }

  void setInitialData() {
    //set liquid data
    schemeTypeLabelList = [];
    final liquidSchemes = filterSchemes();
    schemeTypeLabelList.add(
        LabelListModel(label: 'liquid'.tr, disabled: liquidSchemes.isEmpty));

    //set lock-in data
    final lockInSchemes = filterSchemes(isLiquid: false);
    schemeTypeLabelList.add(
        LabelListModel(label: 'lock-in'.tr, disabled: lockInSchemes.isEmpty));
    if (liquidSchemes.isEmpty) {
      selectedSchemeTypeIndex.value = 1;
    } else if (lockInSchemes.isEmpty) {
      selectedSchemeTypeIndex.value = 0;
      selectedMHP.value = 0;
    }
    if (liquidSchemes.isNotEmpty || lockInSchemes.isNotEmpty) {
      filterSchemeChoiceWise();
    }
  }

  void updatePayoutOptions() {
    final schemes = filterSchemes(isLiquid: isLiquid);
    payoutTypeList = [];
    if (schemes.isNotEmpty) {
      final growthSchemes = filterPayoutSchemes(data: schemes, pType: "Growth");
      payoutTypeList.add(
          LabelListModel(label: 'growth'.tr, disabled: growthSchemes.isEmpty));
      final monthlySchemes =
          filterPayoutSchemes(data: schemes, pType: "Monthly");
      payoutTypeList.add(LabelListModel(
          label: 'monthly'.tr, disabled: monthlySchemes.isEmpty));

      if (growthSchemes.isEmpty) {
        selectedPayoutTypeIndex.value = 1;
      } else if (monthlySchemes.isEmpty) {
        selectedPayoutTypeIndex.value = 0;
      }
      // print('Growth ${growthSchemes.length}, Monthly ${monthlySchemes.length}');
    }
  }

  List<InvestorSchemeData> filterSchemes({bool isLiquid = true}) {
    return schemeList
        .where((scheme) =>
            isLiquid ? scheme.lockinMonth == 0 : scheme.lockinMonth != 0)
        .toList()
        .where((element) =>
            maxInvestController.maxInvestmentAmount >= element.startAmount!)
        .toList()
        .where((element) => element.schemeFor != "FirstTimeOnly")
        .toList();
  }

  List<InvestorSchemeData> filterPayoutSchemes(
      {required List<InvestorSchemeData> data, required String pType}) {
    return data.where((scheme) => scheme.invPayoutType == pType).toList();
  }

  void filterSchemeChoiceWise({int selectedMHPPosition = 0}) {
    updatePayoutOptions();
    isLiquid
        ? filterLiquidSchemes()
        : filterLockInSchemes(selectedMHPPosition: selectedMHPPosition);
  }

  void filterLiquidSchemes() {
    selectedMHP.value = 0;
    var zeroMHPList = filterSchemes(isLiquid: isLiquid);
    if (folioSchemeId.validString && Get.arguments["schemeTypeIndex"] != 0) {
      var filteredZeroMHPList = zeroMHPList
          .where((element) => element.schemeId.toString() == folioSchemeId)
          .toList();
      if (filteredZeroMHPList.isNotEmpty) {
        selectedPayoutTypeIndex.value =
            filteredZeroMHPList.first.invPayoutType == "Monthly" ? 1 : 0;
        selectedSchemeModel = filteredZeroMHPList.first;
        rateOfInterest.value = selectedSchemeModel!.roi!.toStringAsFixed(2);
        fetchInterest();
      } else {
        nonFolioFilteredLiquidList(zeroMHPList: zeroMHPList);
      }
    } else {
      nonFolioFilteredLiquidList(zeroMHPList: zeroMHPList);
    }
  }

  void filterLockInSchemes({int selectedMHPPosition = 0}) {
    divs.clear();
    divsAddedText.clear();
    var schemes = filterSchemes(isLiquid: isLiquid);
    final dayScheme = <InvestorSchemeData>[];

    /// adding days_scheme in [daysScheme]
    schemes.removeWhere((e) {
      if (e.lockinType?.toLowerCase().contains('days') ?? false) {
        dayScheme.add(e);
        return true;
      }
      return false;
    });

    /// month scheme sorting
    schemes.sort((a, b) => a.lockinMonth?.compareTo(b.lockinMonth ?? 0) ?? 0);

    /// days scheme sorting
    dayScheme.sort((a, b) => a.lockinMonth?.compareTo(b.lockinMonth ?? 0) ?? 0);

    /// add days + months scheme in sorted order
    schemes = (dayScheme + schemes);

    for (InvestorSchemeData e in schemes) {
      if (divs.contains(e.lockinMonth)) continue;

      if (e.invPayoutType ==
          payoutTypeList[selectedPayoutTypeIndex.value].title) {
        divs.add(e.lockinMonth?.toInt() ?? 0);

        /// adding 'D' for days & 'M' for months
        if (e.lockinType?.toLowerCase().contains('days') ?? false) {
          divsAddedText.add('D');
        } else if (e.lockinType?.toLowerCase().contains('months') ?? false) {
          divsAddedText.add('M');
        }
      }
    }

    if (folioSchemeId.validString && Get.arguments["schemeTypeIndex"] != 1) {
      var filteredNonZeroMHPList = schemes
          .where((element) => element.schemeId.toString() == folioSchemeId)
          .toList();
      if (filteredNonZeroMHPList.isNotEmpty) {
        renderMHPList(
            position: divs.indexWhere((element) =>
                element ==
                int.parse(
                    filteredNonZeroMHPList.first.lockinMonth.toString())));
        selectedPayoutTypeIndex.value =
            filteredNonZeroMHPList.first.invPayoutType == "Monthly" ? 1 : 0;
        selectedSchemeModel = filteredNonZeroMHPList.first;
        rateOfInterest.value = selectedSchemeModel!.roi!.toStringAsFixed(2);
        fetchInterest();
      } else {
        nonFolioFilteredLockInList(
            schemes: schemes, selectedMHPPosition: selectedMHPPosition);
      }
    } else {
      nonFolioFilteredLockInList(
          schemes: schemes, selectedMHPPosition: selectedMHPPosition);
    }
  }

  void nonFolioFilteredLiquidList(
      {required List<InvestorSchemeData> zeroMHPList}) {
    zeroMHPList = zeroMHPList
        .where((element) =>
            element.invPayoutType ==
            payoutTypeList[selectedPayoutTypeIndex.value].title)
        .toList();
    _highestROI(zeroMHPList);
  }

  void nonFolioFilteredLockInList(
      {required List<InvestorSchemeData> schemes,
      required int selectedMHPPosition}) {
    renderMHPList(position: selectedMHPPosition);
    var nonZeroMHPList = schemes
        .where((element) =>
            element.lockinMonth == int.parse(selectedMHP.value.toString()) &&
            element.invPayoutType ==
                payoutTypeList[selectedPayoutTypeIndex.value].title)
        .toList();
    nonZeroMHPList.sort(
        (current, next) => current.lockinMonth!.compareTo(next.lockinMonth!));
    _highestROI(nonZeroMHPList);
  }

  void _highestROI(List<InvestorSchemeData> list) {
    if (list.isNotEmpty) {
      final List<InvestorSchemeData> temp = _checkAmount(list);
      selectedSchemeModel = (temp.isEmpty ? list : temp).reduce(
        (current, next) => current.roi! > next.roi! ? current : next,
      );
      rateOfInterest.value = selectedSchemeModel!.roi!.toStringAsFixed(2);
      fetchInterest();
    } else {
      selectedSchemeModel = null;
    }
  }

  /// returns the list of scheme which are falling the the amount [_checkAmount]
  List<InvestorSchemeData> _checkAmount(List<InvestorSchemeData>? scheme) {
    final amount = num.tryParse(amountController.text) ?? 0;

    /// creating a copy
    final temp = List.generate((scheme?.length ?? 0), (i) {
      return InvestorSchemeData(
        chargeType: scheme?[i].chargeType,
        defaultScheme: scheme?[i].defaultScheme,
        defaultSchemeId: scheme?[i].defaultSchemeId,
        displayScheme: scheme?[i].defaultScheme,
        doubleAdvantageScheme: scheme?[i].doubleAdvantageScheme,
        endAmount: scheme?[i].endAmount,
        lockinBreak: scheme?[i].lockinBreak,
        lockinAmountType: scheme?[i].lockinAmountType,
        lockinType: scheme?[i].lockinType,
        interestCalculationType: scheme?[i].interestCalculationType,
        invPayoutType: scheme?[i].invPayoutType,
        investmentType: scheme?[i].investmentType,
        lockinMonth: scheme?[i].lockinMonth,
        mhpDisplay: scheme?[i].mhpDisplay,
        nextSchemeId: scheme?[i].nextSchemeId,
        payoutDay: scheme?[i].payoutDay,
        prevSchemeId: scheme?[i].prevSchemeId,
        roi: scheme?[i].roi,
        schemeFor: scheme?[i].schemeFor,
        schemeId: scheme?[i].schemeId,
        schemeName: scheme?[i].schemeName,
        schemeType: scheme?[i].schemeType,
        startAmount: scheme?[i].startAmount,
        status: scheme?[i].status,
      );
    });

    /// remove the scheme which does not lies between the range
    temp.removeWhere(
      (e) {
        final isValidAmount =
            !(amount >= (e.startAmount ?? 0) && amount <= (e.endAmount ?? 0));
        final invType = (isMonthly
                ? e.invPayoutType?.toLowerCase().contains('monthly')
                : e.invPayoutType?.toLowerCase().contains('growth')) ??
            false;

        return isValidAmount && invType;
      },
    );
    return temp;
  }

  void fetchInterest() {
    if (amountErrorMsg == null) {
      callGetAmountReturn();
    } else {
      updateButtonStatus();
    }
  }

  bool validate() {
    updateError(isError: true);

    ///consider min inv value
    var intMaxInvest = maxInvestController.maxInvestmentAmount.toInt();
    var intAmountController =
        int.parse(!isAmountControllerEmpty ? amountController.text : '0');
    var intMinInvest = maxInvestController.minInvestmentAmount.toInt();
    if (intAmountController > intMaxInvest) {
      updateError(
          isError: true,
          msg: '${'enter_amount_less_than'.tr} $rupeeSymbol$intMaxInvest');
      return false;
    } else if (intAmountController < intMinInvest) {
      updateError(
          isError: true,
          msg: '${'enter_amount_greater_than'.tr} $rupeeSymbol$intMinInvest');
      return false;
    }
    callGetAmountReturn();
    return true;
  }

  void investNow() {
    if (profile.kycUnderReview) {
      myWidget.showPopUp("kyc_under_review".tr, title: "kyc_updates".tr);
    } else if (!profile.kycVerified &&
        !profile.kycUnderReview &&
        !profile.kycRejected) {
      myWidget.kycAlertDialog(screenName: depositFundsScreen.substring(1));
    } else if (profile.kycRejected) {
      myWidget.kycAlertDialog(
          kycRejectionMessage:
              "${'sorry_kyc_verification_failed'.tr} ${profile.basicDetailRes.value.data!.kycData?[0].kycRejectionReasons} ${"please_try_again".tr}.",
          forKycRejection: true,
          screenName: depositFundsScreen.substring(1));
    } else if (myHelper.isIFAValid()) {
      logEvent.buttonInvestNow(
          schemeId: selectedSchemeModel!.schemeId!.toInt(),
          amount: num.parse(
              amountController.text.validString ? amountController.text : "0"),
          gatewayType: schemeTypeLabelList[selectedSchemeTypeIndex.value].title,
          page: "page_${depositFundsScreen.substring(1)}");
      Get.toNamed(paymentGatewayScreen, arguments: {
        'amount': amountController.text,
        'investmentType':
            schemeTypeLabelList[selectedSchemeTypeIndex.value].title,
        'schemeId': selectedSchemeModel!.schemeId.toString(),
        'interestAmount': totalInterest.value
      });
    }
  }

  String? get amountErrorMsg {
    var intMaxInvest = maxInvestController.maxInvestmentAmount;
    var intMinInvest = maxInvestController.minInvestmentAmount;
    var intSchemeMinInvest = selectedSchemeModel?.startAmount ?? 0;
    var intSchemeMaxInvest = selectedSchemeModel?.endAmount ?? 0;
    var intAmountController =
        num.parse(isAmountControllerEmpty ? '0' : amountController.text);
    var schemes = filterSchemes(isLiquid: isLiquid);

    if (schemeList.isNotEmpty) {
      intSchemeMinInvest =
          _minmumInvestmentAmount(schemes) ?? intSchemeMinInvest;
      intSchemeMaxInvest =
          _maximumInvestmentAmount(schemes) ?? intSchemeMaxInvest;
    }

    if ((schemes.isEmpty || selectedSchemeModel?.schemeId == null) ||
        (divs.isEmpty && isLockIn)) {
      updateSliderState(true);
      return 'no_scheme_available'.tr;
    } else if (intMaxInvest < intMinInvest) {
      updateSliderState(true);
      return '${'minimum_investment_amount_error'.tr} $rupeeSymbol$intMinInvest';
    } else if (intAmountController < intMinInvest) {
      updateSliderState(true);
      return '${'enter_amount_greater_than'.tr} $rupeeSymbol$intMinInvest';
    } else if (intAmountController < intSchemeMinInvest) {
      updateSliderState(false);
      return '${'enter_amount_more_than_scheme_invest'.tr} $rupeeSymbol$intSchemeMinInvest';
    } else if (intAmountController > intMaxInvest) {
      updateSliderState(true);
      return '${'enter_amount_less_than'.tr} $rupeeSymbol$intMaxInvest';
    } else if (intAmountController > intSchemeMaxInvest) {
      updateSliderState(false);
      return '${'enter_amount_less_than_scheme_invest'.tr} $rupeeSymbol$intSchemeMaxInvest';
    } else if (intAmountController < (selectedSchemeModel?.startAmount ?? 0)) {
      return '${'enter_amount_more_than_scheme_invest'.tr} $rupeeSymbol${selectedSchemeModel?.startAmount}';
    } else {
      updateSliderState(false);
      return null;
    }
  }

  /// minimum investment amount for paticular tenure [_minmumInvestmentAmount]
  num? _minmumInvestmentAmount(List<InvestorSchemeData> schemes) {
    num minmumAmount = double.infinity;
    final filterScheme = <InvestorSchemeData>[];
    for (InvestorSchemeData e in schemes) {
      final invType = (isMonthly
              ? e.invPayoutType?.toLowerCase().contains('monthly')
              : e.invPayoutType?.toLowerCase().contains('growth')) ??
          false;

      if (e.lockinMonth == selectedSchemeModel?.lockinMonth &&
          e.invPayoutType == selectedSchemeModel?.invPayoutType &&
          invType) filterScheme.add(e);
    }
    for (InvestorSchemeData e in filterScheme) {
      if ((e.startAmount ?? 0) < minmumAmount) {
        minmumAmount = e.startAmount ?? 0;
      }
    }
    return (minmumAmount == double.infinity) ? null : minmumAmount;
  }

  /// max investment amount for paticular tenure [_maximumInvestmentAmount]
  num? _maximumInvestmentAmount(List<InvestorSchemeData> schemes) {
    num maximumAmount = double.negativeInfinity;
    final filterScheme = <InvestorSchemeData>[];
    for (InvestorSchemeData e in schemes) {
      final invType = (isMonthly
              ? e.invPayoutType?.toLowerCase().contains('monthly')
              : e.invPayoutType?.toLowerCase().contains('growth')) ??
          false;

      if (e.lockinMonth == selectedSchemeModel?.lockinMonth &&
          e.invPayoutType == selectedSchemeModel?.invPayoutType &&
          invType) filterScheme.add(e);
    }

    for (InvestorSchemeData e in filterScheme) {
      if ((e.endAmount ?? 0) > maximumAmount) maximumAmount = e.endAmount ?? 0;
    }
    return (maximumAmount == double.negativeInfinity) ? null : maximumAmount;
  }

  String get investmentTenure {
    if (selectedMHP.value != 0) {
      return '${selectedSchemeModel?.lockinMonth} '
          '${selectedSchemeModel?.lockinType}';
    }
    return 'liquid'.tr;
  }

  void updateSliderState(bool disable) async {
    Future.delayed(Duration.zero, () async {
      isSliderChartDisable.value = disable;
    });
  }

  void handleRetryAction() {
    updateLoading();
    switch (retryError.value) {
      case 'investor_scheme':
        callGetInvestorScheme();
        break;
      case 'return_amount':
        callGetAmountReturn();
        break;
      case 'max_invest':
        callGetMaximumValue();
        break;
      default:
        updateError();
        break;
    }
  }

  updateButtonStatus() {
    var intAmountController =
        num.parse(amountController.text.isEmpty ? '0' : amountController.text);
    if (isAmountControllerEmpty ||
        (intAmountController < maxInvestController.minInvestmentAmount) ||
        (maxInvestController.maxInvestmentAmount == 0 ||
            intAmountController > maxInvestController.maxInvestmentAmount) ||
        selectedSchemeModel?.schemeId == null ||
        (intAmountController < (selectedSchemeModel?.startAmount ?? 0)) ||
        (intAmountController > (selectedSchemeModel?.endAmount ?? 0)) ||
        (divs.isEmpty && isLockIn)) {
      disableButton.value = true;
    } else {
      disableButton.value = false;
    }
  }

  void updateLoading({bool loading = false}) {
    isLoading.value = loading;
  }

  void renderMHPList({int position = 0}) {
    divs.value = divs.toSet().toList();
    // divs.sort();
    if (divs.isNotEmpty) {
      if (divs.first == 0) divs.remove(0);
      if (divs.isNotEmpty) selectedMHP.value = divs[position];
    }
    if (schemeTenure != null) _selectTenure();
  }

  void _selectTenure() {
    String? time = schemeTenure?.toLowerCase();
    if (time?.contains('months') ?? false) {
      time = '${time?.split(' ').first}M';
    } else if (time?.contains('days') ?? false) {
      time = '${time?.split(' ').first}D';
    }

    bool isSchemeTaged = true;
    for (int i = 0; i < divs.length; i++) {
      if ((divs[i].toString() + divsAddedText[i]) == time) {
        selectedMHP.value = divs[i];
        isSchemeTaged = false;
        break;
      }
    }

    if (isSchemeTaged) {
      amountController.text =
          '${maxInvestController.minInvestmentAmount.toInt()}';
    }
  }

  String get earnedInterestText {
    var text = 'interest_earned_year';
    if (isLiquid) {
      text = isGrowth ? 'interest_earned_year'.tr : 'interest_earned_pm'.tr;
    } else {
      text = isGrowth
          ? "${'interest_earned_for'.tr} ${selectedSchemeModel?.lockinMonth ?? 0} ${selectedSchemeModel?.lockinType ?? "months".tr}"
          : 'interest_earned_pm'.tr;
    }
    return text;
  }

  void onSchemeTypeChanged(int index) {
    selectedSchemeTypeIndex.value = index;
    logEvent.chipSchemeSelection(
        page: "page_${depositFundsScreen.substring(1)}",
        schemeType: isLiquid ? 'liquid'.tr : 'lock-in'.tr);
    filterSchemeChoiceWise();
    if (selectedSchemeTypeIndex.value == index &&
        !tutorialCoachMark!.isShowing) {
      Future.delayed(const Duration(milliseconds: 500), () {
        createTutorialDeposit();
        showTutorial();
      });
    }
  }

  void onPayoutTypeChanged(int index) {
    selectedPayoutTypeIndex.value = index;
    logEvent.chipPayoutSelection(
        page: "page_${depositFundsScreen.substring(1)}",
        schemeType: isLiquid ? 'liquid'.tr : 'lock-in'.tr,
        payoutType: isGrowth ? 'growth'.tr : 'monthly'.tr,
        schemeId: selectedSchemeModel!.schemeId!.toInt());
    filterSchemeChoiceWise();
  }

  void onAmountChipChanged(int index) {
    selectedAmountIndex.value = index;
    passFullAmount(amountList[index].title);
    logEvent.chipInvestFundAmount(
        page: "page_${depositFundsScreen.substring(1)}",
        amountPill: amountList[index].title,
        schemeType: isLiquid ? 'liquid'.tr : 'lock-in'.tr,
        schemeId: selectedSchemeModel!.schemeId!.toInt());
  }

  void passFullAmount(String value) {
    if (amountMap.containsKey(value)) {
      amountController.text = amountMap[value]!;
      fetchInterest();
    }
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

  ///-------AppShow Case Start----------///
  void updateShowCaseStateDeposit({int pos = 100}) {
    var cases = myLocal.showCaseConfig;
    switch (pos) {
      case -1:
        cases.selectScheme = false;
        cases.investmentAmount = false;
        cases.payoutType = false;
        cases.earnedInterest = false;
        cases.annualInterest = false;
        cases.chooseFolioInvest = false;
        cases.compareReturns = false;
        cases.mhpTenure = false;
        break;
      case 0:
        cases.selectScheme = false;
        break;
      case 1:
        cases.investmentAmount = false;
        break;
      case 2:
        cases.payoutType = false;
        break;
      case 3:
        cases.earnedInterest = false;
        break;
      case 4:
        cases.annualInterest = false;
        break;
      case 5:
        cases.chooseFolioInvest = false;
        break;
      case 6:
        cases.compareReturns = false;
        break;
      case 7:
        cases.mhpTenure = false;
        break;
      default:
        break;
    }
    myLocal.appShowCases = cases;
  }

  void createTutorialDeposit() {
    showCaseList = myLocal.showCaseConfig;
    tutorialCoachMark = TutorialCoachMark(
        targets: _createTargetsDeposit().reversed.toList(),
        textSkip: "${"skip".tr}  >",
        onFinish: () {
          logEvent.showCaseEvent(
              page: "page_${depositFundsScreen.substring(1)}",
              buttonLabel: "on_finish_show_case".tr,
              type: "");
          updateShowCaseStateDeposit();
        },
        onSkip: () {
          logEvent.showCaseEvent(
              page: "page_${depositFundsScreen.substring(1)}",
              buttonLabel: "on_skip_show_case".tr,
              type: "");
          updateShowCaseStateDeposit(pos: -1);
        },
        onClickTarget: (target) {
          logEvent.showCaseEvent(
              page: "page_${depositFundsScreen.substring(1)}",
              buttonLabel: "on_click_target_show_case".tr,
              type: "");
          updateShowCaseStateDeposit(pos: showCasePosDeposit);
          showCasePosDeposit++;
        },
        textStyleSkip: myStyle.myFontStyle(
            fontSize: fontSize16,
            fontWeight: FontWeight.bold,
            color: whiteColor),
        showSkipInLastTarget: false);
  }

  List<TargetFocus> _createTargetsDeposit() {
    List<TargetFocus> targets = [];
    var target = myWidget.tutorialTargetFocus(
        keyTarget: lockInTenureKey,
        title: "lock-in_tenure".tr,
        description: "investment_tenure".tr,
        page: "page_${depositFundsScreen.substring(1)}",
        showPrevButton: showCaseList.compareReturns,
        onPrevPress: () => {
              showCasePosDeposit--,
            },
        showNextButton: false,
        onFinishPress: () => {
              updateShowCaseStateDeposit(
                pos: showCasePosDeposit,
              )
            });
    if (showCaseList.mhpTenure && isLockIn && !isSliderChartDisable.value) {
      if (Get.arguments != null &&
          Get.arguments["schemeType"] == 'lock-in'.tr) {
        showCasePosDeposit = 7;
        targets.add(target);
      } else {
        showCasePosDeposit = 7;
        targets.add(target);
      }
    }

    if (showCaseList.compareReturns &&
        amountErrorMsg == null &&
        !isSliderChartDisable.value) {
      showCasePosDeposit = 6;
      // targets.add(myWidget.tutorialTargetFocus(
      // keyTarget: compareReturnsKey,
      // title: "compare_return".tr,
      // description: "returns_with_fd".tr,
      // showPrevButton: showCaseList.chooseFolioInvest,
      // page: "page_${depositFundsScreen.substring(1)}",
      // onPrevPress: () => {
      //       showCasePosDeposit--,
      //     },
      // showNextButton: selectedSchemeTypeIndex.value == 0 ? false : true,
      // onNextPress: () => {
      //       updateShowCaseStateDeposit(pos: showCasePosDeposit),
      //       showCasePosDeposit++,
      //     },
      // onFinishPress: () => {
      //       updateShowCaseStateDeposit(
      //         pos: showCasePosDeposit,
      //       ),
      //     }));
    }
    if (showCaseList.chooseFolioInvest) {
      showCasePosDeposit = 5;
      targets.add(
        myWidget.tutorialTargetFocus(
            keyTarget: chooseFolioKey,
            title: "choose_folio".tr,
            description: "choose_your_folio".tr,
            page: "page_${depositFundsScreen.substring(1)}",
            showPrevButton: (showCaseList.annualInterest &&
                amountErrorMsg == null &&
                !isSliderChartDisable.value),
            onPrevPress: () => {
                  showCasePosDeposit--,
                },
            onNextPress: () => {
                  updateShowCaseStateDeposit(pos: showCasePosDeposit),
                  showCasePosDeposit++,
                }),
      );
    }
    if (showCaseList.annualInterest &&
        amountErrorMsg == null &&
        !isSliderChartDisable.value) {
      showCasePosDeposit = 4;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: annualizedReturnKey,
          title: "annualized_returns".tr,
          description: "annualized_selected_returns".tr,
          page: "page_${depositFundsScreen.substring(1)}",
          showPrevButton: (showCaseList.earnedInterest &&
              amountErrorMsg == null &&
              !isSliderChartDisable.value),
          onPrevPress: () => {
                showCasePosDeposit--,
              },
          onNextPress: () => {
                updateShowCaseStateDeposit(pos: showCasePosDeposit),
                showCasePosDeposit++,
              }));
    }
    if (showCaseList.earnedInterest &&
        amountErrorMsg == null &&
        !isSliderChartDisable.value) {
      showCasePosDeposit = 3;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: interestEarnedKey,
          title: "interest_earned".tr,
          description: "selected_interest_earned".tr,
          page: "page_${depositFundsScreen.substring(1)}",
          showPrevButton:
              (showCaseList.payoutType && !isSliderChartDisable.value),
          onPrevPress: () => {
                showCasePosDeposit--,
              },
          onNextPress: () => {
                updateShowCaseStateDeposit(pos: showCasePosDeposit),
                showCasePosDeposit++,
              }));
    }
    if (showCaseList.payoutType && !isSliderChartDisable.value) {
      showCasePosDeposit = 2;
      targets.add(myWidget.tutorialTargetFocus(
          keyTarget: payOutTypeKey,
          title: "select_payout_type".tr,
          description: "select_payout_investment".tr,
          showPrevButton: (showCaseList.investmentAmount),
          page: "page_${depositFundsScreen.substring(1)}",
          onPrevPress: () => {
                showCasePosDeposit--,
              },
          onNextPress: () => {
                updateShowCaseStateDeposit(pos: showCasePosDeposit),
                showCasePosDeposit++,
              }));
    }
    if (showCaseList.investmentAmount) {
      showCasePosDeposit = 1;
      targets.add(
        myWidget.tutorialTargetFocus(
            keyTarget: amountToInvestKey,
            title: "amount_to_invest".tr,
            description: "enter_investment_amount".tr,
            showPrevButton: (showCaseList.selectScheme),
            page: "page_${depositFundsScreen.substring(1)}",
            onPrevPress: () => {
                  showCasePosDeposit--,
                },
            onNextPress: () => {
                  updateShowCaseStateDeposit(pos: showCasePosDeposit),
                  showCasePosDeposit++,
                }),
      );
    }
    if (showCaseList.selectScheme) {
      showCasePosDeposit = 0;
      targets.add(
        myWidget.tutorialTargetFocus(
            keyTarget: schemeTypeKey,
            title: "select_scheme_type".tr,
            page: "page_${depositFundsScreen.substring(1)}",
            description: "select_type_of_investment".tr,
            showSkipBottom: true,
            onNextPress: () => {
                  updateShowCaseStateDeposit(pos: showCasePosDeposit),
                  showCasePosDeposit++,
                }),
      );
    }

    return targets;
  }

  ///-------AppShow Case End----------///
}
