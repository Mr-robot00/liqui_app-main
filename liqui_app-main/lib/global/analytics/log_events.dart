import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:liqui_app/global/analytics/branch_setup.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/widgets/my_widget.dart';
import 'package:moengage_flutter/model/app_status.dart';
import 'package:moengage_flutter/properties.dart';

import '../utils/helpers/my_helper.dart';
import '../utils/storage/my_local.dart';
import 'mix_panel_setup.dart';
import 'moengage_setup.dart';

class EventName {
  static const String logIn = "user_logged_in";
  static const String logOut = "user_logged_out";
  static const String investFundStarted = "invest_fund_started";
  static const String investFund = "invest_fund";
  static const String withdrawFundStarted = "withdraw_fund_started";
  static const String withdrawFund = "withdraw_fund";
  static const String signAgreement = "sign_agreement";
  static const String addBank = "add_bank";
  static const String deleteBank = "delete_bank";
  static const String paymentStatus = "payment_status";
  static const String createInvestor = "create_investor";
  static const String userAttributes = "user_attributes";
  static const String verifyKycButton = "button_verify_kyc";
  static const String verifyKycConfirmation = "verify_kyc_confirmation";
  static const String buttonAddMoney = "button_add_money";
  static const String buttonWithdrawMoney = "button_withdraw_money";
  static const String buttonStartSip = "button_start_sip";
  static const String chipSchemeSelection = "chip_scheme_selection";
  static const String inputInvestFundAmount = "input_invest_fund_amount";
  static const String chipInvestFundAmount = "chip_invest_fund_amount";
  static const String chipPayoutSelection = "chip_payout_type_selection";
  static const String buttonCompareReturn = "button_compare_returns";
  static const String buttonInvestNow = "button_invest_now";
  static const String tabBottomNavigation = "tab_bottom_navigation";
  static const String tabTransaction = "tab_transactions";
  static const String tabPortfolio = "tab_portfolio";
  static const String buttonMyProfile = "button_my_profile";
  static const String buttonDarkMode = "button_dark_mode";
  static const String buttonReferFriend = "button_refer_a_friend";
  static const String buttonContactUs = "button_contact_us";
  static const String buttonFaqs = "button_faqs";
  static const String buttonBasicInformation = "button_basic_information";
  static const String buttonBankDetails = "button_my_bank_details";
  static const String buttonMyAddress = "button_my_address";
  static const String buttonAddBankAccount = "button_add_bank_account";
  static const String buttonSocialMedia = "button_social_media";
  static const String inputWithdrawFundAmount = "input_withdraw_amount";
  static const String dropDownWithdrawToBank = "drop_down_withdraw_to_bank";
  static const String mediaCarousel = "media_item_carousal";
  static const String btnResendOtp = "button_resend_otp";
  static const String btnVerifyOtp = "button_verify_otp";
  static const String ftue = "ftue";
  static const String dropDownChooseFolio = "drop_down_choose_folio";
  static const String retryPayment = "retry_payment";
  static const String retryPaymentCancelled = "retry_payment_cancelled";
  static const String buttonSelectFolio = "button_select_folio";
  static const String buttonCreateLlAccount = "button_create_ll_account";
  static const String portfolioTransaction = "portfolio_transaction";
  static const String portfolioSelectScheme = "portfolio_select_scheme";
}

