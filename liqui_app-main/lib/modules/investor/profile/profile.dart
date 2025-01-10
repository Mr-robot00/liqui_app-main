import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/analytics/log_events.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/utils/my_style.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/modules/investor/profile/controllers/profile_controller.dart';

import '../../../global/constants/app_constants.dart';
import '../../../global/utils/helpers/my_helper.dart';
import '../../../global/widgets/index.dart';

class Profile extends GetView<ProfileController> {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.theme;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          /// updating the value for try_again for profile
          controller.homeController.profileRetry =
              (controller.isLoading.value && !controller.showShimmer.value) &&
                  controller.errorMsg.value.validString;

          return OverlayScreen(
            isFromMainScreens: true,
            isLoading:
                controller.isLoading.value && !controller.showShimmer.value,
            errorMessage: controller.errorMsg.value,
            onRetryPressed: () => controller.handleRetryAction(),
            backgroundColor: controller.overlayLoading.value
                ? Get.isDarkMode
                    ? Colors.black54
                    : Colors.white54
                : Get.theme.scaffoldBackgroundColor,
            child:
                controller.showShimmer.value ? myShimmer.profileShimmer : body,
          );
        }),
      ),
    );
  }

  Widget get body {
    return RefreshIndicator(
      onRefresh: controller.onPullRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          titleSection(),
          if (!controller.kycVerified &&
              !controller.kycUnderReview &&
              !controller.kycRejected)
            Padding(
              padding: const EdgeInsets.only(
                  left: padding20,
                  right: padding20,
                  top: padding30,
                  bottom: padding20),
              child: InkWell(
                onTap: () {
                  logEvent.verifyKycButton(
                      page: "page_${myProfileScreen.substring(1)}");
                  myWidget.kycAlertDialog(
                      screenName: profileScreen.substring(1));
                },
                child: myHelper.getAssetImage('complete_profile',
                    width: screenWidth, fit: BoxFit.fill),
              ),
            ),
          if ((controller.kycUnderReview && !controller.kycRejected) ||
              controller.kycRejected)
            Padding(
              padding: const EdgeInsets.only(
                  left: padding20,
                  right: padding20,
                  top: padding16,
                  bottom: padding20),
              child: myHelper.getAssetImage('kyc_review',
                  fit: BoxFit.fill, width: screenWidth),
            ),
          // if (controller.kycRejected)
          // myWidget.getKycRejectionCard(
          //     "${controller.basicDetailRes.value.data!.kycData?[0].kycRejectionReasons}"),
          listSection(),
          const SizedBox(
            height: padding20,
          ),
          SizedBox(
            width: screenWidth / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                socialWidget("facebook", () {
                  logEvent.buttonSocialMedia(
                      page: "page_${profileScreen.substring(1)}",
                      type: "facebook");
                  myHelper.openUrl(facebookLink, inAppView: false);
                }),
                socialWidget("twitter", () {
                  logEvent.buttonSocialMedia(
                      page: "page_${profileScreen.substring(1)}",
                      type: "twitter");
                  myHelper.openUrl(twitterLink, inAppView: false);
                }),
                socialWidget("linkedin", () {
                  logEvent.buttonSocialMedia(
                      page: "page_${profileScreen.substring(1)}",
                      type: "linkedin");
                  myHelper.openUrl(linkedInLink, inAppView: false);
                })
              ],
            ),
          ),
          if (controller.appVersion.validString)
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(padding20),
              child: Text(
                controller.appVerBuild,
                style: myStyle.myFontStyle(),
              ),
            )
        ],
      ),
    );
  }

  Widget titleSection() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(padding20, padding0, padding20, padding0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: padding20),
                  child: Text(
                    myLocal.userDataConfig.userName.validString
                        ? myLocal.userDataConfig.userName
                        : controller.basicDetailRes.value.data?.profile?.name ??
                            "",
                    style: myStyle.defaultFontStyle,
                  ),
                ),
                Text(
                    key: controller.investorIdKey,
                    '${"investor_id".tr}: ${myLocal.investorId}',
                    style: myStyle.myFontStyle(
                        color:
                            Get.isDarkMode ? grayLightColor : darkGrayColor)),
                if (controller.kycVerified)
                  Padding(
                    padding: const EdgeInsets.only(top: padding5),
                    child: myHelper.getAssetImage('kyc_verified'),
                  )
              ],
            ),
          ),
          const SizedBox(width: padding10),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: padding8),
              child: controller.getGender == 'Male'
                  ? myHelper.getAssetImage('male',
                      height: padding70, width: padding70)
                  : controller.getGender == 'Female'
                      ? myHelper.getAssetImage('female',
                          height: padding70, width: padding70)
                      : const Icon(Icons.account_circle, size: padding60))
          // myHelper.getAssetImage('profile', width: 70, height: 70),
        ],
      ),
    );
  }

  Widget listSection() {
    final child = <Widget>[];
    child.add(myListTile("user", 'my_profile'.tr, "my_profile"));
    if (controller.deviceAuthAvailable) {
      child.add(myListTile("", "enable_app_lock".tr, ""));
    }
    // child.add(myListTile("key", 'change_password'.tr, "change_password"));
    child.add(myListTile("", 'dark_mode'.tr, "change_theme"));
    /*if (controller.referralUrl.value.validString) {
      child.add(myListTile("referral", 'refer_friend'.tr, "refer_friend"));
    }*/
    child.add(myListTile("referral", 'refer_friend'.tr, "refer_friend"));

    child.add(myListTile("contact", 'contact_us'.tr, "contact_us"));
    child.add(myListTile("faq", 'faq'.tr, "faq"));
    child.add(myListTile("logout", 'logout'.tr, "logout"));

    return Padding(
      padding: const EdgeInsets.only(left: padding10, right: padding10),
      child: Column(children: child),
    );
  }

  Widget myListTile(String icon, String title, String clickId) {
    return ListTile(
      key: title == 'my_profile'.tr
          ? controller.profileDetailsKey
          : title == 'enable_app_lock'.tr
              ? controller.appLockKey
              : null,
      leading: (title == "enable_app_lock".tr
          ? const Icon(
              Icons.lock,
              color: primaryColor,
              size: padding32,
            )
          : title == "dark_mode".tr
              ? const Icon(
                  Icons.brightness_4_rounded,
                  color: primaryColor,
                  size: padding32,
                )
              : myHelper.getAssetImage(icon,
                  height: padding30, width: padding30, fit: BoxFit.contain)),
      title: Text(
        title,
        style: myStyle.myFontStyle(
            fontWeight: FontWeight.w400,
            fontSize: fontSize14,
            color: Get.isDarkMode ? whiteColor : blackColor),
      ),
      trailing: SizedBox(
        width: padding170,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (title == "dark_mode".tr)
              Text(
                controller.themeValue.value == "dark_mode"
                    ? "On"
                    : controller.themeValue.value == "light_mode"
                        ? "Off"
                        : "device_settings".tr,
                style: myStyle.myFontStyle(
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? whiteColor : blackColor),
              ),
            title == "enable_app_lock".tr
                ? Switch(
                    value: controller.switchValue.value,
                    onChanged: (value) {
                      if (value) {
                        controller.enableAppLock();
                      } else {
                        controller.switchValue.value = value;
                        myLocal.enableAppLock = value;
                      }
                    },
                  )
                : const Icon(Icons.chevron_right, size: padding22),
          ],
        ),
      ),
      onTap: () {
        onClick(clickId);
      },
    );
  }

  onClick(String id) async {
    if (id == "my_profile") {
      logEvent.buttonMyProfile(page: "page_${profileScreen.substring(1)}");
      Get.toNamed(myProfileScreen);
    } else if (id == "change_password") {
      //change password
    } else if (id == "change_theme") {
      logEvent.buttonDarkMode(page: "page_${profileScreen.substring(1)}");
      await myWidget.showThemeSelection(isDismissible: true);
      controller.themeValue.value = myLocal.themeValue;
    } else if (id == "refer_friend") {
      logEvent.buttonReferFriend(page: "page_${profileScreen.substring(1)}");
      controller.referFriend();
    } else if (id == "contact_us") {
      logEvent.buttonContactUs(page: "page_${profileScreen.substring(1)}");
      myHelper.sendMail(mailId);
    } else if (id == "faq") {
      logEvent.buttonFaqs(page: "page_${profileScreen.substring(1)}");
      myHelper.openUrl(faqLink);
    } else if (id == "logout") {
      myWidget.showConfirmationPopUp("logout_confirmation".tr,
          // onConfirmPressed: () => myHelper.logoutUser(reLogin: false),
          onConfirmPressed: () => controller.callPostLogOut(),
          confirmButtonLabel: "logout".tr);
    }
  }

  Widget socialWidget(String imageTitle, VoidCallback? onClicked) {
    return RoundedContainer(
      radius: padding25,
      width: padding50,
      height: padding50,
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      child: MaterialButton(
          onPressed: onClicked,
          padding: const EdgeInsets.symmetric(
              vertical: padding0, horizontal: padding0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(padding25),
            ),
          ),
          child: myHelper.getAssetImage(
            imageTitle,
            height: padding30,
            width: padding30,
          )),
    );
  }
}
