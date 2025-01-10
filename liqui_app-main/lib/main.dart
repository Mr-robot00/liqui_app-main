import 'dart:async';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/config/themes/app_theme.dart';
import 'package:liqui_app/global/push_notification/firebase_setup.dart';
import 'package:liqui_app/global/utils/helpers/my_route_observer.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:liqui_app/global/widgets/index.dart';
import 'package:scaled_app/scaled_app.dart';

import 'global/analytics/index.dart';
import 'global/constants/app_strings.dart';
import 'global/utils/helpers/my_helper.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: scaleFactorCallback,
  );
  await Firebase.initializeApp();
  initCrashlytics();
  myHelper.configEasyLoading();
  await myLocal.init();
  myHelper.setDeviceUniqueId();
  initialiseAnalytics();
  customErrorWidget();
  HttpOverrides.global = MyHttpOverrides();
  //runAppScaled(const LiquiApp(), scaleFactor: scaleFactorCallback);
  runLiquiApp();
  // if(kDebugMode)FlutterBranchSdk.validateSDKIntegration();
}

void customErrorWidget() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return MyError(
      errorMessage: details.exceptionAsString(),
      dismissText: 'go_back'.tr,
      onDismissPressed: () => Get.previousRoute.isNotEmpty ? Get.back() : null,
    );
  };
}

Future runLiquiApp() async {
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const LiquiApp(),
    ),
  );
}

class LiquiApp extends StatefulWidget {
  const LiquiApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return LiquiAppState();
  }
}

class LiquiAppState extends State<LiquiApp> {
  int currentPageIndex = 0;
  bool scaleMediaQueryData = true;

  @override
  void initState() {
    initSetup();
    super.initState();
  }

  void initSetup() async {
    await FirebaseAnalytics.instance.logAppOpen();
    await FirebaseSetup().initialise();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.theme;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme(),
      navigatorObservers: [MyRouteObserver()],
      enableLog: false,
      darkTheme: AppTheme.darkTheme(),
      themeMode: myLocal.themeMode,
      translations: AppStrings(),
      locale: const Locale('en', 'IND'),
      fallbackLocale: const Locale('en', 'IND'),
      builder: (context, widget) {
        return DismissKeyboard(
          child: MediaQuery(
            data: MediaQuery.of(context).scale(),
            child: FlutterEasyLoading(child: widget),
          ),
        );
      },
      getPages: pageRoutes,
      initialRoute: splashScreen,
    );
  }
}

double scaleFactorCallback(Size deviceSize) {
  // screen width used in your UI design
  const double widthOfDesign = 390;
  return deviceSize.width / widthOfDesign;
}

Future<void> initCrashlytics() async {
  /// Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  ///To catch asynchronous errors that aren't handled by the Flutter framework, use PlatformDispatcher.instance.onError:
  FlutterError.onError = (errorDetails) {
    // debugPrint("Crash ${errorDetails.toStringShort()}");
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    //debugPrint("Crash ${error.toString()}");
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