class EventKey {
  static const String investorId = "investor_id";
  static const String mobileNumber = "mobile_number";
  static const String userName = "user_name";
  static const String emailId = "email_id";
  static const String deviceUniqueId = "device_unique_id";
  static const String appVersion = "app_version";
  static const String appPlatform = "app_platform";
  static const String environment = "environment";
  static const String schemeId = "scheme_id";
  static const String amount = "amount";
  static const String gatewayType = "gateway_type";
  static const String bankId = "bank_id";
  static const String ifscCode = "ifsc_code";
  static const String bankName = "bank_name";
  static const String transactionId = "transaction_id";
  static const String transactionStatus = "transaction_status";
  static const String linkToken = "link_token";
  static const String ifaName = "ifa_name";
  static const String alias = "alias";
  static const String utmFeature = "utm_feature";
  static const String utmChannel = "utm_channel";
  static const String utmCampaign = "utm_campaign";
  static const String gender = "gender";
  static const String age = "age";
  static const String page = "page";
  static const String source = "source";
  static const String btnClicked = "button_clicked";
  static const String schemeType = "scheme_type";
  static const String amountPill = "amount_pill";
  static const String payoutType = "payout_type";
  static const String pageLabel = "page_label";
  static const String tabLabel = "tab_label";
  static const String type = "type";
  static const String carouselLabel = "carousal_label";
  static const String buttonLabel = "buttonLabel";
  static const String buildNumber = "buildNumber";
  static const String ifaId = "ifaid";
}

class LogEvents {
  var nMixPanel = mixPanel.mixPanel;
  var moE = moEngage.moEngagePlugin;
  MoEProperties? moEProperties;

