import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/responses/app_show_cases.dart';
import 'package:liqui_app/global/config/responses/user_data_model.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/modules/investor/splash/models/app_config_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocal {
  static late SharedPreferences sharedPrefs;

  init() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

//device unique id
  set deviceUniqueId(String value) {
    sharedPrefs.setString(deviceUniqueIdKey, value);
  }

  String get deviceUniqueId =>
      sharedPrefs.getString(deviceUniqueIdKey) ?? "static_unique_id";

//app version
  set appVersion(String value) {
    sharedPrefs.setString(appVersionKey, value);
  }

  String get appVersion => sharedPrefs.getString(appVersionKey) ?? "0";

//fcm token id
  set fcmDeviceToken(String value) {
    sharedPrefs.setString(fcmDeviceTokenKey, value);
  }

  String get fcmDeviceToken =>
      sharedPrefs.getString(fcmDeviceTokenKey) ?? "static_fcm_token";

//auth token id
  set authToken(String value) {
    sharedPrefs.setString(authTokenKey, value);
  }

  String get authToken => sharedPrefs.getString(authTokenKey) ?? "";

  set accessToken(String value) {
    sharedPrefs.setString(accessTokenKey, value);
  }

  String get accessToken => sharedPrefs.getString(accessTokenKey) ?? "";

  //enable lock
  set enableAppLock(bool value) {
    sharedPrefs.setBool(enableAppLockKey, value);
  }

  bool get enableAppLock => sharedPrefs.getBool(enableAppLockKey) ?? false;

// user logged in
  set isLoggedIn(bool value) {
    sharedPrefs.setBool(isLoggedInKey, value);
  }

  bool get isLoggedIn => sharedPrefs.getBool(isLoggedInKey) ?? false;

//investor id
  String get oldInvestorId => sharedPrefs.getString(investorIdKey) ?? "";

  String get investorId => userDataConfig.userId;

// user id
  set userId(String value) {
    sharedPrefs.setString(userIdKey, value);
  }

  String get userId => ifaId.validString
      ? sharedPrefs.getString(userIdKey) ?? investorId
      : investorId;

//user name
//   set userName(String value) {
//     sharedPrefs.setString(userNameKey, value);
//   }

  String get userName => sharedPrefs.getString(userNameKey) ?? "";

//user number
//   set userNumber(String value) {
//     sharedPrefs.setString(userNumberKey, value);
//   }

  String get userNumber => sharedPrefs.getString(userNumberKey) ?? "";

//user email
//   set userEmail(String value) {
//     sharedPrefs.setString(userEmailKey, value);
//   }

  String get userEmail => sharedPrefs.getString(userEmailKey) ?? "";

