import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:moengage_flutter/model/inapp/click_data.dart';
import 'package:moengage_flutter/model/inapp/inapp_action_type.dart';
import 'package:moengage_flutter/model/inapp/inapp_data.dart';
import 'package:moengage_flutter/model/inapp/navigation_action.dart';
import 'package:moengage_flutter/model/push/push_campaign_data.dart';
import 'package:moengage_flutter/moengage_flutter.dart';
import '../config/routes/app_routes.dart';
import '../constants/app_constants.dart';

class MoEngageSetup {
  final MoEngageFlutter moEngagePlugin = MoEngageFlutter(moEngageToken);

  void initialise() async {
    moEngagePlugin.setPushClickCallbackHandler(_onPushClick);
    moEngagePlugin.setInAppClickHandler(_onInAppClick);
    moEngagePlugin.setInAppShownCallbackHandler(_onInAppShown);
    moEngagePlugin.setInAppDismissedCallbackHandler(_onInAppDismiss);
    moEngagePlugin.initialise();
    moEngagePlugin.setupNotificationChannelsAndroid();
    // moEngagePlugin.requestPushPermissionAndroid();
    // moEngagePlugin.registerForPushNotification();
    // var isGranted = await appPermissions
    //     .permissionsGranted(AppPermissions.notificationPermission);
    moEngagePlugin.pushPermissionResponseAndroid(true);
    moEngagePlugin.showInApp();
    moEngagePlugin.getSelfHandledInApp();
  }

  void _onPushClick(PushCampaignData message) {
    printLog("onPushClick() $message");

    /// isDefaultAction - This key is present only for the Android Platform.
    if (myHelper.isAndroid) {
      var payload = message.data.isDefaultAction
          ? message.data.payload
          : message.data.clickedAction;
      if (payload.containsKey("screen")) {
        var navigateTo = payload["screen"];
        Future.delayed(
            Duration(
                milliseconds: Get.currentRoute == splashScreen ? 5000 : 100),
            () {
          Get.toNamed("/$navigateTo");
        });
      }
    } else {
      ///In iOS, you would always receive the key-value pairs for clicked action in the clickedAction property
      var clickedAction = message.data.clickedAction;
      if (clickedAction.containsKey('payload') &&
          clickedAction['payload']['kvPair']['screen'] != null) {
        var navigateTo = clickedAction['payload']['kvPair']['screen'];
        Future.delayed(
            Duration(
                milliseconds: Get.currentRoute == splashScreen ? 5000 : 100),
            () {
          Get.toNamed("/$navigateTo");
        });
        printLog('New URL ${clickedAction['payload']['kvPair']['screen']}');
      }
    }
  }

  void _onInAppClick(ClickData message) {
    printLog("onInAppClick $message");
    if (message.action.actionType == ActionType.navigation) {
      var action = message.action as NavigationAction;
      printLog('New URl ${action.navigationUrl}');
    }
  }

  void _onInAppShown(InAppData message) {
    printLog("onInAppShown $message");
  }

  void _onInAppDismiss(InAppData message) {
    printLog("onInAppDismiss $message");
  }
}

final moEngage = MoEngageSetup();