  setCurrentScreen(
      {required String screenName, required String screenClass}) async {
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClass,
    );
    logMixpanelEvent("page_$screenName", {});
    MoEProperties properties = await moEngageCommonProperties();
    moE.trackEvent("page_$screenName", properties);
  }

  Future<void> setUserIdentify({required String investorId}) async {
    //mixpanel
    nMixPanel?.identify("inv_$investorId");
    //firebase
    await FirebaseAnalytics.instance.setUserId(id: investorId);
    //moengage
    moE.setUniqueId("inv_$investorId");
    //branch
    bool isUserIdentified = await FlutterBranchSdk.isUserIdentified();
    if (!isUserIdentified) FlutterBranchSdk.setIdentity("inv_$investorId");
    moEProperties = null;
  }

  Future<void> setUserAttributes(
      {required String investorId,
      required String userName,
      required String mobileNumber,
      required String emailId}) async {
    //mixpanel
    nMixPanel?.getPeople().set("\$name", userName);
    nMixPanel?.getPeople().set("\$email", emailId);
    nMixPanel?.getPeople().set("\$mobile_number", mobileNumber);
    //moengage
    moE.setUserName(userName);
    moE.setEmail(emailId);
    moE.setPhoneNumber(mobileNumber);
    //set default properties
    setDefaultProperties(
        investorId: investorId,
        userName: userName,
        mobileNumber: mobileNumber,
        emailId: emailId);
    //branch
    BranchEvent eventUser = BranchEvent.customEvent(EventName.userAttributes);
    eventUser.addCustomData(EventKey.userName, userName);
    eventUser.addCustomData(EventKey.emailId, emailId);
    eventUser.addCustomData(EventKey.mobileNumber, mobileNumber);
    eventUser.addCustomData(EventKey.alias, myLocal.referralCode);
    eventUser.addCustomData(EventKey.utmFeature, myLocal.utmFeature);
    eventUser.addCustomData(EventKey.utmChannel, myLocal.utmChannel);
    eventUser.addCustomData(EventKey.utmCampaign, myLocal.utmCampaign);
    eventUser.addCustomData(EventKey.deviceUniqueId, myLocal.deviceUniqueId);
    eventUser.addCustomData(EventKey.appVersion, await myHelper.appVersion);
    eventUser.addCustomData(EventKey.appPlatform, myHelper.osType);
    eventUser.addCustomData(EventKey.environment, myHelper.appEnvironment);
    eventUser.addCustomData(EventKey.gender, _userGender);
    eventUser.addCustomData(EventKey.age, _userAge);
    eventUser.addCustomData(
        EventKey.buildNumber, await myHelper.appBuildNumber);
    FlutterBranchSdk.trackContent(
        buo: [branchIO.branch], branchEvent: eventUser);
  }

  setDefaultProperties(
      {required String investorId,
      required String userName,
      required String mobileNumber,
      required String emailId}) async {
    ///firebase
    await FirebaseAnalytics.instance.setDefaultEventParameters({
      EventKey.investorId: int.parse(investorId.validString ? investorId : '0'),
      EventKey.userName: userName,
      EventKey.emailId: emailId,
      EventKey.mobileNumber:
          int.parse(mobileNumber.validString ? mobileNumber : "0"),
      EventKey.deviceUniqueId: myLocal.deviceUniqueId,
      EventKey.appVersion: await myHelper.appVersion,
      EventKey.appPlatform: myHelper.osType,
      EventKey.environment: myHelper.appEnvironment,
      EventKey.gender: _userGender,
      EventKey.age: _userAge == "NA" ? "NA" : int.parse(_userAge),
      EventKey.buildNumber: num.parse(await myHelper.appBuildNumber),
    });

    ///Mixpanel
    nMixPanel?.registerSuperProperties({
      EventKey.investorId: int.parse(investorId.validString ? investorId : '0'),
      EventKey.userName: userName,
      EventKey.mobileNumber:
          int.parse(mobileNumber.validString ? mobileNumber : "0"),
      EventKey.emailId: emailId,
      EventKey.deviceUniqueId: myLocal.deviceUniqueId,
      EventKey.appVersion: await myHelper.appVersion,
      EventKey.appPlatform: myHelper.osType,
      EventKey.environment: myHelper.appEnvironment,
      EventKey.gender: _userGender,
      EventKey.age: _userAge == "NA" ? "NA" : int.parse(_userAge),
      EventKey.buildNumber: num.parse(await myHelper.appBuildNumber),
    });
  }

  Future<MoEProperties> moEngageCommonProperties() async {
    return moEProperties ??
        (moEProperties = MoEProperties()
            .addAttribute(
                EventKey.investorId,
                int.parse(
                    myLocal.investorId.validString ? myLocal.investorId : '0'))
            .addAttribute(EventKey.userName, myLocal.userDataConfig.userName)
            .addAttribute(EventKey.emailId, myLocal.userDataConfig.userEmail)
            .addAttribute(
                EventKey.mobileNumber,
                int.parse(myLocal.userDataConfig.userNumber.validString
                    ? myLocal.userDataConfig.userNumber
                    : "0"))
            .addAttribute(EventKey.deviceUniqueId, myLocal.deviceUniqueId)
            .addAttribute(EventKey.appVersion, await myHelper.appVersion)
            .addAttribute(EventKey.appPlatform, myHelper.osType)
            .addAttribute(EventKey.environment, myHelper.appEnvironment)
            .addAttribute(EventKey.gender, _userGender)
            .addAttribute(
                EventKey.age, _userAge == "NA" ? "NA" : int.parse(_userAge))
            .addAttribute(
              EventKey.buildNumber,
              num.parse(await myHelper.appBuildNumber),
            ));
  }

  String get _userGender {
    return myLocal.userDataConfig.userGender.isEmpty
        ? "NA"
        : myLocal.userDataConfig.userGender;
  }

  String get _userAge {
    return myLocal.userDataConfig.userDob.isEmpty
        ? "NA"
        : myWidget.calculateAge(myLocal.userDataConfig.userDob);
  }

  installEvent() async {
    ///MoE
    moE.setAppStatus(MoEAppStatus.install);
  }

  Future<void> createInvestor({required String source}) async {
    ///Firebase
    logFirebaseEvent(EventName.createInvestor, {
      EventKey.source: source,
      EventKey.mobileNumber: int.parse(
          myLocal.userDataConfig.userNumber.validString
              ? myLocal.userDataConfig.userNumber
              : "0"),
      EventKey.page: "page_${createInvestorScreen.substring(1)}"
    });

    ///Mixpanel
    await logMixpanelEvent(EventName.createInvestor, {
      EventKey.source: source,
      EventKey.mobileNumber: int.parse(
          myLocal.userDataConfig.userNumber.validString
              ? myLocal.userDataConfig.userNumber
              : "0"),
      EventKey.page: "page_${createInvestorScreen.substring(1)}"
    });

    ///MoE
    moE.trackEvent(EventName.createInvestor, await moEngageCommonProperties());
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.source, source).addAttribute(
        EventKey.page, "page_${createInvestorScreen.substring(1)}");
    moE.trackEvent(EventName.createInvestor, properties);

    ///branch
  }

  signAgreement({String? investorId}) async {
    ///Firebase
    logFirebaseEvent(EventName.signAgreement, {
      // EventKey.investorId: investorId ?? myLocal.userId,
      EventKey.mobileNumber: int.parse(
          myLocal.userDataConfig.userNumber.validString
              ? myLocal.userDataConfig.userNumber
              : "0"),
      EventKey.page: "page_${signInAgreementScreen.substring(1)}"
    });

    ///Mixpanel
    logMixpanelEvent(EventName.signAgreement, {
      EventKey.mobileNumber: int.parse(
          myLocal.userDataConfig.userNumber.validString
              ? myLocal.userDataConfig.userNumber
              : "0"),
      EventKey.page: "page_${signInAgreementScreen.substring(1)}"
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(
            EventKey.mobileNumber,
            int.parse(myLocal.userDataConfig.userNumber.validString
                ? myLocal.userDataConfig.userNumber
                : "0"))
        .addAttribute(
            EventKey.page, "page_${signInAgreementScreen.substring(1)}");
    moE.trackEvent(EventName.signAgreement, properties);

    ///branch
  }

  Future<void> login(
      {required String mobileNumber,
      required String investorId,
      required String page,
      String? emailId}) async {
    ///Firebase
    logFirebaseEvent(
      EventName.logIn,
      {
        EventKey.investorId:
            int.parse(investorId.validString ? investorId : "0"),
        EventKey.mobileNumber:
            int.parse(mobileNumber.validString ? mobileNumber : "0"),
        EventKey.emailId: emailId ?? "",
        EventKey.page: page,
      },
    );

    ///mixpanel
    await logMixpanelEvent(EventName.logIn, {
      EventKey.investorId: int.parse(investorId.validString ? investorId : "0"),
      EventKey.mobileNumber:
          int.parse(mobileNumber.validString ? mobileNumber : "0"),
      EventKey.emailId: emailId ?? "",
      EventKey.page: page,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.logIn, properties);

    ///branch
  }

  investFundStarted(
      {String? investorId,
      required int schemeId,
      required num amount,
      required String gatewayType,
      required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.investFundStarted, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.investFundStarted, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.gatewayType, gatewayType)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.investFundStarted, properties);

    ///branch
  }

  paymentStatus(
      {String? investorId,
      required String? transactionId,
      required String? transactionStatus,
      required String page,
      required num amount}) async {
    ///Firebase
    logFirebaseEvent(EventName.paymentStatus, {
      EventKey.amount: amount,
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.transactionId: transactionId,
      EventKey.transactionStatus: transactionStatus,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.paymentStatus, {
      EventKey.amount: amount,
      EventKey.transactionId: transactionId,
      EventKey.transactionStatus: transactionStatus,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.transactionId, transactionId)
        .addAttribute(EventKey.transactionStatus, transactionStatus)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.paymentStatus, properties);

    ///branch
  }

  retryPayment(
      {int? schemeId,
      required num amount,
      required String? gatewayType,
      required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.retryPayment, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.retryPayment, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.gatewayType, gatewayType)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.retryPayment, properties);

    ///branch
  }

  retryPaymentCancelled(
      {int? schemeId,
      required num amount,
      required String? gatewayType,
      required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.retryPaymentCancelled, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.retryPaymentCancelled, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.gatewayType, gatewayType)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.retryPaymentCancelled, properties);

    ///branch
  }

  investFund(
      {String? investorId,
      required String? transactionId,
      required String? transactionStatus,
      required String page,
      required num amount}) async {
    ///Firebase
    logFirebaseEvent(EventName.investFund, {
      EventKey.amount: amount,
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.transactionId: transactionId,
      EventKey.transactionStatus: transactionStatus,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.investFund, {
      EventKey.amount: amount,
      EventKey.transactionId: transactionId,
      EventKey.transactionStatus: transactionStatus,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.transactionId, transactionId)
        .addAttribute(EventKey.transactionStatus, transactionStatus)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.investFund, properties);

    ///branch
  }

  withdrawFundStarted(
      {String? investorId,
      required num amount,
      required String page,
      required num? bankId}) async {
    ///Firebase
    logFirebaseEvent(EventName.withdrawFundStarted, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.amount: amount,
      EventKey.bankId: bankId,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.withdrawFundStarted, {
      EventKey.amount: amount,
      EventKey.bankId: bankId,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.bankId, bankId)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.withdrawFundStarted, properties);

    ///branch
  }

  withdrawFund(
      {String? investorId,
      required String? linkToken,
      required String page,
      required num amount}) async {
    ///Firebase
    logFirebaseEvent(EventName.withdrawFund, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.linkToken: linkToken,
      EventKey.amount: amount,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.withdrawFund, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.linkToken: linkToken,
      EventKey.amount: amount,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.linkToken, linkToken)
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.withdrawFund, properties);

    ///branch
  }

  addBank(
      {String? investorId,
      required String ifscCode,
      required String page,
      required String source,
      required String bankName}) async {
    ///Firebase
    logFirebaseEvent(EventName.addBank, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.ifscCode: ifscCode,
      EventKey.bankName: bankName,
      EventKey.page: page,
      EventKey.source: source,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.addBank, {
      EventKey.ifscCode: ifscCode,
      EventKey.bankName: bankName,
      EventKey.page: page,
      EventKey.source: source,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.ifscCode, ifscCode)
        .addAttribute(EventKey.bankName, bankName)
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source);
    moE.trackEvent(EventName.addBank, properties);

    ///branch
  }

  deleteBank({
    String? investorId,
    required String bankId,
    required String page,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.deleteBank, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.bankId: bankId,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.deleteBank, {
      EventKey.investorId: int.parse(investorId ?? myLocal.userId),
      EventKey.bankId: bankId,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.bankId, bankId)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.deleteBank, properties);

    ///branch
  }

  logFirebaseEvent(String eventName, Map<String, Object?>? parameters) async {
    await FirebaseAnalytics.instance
        .logEvent(name: eventName, parameters: parameters);
  }

  logMixpanelEvent(String eventName, Map<String, dynamic>? parameters) {
    nMixPanel?.track(eventName, properties: parameters);
  }

  logout() async {
    ///Firebase
    logFirebaseEvent(
      EventName.logOut,
      {
        EventKey.investorId: int.parse(
            myLocal.investorId.validString ? myLocal.investorId : '0'),
        EventKey.mobileNumber: int.parse(
            myLocal.userDataConfig.userNumber.validString
                ? myLocal.userDataConfig.userNumber
                : "0"),
        EventKey.page: "page_${myProfileScreen.substring(1)}"
      },
    );
    //for cleaning firebase analytics data
    await FirebaseAnalytics.instance.resetAnalyticsData();

    ///Mixpanel
    logMixpanelEvent(EventName.logOut, {
      EventKey.investorId:
          int.parse(myLocal.investorId.validString ? myLocal.investorId : '0'),
      EventKey.mobileNumber: int.parse(
          myLocal.userDataConfig.userNumber.validString
              ? myLocal.userDataConfig.userNumber
              : "0"),
      EventKey.page: "page_${myProfileScreen.substring(1)}"
    });
    //for cleaning mixpanel data
    nMixPanel?.reset();

    ///MoE
    moEngage.moEngagePlugin.logout();

    ///branch
    FlutterBranchSdk.logout();

    moEProperties = null;
  }

  verifyKycButton({
    required String page,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.verifyKycButton, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.verifyKycButton, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.verifyKycButton, properties);
  }

  verifyKycConfirmation({
    required String page,
    required String btnClicked,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.verifyKycConfirmation,
        {EventKey.page: page, EventKey.btnClicked: btnClicked});

    ///Mixpanel
    logMixpanelEvent(EventName.verifyKycConfirmation,
        {EventKey.page: page, EventKey.btnClicked: btnClicked});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.btnClicked, btnClicked);
    moE.trackEvent(EventName.verifyKycConfirmation, properties);
  }

  buttonAddMoney({
    required String page,
    required String source,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonAddMoney,
        {EventKey.page: page, EventKey.source: source});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonAddMoney,
        {EventKey.page: page, EventKey.source: source});

    ///MoE
    // MoEProperties properties = await moEngageCommonProperties();
    moEProperties
        ?.addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source);
    moE.trackEvent(EventName.buttonAddMoney, moEProperties);
  }

  buttonWithdrawMoney({
    required String page,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonWithdrawMoney, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonWithdrawMoney, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonWithdrawMoney, properties);
  }

  buttonStartSip({
    required String page,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonStartSip, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonStartSip, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonStartSip, properties);
  }

  chipSchemeSelection({
    required String page,
    required String schemeType,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.chipSchemeSelection,
        {EventKey.page: page, EventKey.schemeType: schemeType});

    ///Mixpanel
    logMixpanelEvent(EventName.chipSchemeSelection,
        {EventKey.page: page, EventKey.schemeType: schemeType});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.schemeType, schemeType);
    moE.trackEvent(EventName.chipSchemeSelection, properties);
  }

  inputInvestFundAmount({
    required String page,
    required num amount,
    required String schemeType,
    required int schemeId,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.inputInvestFundAmount, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.amount: amount,
      EventKey.schemeId: schemeId,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.inputInvestFundAmount, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.amount: amount,
      EventKey.schemeId: schemeId,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.schemeType, schemeType)
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amount, amount);
    moE.trackEvent(EventName.inputInvestFundAmount, properties);
  }

  chipInvestFundAmount({
    required String page,
    required String amountPill,
    required String schemeType,
    required int schemeId,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.chipInvestFundAmount, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.amountPill: amountPill,
      EventKey.schemeId: schemeId,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.chipInvestFundAmount, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.amountPill: amountPill,
      EventKey.schemeId: schemeId,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.schemeType, schemeType)
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amountPill, amountPill);
    moE.trackEvent(EventName.chipInvestFundAmount, properties);
  }

  chipPayoutSelection({
    required String page,
    required String payoutType,
    required String schemeType,
    required int schemeId,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.chipPayoutSelection, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.payoutType: payoutType,
      EventKey.schemeId: schemeId,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.chipPayoutSelection, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.payoutType: payoutType,
      EventKey.schemeId: schemeId,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.schemeType, schemeType)
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.payoutType, payoutType);
    moE.trackEvent(EventName.chipPayoutSelection, properties);
  }

  buttonCompareReturns({
    required String page,
    required String schemeType,
    required int schemeId,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonCompareReturn, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.schemeId: schemeId,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.buttonCompareReturn, {
      EventKey.page: page,
      EventKey.schemeType: schemeType,
      EventKey.schemeId: schemeId,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.schemeType, schemeType)
        .addAttribute(EventKey.schemeId, schemeId);
    moE.trackEvent(EventName.buttonCompareReturn, properties);
  }

  buttonInvestNow(
      {required int schemeId,
      required num amount,
      required String gatewayType,
      required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonInvestNow, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.buttonInvestNow, {
      EventKey.schemeId: schemeId,
      EventKey.amount: amount,
      EventKey.gatewayType: gatewayType,
      EventKey.ifaName: myLocal.ifaName,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.amount, amount)
        .addAttribute(EventKey.gatewayType, gatewayType)
        .addAttribute(EventKey.ifaName, myLocal.ifaName)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonInvestNow, properties);

    ///branch
  }

  tabBottomNavigation({required String pageLabel, required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.tabBottomNavigation,
        {EventKey.page: page, EventKey.pageLabel: pageLabel});

    ///Mixpanel
    logMixpanelEvent(EventName.tabBottomNavigation,
        {EventKey.page: page, EventKey.pageLabel: pageLabel});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.pageLabel, pageLabel);
    moE.trackEvent(EventName.tabBottomNavigation, properties);

    ///branch
  }

  tabTransaction({required String tabLabel, required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.tabTransaction,
        {EventKey.page: page, EventKey.tabLabel: tabLabel});

    ///Mixpanel
    logMixpanelEvent(EventName.tabTransaction,
        {EventKey.page: page, EventKey.tabLabel: tabLabel});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.tabLabel, tabLabel);
    moE.trackEvent(EventName.tabTransaction, properties);

    ///branch
  }

  tabPortfolio({required String tabLabel, required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.tabPortfolio,
        {EventKey.page: page, EventKey.tabLabel: tabLabel});

    ///Mixpanel
    logMixpanelEvent(EventName.tabPortfolio,
        {EventKey.page: page, EventKey.tabLabel: tabLabel});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.tabLabel, tabLabel);
    moE.trackEvent(EventName.tabPortfolio, properties);

    ///branch
  }

  buttonMyProfile({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonMyProfile, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonMyProfile, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonMyProfile, properties);
  }

  buttonDarkMode({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonDarkMode, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonDarkMode, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonDarkMode, properties);
  }

  buttonReferFriend({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonReferFriend, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonReferFriend, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonReferFriend, properties);
  }

  buttonContactUs({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonContactUs, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonContactUs, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonContactUs, properties);
  }

  buttonFaqs({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonFaqs, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonFaqs, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonFaqs, properties);
  }

  buttonBasicInformation({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonBasicInformation, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonBasicInformation, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonBasicInformation, properties);
  }

  buttonMyBankDetails({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonBankDetails, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonBankDetails, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonBankDetails, properties);
  }

  buttonMyAddress({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonMyAddress, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonMyAddress, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonMyAddress, properties);
  }

  buttonAddBankAccount({required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonAddBankAccount, {EventKey.page: page});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonAddBankAccount, {EventKey.page: page});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties.addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.buttonAddBankAccount, properties);
  }

  buttonSocialMedia({required String page, required String type}) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonSocialMedia,
        {EventKey.page: page, EventKey.type: type});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonSocialMedia,
        {EventKey.page: page, EventKey.type: type});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.type, type);
    moE.trackEvent(EventName.buttonSocialMedia, properties);
  }

  inputWithdrawFundAmount({required String page, required num amount}) async {
    ///Firebase
    logFirebaseEvent(EventName.inputWithdrawFundAmount, {
      EventKey.page: page,
      EventKey.amount: amount,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.inputWithdrawFundAmount, {
      EventKey.page: page,
      EventKey.amount: amount,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.amount, amount);
    moE.trackEvent(EventName.inputWithdrawFundAmount, properties);
  }

  dropDownWithdrawToBank({required String page, required String bank}) async {
    ///Firebase
    logFirebaseEvent(EventName.dropDownWithdrawToBank, {
      EventKey.page: page,
      EventKey.bankName: bank,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.dropDownWithdrawToBank, {
      EventKey.page: page,
      EventKey.bankName: bank,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.bankName, bank);
    moE.trackEvent(EventName.dropDownWithdrawToBank, properties);
  }

  mediaCarouselItem(
      {required String page, required String carouselLabel}) async {
    ///Firebase
    logFirebaseEvent(EventName.mediaCarousel, {
      EventKey.page: page,
      EventKey.carouselLabel: carouselLabel,
    });

    ///Mixpanel
    logMixpanelEvent(EventName.mediaCarousel, {
      EventKey.page: page,
      EventKey.carouselLabel: carouselLabel,
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.carouselLabel, carouselLabel);
    moE.trackEvent(EventName.mediaCarousel, properties);
  }

  btnResendOtp({
    required String page,
    required String source,
    required String type,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.btnResendOtp,
        {EventKey.page: page, EventKey.source: source, EventKey.type: type});

    ///Mixpanel
    logMixpanelEvent(EventName.btnResendOtp,
        {EventKey.page: page, EventKey.source: source, EventKey.type: type});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source)
        .addAttribute(EventKey.type, type);
    moE.trackEvent(EventName.btnResendOtp, properties);
  }

  btnVerifyOtp({
    required String page,
    required String source,
    required String type,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.btnVerifyOtp,
        {EventKey.page: page, EventKey.source: source, EventKey.type: type});

    ///Mixpanel
    logMixpanelEvent(EventName.btnVerifyOtp,
        {EventKey.page: page, EventKey.source: source, EventKey.type: type});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source)
        .addAttribute(EventKey.type, type);
    moE.trackEvent(EventName.btnVerifyOtp, properties);
  }

  showCaseEvent({
    required String page,
    required String buttonLabel,
    required String type,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.ftue, {
      EventKey.page: page,
      EventKey.buttonLabel: buttonLabel,
      EventKey.type: type
    });

    ///Mixpanel
    logMixpanelEvent(EventName.ftue, {
      EventKey.page: page,
      EventKey.buttonLabel: buttonLabel,
      EventKey.type: type
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.buttonLabel, buttonLabel)
        .addAttribute(EventKey.type, type);
    moE.trackEvent(EventName.ftue, properties);
  }

  buttonSelectFolio({
    required num ifaId,
    required String ifaName,
    required String page,
    required String source,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonSelectFolio, {
      EventKey.ifaId: ifaId,
      EventKey.page: page,
      EventKey.source: source,
      EventKey.ifaName: ifaName
    });

    ///Mixpanel
    logMixpanelEvent(EventName.buttonSelectFolio, {
      EventKey.ifaId: ifaId,
      EventKey.page: page,
      EventKey.source: source,
      EventKey.ifaName: ifaName
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.ifaId, ifaId)
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source)
        .addAttribute(EventKey.ifaName, ifaName);
    moE.trackEvent(EventName.buttonSelectFolio, properties);
  }

  buttonCreateLlAccount({
    required String page,
    required String source,
  }) async {
    ///Firebase
    logFirebaseEvent(EventName.buttonCreateLlAccount,
        {EventKey.page: page, EventKey.source: source});

    ///Mixpanel
    logMixpanelEvent(EventName.buttonCreateLlAccount,
        {EventKey.page: page, EventKey.source: source});

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.page, page)
        .addAttribute(EventKey.source, source);
    moE.trackEvent(EventName.buttonCreateLlAccount, properties);
  }

  portfolioSelectScheme(
      {required String? schemeId,
      required String? schemeType,
      required String page}) async {
    ///Firebase
    logFirebaseEvent(EventName.portfolioSelectScheme, {
      EventKey.schemeId: schemeId,
      EventKey.schemeType: schemeType,
      EventKey.page: page
    });

    ///Mixpanel
    logMixpanelEvent(EventName.portfolioSelectScheme, {
      EventKey.schemeId: schemeId,
      EventKey.schemeType: schemeType,
      EventKey.page: page
    });

    ///MoE
    MoEProperties properties = await moEngageCommonProperties();
    properties
        .addAttribute(EventKey.schemeId, schemeId)
        .addAttribute(EventKey.schemeType, schemeType)
        .addAttribute(EventKey.page, page);
    moE.trackEvent(EventName.portfolioSelectScheme, properties);

    ///branch
  }
}

final logEvent = LogEvents();