//user pan
//   set userPAN(String value) {
//     sharedPrefs.setString(userPAnKey, value);
//   }

  String get userPAN => sharedPrefs.getString(userPAnKey) ?? "";

  //local lang
  set localLang(String value) {
    sharedPrefs.setString(localLangKey, value);
  }

  String get localLang => sharedPrefs.getString(localLangKey) ?? "en";

  //ifa id
  set ifaId(String value) {
    sharedPrefs.setString(ifaIdKey, value);
  }

  String get ifaId => sharedPrefs.getString(ifaIdKey) ?? "";

  //fetch folios
  bool get fetchFolios => ifaId.isEmpty;

  //ifa name
  set ifaName(String value) {
    sharedPrefs.setString(ifaNameKey, value);
  }

  String get ifaName => sharedPrefs.getString(ifaNameKey) ?? "";

  //first-time user
  set firstTimeUser(bool value) {
    sharedPrefs.setBool(firstTimeUserKey, value);
  }

  bool get firstTimeUser => sharedPrefs.getBool(firstTimeUserKey) ?? true;

  //theme
  set themeValue(String value) {
    sharedPrefs.setString(themeValueKey, value);
  }

  String get themeValue =>
      sharedPrefs.getString(themeValueKey) ?? "device_settings";

  //return app selected theme mode
  ThemeMode get themeMode => myLocal.themeValue == "dark_mode"
      ? ThemeMode.dark
      : myLocal.themeValue == "light_mode"
          ? ThemeMode.light
          : ThemeMode.system;

  //referral code
  set referralCode(String value) {
    sharedPrefs.setString(referralCodeKey, value);
  }

  String get referralCode => sharedPrefs.getString(referralCodeKey) ?? "";

  // IFA code
  set setIfaCode(String value) {
    sharedPrefs.setString(ifaRefralCodeKey, value);
  }

  String? get getIfaCode => sharedPrefs.getString(ifaRefralCodeKey);

  //graphQL
  set appConfigDetails(String value) {
    sharedPrefs.setString(graphQL, value);
  }

  String get appConfigDetails => sharedPrefs.getString(graphQL) ?? "{}";

  MobileAppConfig get appConfig =>
      MobileAppConfig.fromJson(jsonDecode(appConfigDetails));

  //utm feature
  set utmFeature(String value) {
    sharedPrefs.setString(utmFeatureKey, value);
  }

  String get utmFeature => sharedPrefs.getString(utmFeatureKey) ?? "";

  //utm channel
  set utmChannel(String value) {
    sharedPrefs.setString(utmChannelKey, value);
  }

  String get utmChannel => sharedPrefs.getString(utmChannelKey) ?? "";

  //utm campaign
  set utmCampaign(String value) {
    sharedPrefs.setString(utmCampaignKey, value);
  }

  String get utmCampaign => sharedPrefs.getString(utmCampaignKey) ?? "";

  //show case
  set appShowCases(Object value) {
    sharedPrefs.setString(appShowCaseKey, jsonEncode(value));
  }

  String get appShowCases =>
      sharedPrefs.getString(appShowCaseKey) ?? jsonEncode(AppShowCases());

  AppShowCases get showCaseConfig =>
      AppShowCases.fromJson(jsonDecode(appShowCases));

  //User Data
  set userData(Object value) {
    sharedPrefs.setString(userDataKey, jsonEncode(value));
  }

  String get userData =>
      sharedPrefs.getString(userDataKey) ?? jsonEncode(UserData());

  UserData get userDataConfig => UserData.fromJson(jsonDecode(userData));

  //remove values
  clearData() async {
    sharedPrefs.remove(isLoggedInKey);
    sharedPrefs.remove(authTokenKey);
    sharedPrefs.remove(accessTokenKey);
    sharedPrefs.remove(investorIdKey);
    sharedPrefs.remove(userIdKey);
    sharedPrefs.remove(userNameKey);
    sharedPrefs.remove(userNumberKey);
    sharedPrefs.remove(userEmailKey);
    sharedPrefs.remove(userPAnKey);
    sharedPrefs.remove(ifaIdKey);
    sharedPrefs.remove(ifaNameKey);
    sharedPrefs.remove(userDataKey);
    // sharedPrefs.remove(appShowCaseKey);
    clearDeepLinkData();
    //logout from all analytics
    logEvent.logout();
  }

  clearAppLock() {
    sharedPrefs.remove(enableAppLockKey);
  }

  clearDeepLinkData() {
    sharedPrefs.remove(referralCodeKey);
    sharedPrefs.remove(utmFeatureKey);
    sharedPrefs.remove(utmChannelKey);
    sharedPrefs.remove(utmCampaignKey);
    sharedPrefs.remove(ifaRefralCodeKey);
    //sharedPrefs.remove(graphQL);
    // sharedPrefs.remove(firstTimeUserKey);
  }

  //remove values
  logout() async {
    sharedPrefs.remove(isLoggedInKey);
  }
}

//reference object
final myLocal = MyLocal();

//key ids
const String deviceUniqueIdKey = "device_unique_id";
const String fcmDeviceTokenKey = "fcm_token";
const String appVersionKey = "app_version";
const String authTokenKey = "auth_token";
const String accessTokenKey = "access_token";
const String isLoggedInKey = "is_logged_in";
const String userIdKey = "user_id";
const String investorIdKey = "investor_id";
const String userNameKey = "user_name";
const String userNumberKey = "user_number";
const String userEmailKey = "user_email";
const String userPAnKey = "user_pan";
const String localLangKey = "local_lang";
const String ifaIdKey = "ifa_id";
const String ifaNameKey = "ifa_name";
const String firstTimeUserKey = "first_time_user";
const String referralCodeKey = "referral_code";
const String ifaRefralCodeKey = "ifa_referral";
const String graphQL = "graph_ql";
const String enableAppLockKey = "enable_app_lock";
const String utmFeatureKey = "utm_feature";
const String utmChannelKey = "utm_channel";
const String utmCampaignKey = "utm_campaign";
const String themeValueKey = "theme_value";
const String appShowCaseKey = "app_show_case";
const String userDataKey = "user_data";
