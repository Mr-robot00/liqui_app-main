import UIKit
import Flutter
import BranchSDK
import moengage_flutter
import MoEngageSDK

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
//        Branch.getInstance().enableLogging()
        
        let sdkConfig = MoEngageSDKConfig(withAppID: "T2TNL64IKIHYAKA11E2DWJR9")
            sdkConfig.enableLogs = true
        
        MoEngageInitializer.sharedInstance.initializeDefaultInstance(sdkConfig, launchOptions: launchOptions)
        
        MoEngageSDKMessaging.sharedInstance.registerForRemoteNotification(withCategories: nil, andUserNotificationCenterDelegate: self)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    //Remote notification Registration callback methods
    override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      //Call only if MoEngageAppDelegateProxyEnabled is NO
      MoEngageSDKMessaging.sharedInstance.setPushToken(deviceToken)
    }


    override func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
      //Call only if MoEngageAppDelegateProxyEnabled is NO
      MoEngageSDKMessaging.sharedInstance.didFailToRegisterForPush()
    }
    
    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void) {
        
        //Call only if MoEngageAppDelegateProxyEnabled is NO
        MoEngageSDKMessaging.sharedInstance.userNotificationCenter(center, didReceive: response)
        
        //Custom Handling of notification if Any
        let pushDictionary = response.notification.request.content.userInfo
        print(pushDictionary)
        
        completionHandler();
    }


    @available(iOS 10.0, *)
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //This is to only to display Alert and enable notification sound
        completionHandler([.sound,.alert])
        
    }

}
 
