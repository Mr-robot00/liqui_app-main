import 'dart:convert';

import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';

class BranchSetup {
  late BranchUniversalObject branch;

  void initialise() {
    branch = BranchUniversalObject(
        canonicalIdentifier: 'flutter/branch',
        contentMetadata: BranchContentMetaData()
          ..addCustomMetadata('deep_link_title', 'flutter deep link'));
    FlutterBranchSdk.registerView(buo: branch);
    listenDeepLinkData();
  }

  Future<String?> generateDeepLinks(BranchLinkProperties properties) async {
    BranchResponse branchResponse = await FlutterBranchSdk.getShortUrl(
        buo: branch, linkProperties: properties);
    if (branchResponse.success) {
      printLog('BranchResponse ---> ${branchResponse.result}');
      return branchResponse.result;
    } else {
      printLog(
          'BranchResponse ---> ${branchResponse.errorCode}, ${branchResponse.errorMessage}');
      return null;
    }
  }

  void listenDeepLinkData() async {
    FlutterBranchSdk.initSession().listen((event) {
      if (event.containsKey('+clicked_branch_link') &&
          event["+clicked_branch_link"] == true) {
        if (event["~feature"] != null) myLocal.utmFeature = event["~feature"];
        if (event["~channel"] != null) myLocal.utmChannel = event["~channel"];
        if (event["~campaign"] != null) {
          myLocal.utmCampaign = event["~campaign"];
        }
        if (event["~channel"] != null && event["~channel"] == "app_referral") {
          myHelper.extractReferralCode(event["referral_code"] ?? "");
        }
        if (event["~channel"] != null && event["~channel"] == "ifa_referral") {
          myHelper.extractIfaCode(event["ifa_id"]?.toString() ?? '');
        }
        if (event['screen'] == 'profile') {
          printLog('DeepLink ${jsonEncode(event)}');
          Get.toNamed(profileScreen);
        }
        // printLog("Channel ${event["~channel"]}");
      }
    }, onError: (error) {
      printLog('DeepLink Error $error');
    });
  }
}

final branchIO = BranchSetup();
