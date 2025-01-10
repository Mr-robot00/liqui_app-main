import 'dart:convert';
import 'dart:io';
import 'dart:io' as io;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liqui_app/global/config/routes/app_routes.dart';
import 'package:liqui_app/global/constants/index.dart';
import 'package:liqui_app/global/networking/api_path.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:liqui_app/global/utils/storage/my_local.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/index.dart';

extension IterableExtension<T> on Iterable<T> {
  T? get firstIsOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}

extension StringExtension on String {
  String get inCaps {
    if (!validString) return "";
    var result = replaceAll('_', ' ');
    return '${result[0].toUpperCase()}${result.substring(1)}';
  }

  String get allInCaps {
    if (!validString) return "";
    var result = replaceAll('_', ' ');
    return result.split(' ').map((str) => str.toUpperCase()).join(' ');
  }

  String get capFirstOfEach {
    if (!validString) return "";
    var result = replaceAll('_', ' ');
    return result
        .split(' ')
        .map((str) => str.isNotEmpty ? str.inCaps : str)
        .join(' ');
  }

  bool get isMobileNumberValid {
    String regexPattern = r'^(?:[+0][0-9])?[6-9]{1}[0-9]{9}$';
    // ^ Start of string
    // (?:[+0][6-9])? Optionally match a + or 0 followed by 6 to 9
    // [0-9]{10} Match 10 digits from 0 to 9
    // $ End of string
    var regExp = RegExp(regexPattern);
    if (isEmpty) {
      return false;
    } else if (regExp.hasMatch(this)) {
      return true;
    }
    return false;
  }

  bool get isEmailIdValid {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool get isPanValid {
    return RegExp("[A-Z]{3}[ABCFGHLJPT]{1}[A-Z]{1}[0-9]{4}[A-Z]{1}")
        .hasMatch(this);
  }

  String get maskNumber {
    if (isEmpty || length < 6) return this;
    int count = (length - 3) - 2;
    StringBuffer replace = StringBuffer();
    for (int i = 0; i < count; i++) {
      replace.write("*");
    }
    return replaceRange(2, length - 3, replace.toString());
  }
}

extension NullEmptyExtension on String? {
  bool get validString {
    return this != null && this!.isNotEmpty;
  }
}

extension CustomSnackbar on GetInterface {
  showSnackBar(String message, {String? title}) => Get.rawSnackbar(
        message: message,
        title: title,
        margin: const EdgeInsets.all(padding16),
        borderRadius: padding15,
        snackPosition: SnackPosition.TOP,
        backgroundColor: secondaryDarkColor.withOpacity(0.8),
        padding: EdgeInsets.symmetric(
            vertical: title.validString ? padding16 : padding20,
            horizontal: padding16),
      );
}

class MyHelper {
  bool get isTablet => MediaQuery.of(Get.context!).size.shortestSide >= 600;

  configEasyLoading() async {
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.threeBounce
      ..indicatorColor = primaryColor
      ..progressColor = primaryColor
      ..backgroundColor = Colors.white
      ..textColor = Colors.black
      ..maskType = EasyLoadingMaskType.black
      ..displayDuration = const Duration(seconds: 3)
      ..successWidget = const Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 40,
      )
      ..errorWidget = const Icon(
        Icons.error,
        color: Colors.red,
        size: 40,
      )
      ..infoWidget = const Icon(
        Icons.info,
        color: Colors.orange,
        size: 40,
      );
  }

  void chooseFolio({
    VoidCallback? onChanged,
    bool isDismissible = true,
    bool showAllFolio = false,
    bool showIfaChangeConfirmation = false,
    String ifaChangeConfirmationMsg = "",
    required String page,
    required String source,
  }) async {
    final result = await myWidget.showFolioSelection(
      showAllFolio: showAllFolio,
      isDismissible: isDismissible,
      showIfaChangeConfirmation: showIfaChangeConfirmation,
      ifaChangeConfirmationMsg: ifaChangeConfirmationMsg,
      page: page,
      source: source,
    );
    if (result != null && (result as bool)) {
      if (onChanged != null) onChanged();
    }
  }

  bool isIFAValid({String? id, bool showInvalidAlert = true}) {
    var ifaId = id ?? myLocal.ifaId;
    bool result;
    if (baseUrl == stgBaseUrl) {
      //[credIfaId(553),bharatPeIfaId(255),bharatPeIfaId2(594),bharatPeIfaId3(1591),stashFinIfaId(1103),epifiIfaId(1110),prudentIfaId(1113),indWealth(2689)]
      var defaultIfaStageArray = [
        '553',
        '255',
        '594',
        '1591',
        '1103',
        '1110',
        '1113',
        '2689',
      ];
      var ifaStageArray =
          myLocal.appConfig.ifaData?.stage ?? defaultIfaStageArray;
      result = ifaStageArray.contains(ifaId);
    } else {
      //[credIfaId(573),bharatPeIfaId(255),bharatPeIfaId2(890),bharatPeIfaId3(2454),stashFinIfaId(1673),epifiIfaId(1827),prudentIfaId(1799),indWealth(2689)]
      var defaultIfaProdArray = [
        '573',
        '255',
        '890',
        '2454',
        '1673',
        '1827',
        '1799',
        '2689',
      ];
      var ifaProdArray = myLocal.appConfig.ifaData?.prod ?? defaultIfaProdArray;
      result = ifaProdArray.contains(ifaId);
    }
    if (result && showInvalidAlert) myWidget.showInvalidIfaAlert();
    return !result;
  }

  Future<void> setDeviceUniqueId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      //return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      myLocal.deviceUniqueId =
          iosDeviceInfo.identifierForVendor ?? "Not unique identifier";
    } else {
      // var androidDeviceInfo = await deviceInfo.androidInfo;
      // myLocal.deviceUniqueId = androidDeviceInfo.id ?? "Not unique identifier";
      getAndroidUDI();
    }
  }

  void getAndroidUDI() {
    const methodChannel = MethodChannel('android_id');
    Future<String?> getId() => methodChannel.invokeMethod<String?>('getId');
    getId().then(
        (value) => {myLocal.deviceUniqueId = value ?? "Not unique identifier"});
  }

  Future<void> updateAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    myLocal.appVersion = info.buildNumber;
  }

  bool staringNotEmpty(String? value) {
    return (value != null && value.isNotEmpty);
  }

  Widget getNetworkImage(
    String image, {
    double? width,
    double? height,
    String? placeholder,
    String prefix = 'assets/images/',
    String postfix = '.png',
    Color? color,
    double padding = 0.0,
    BoxFit? fit,
  }) {
    return
        // new ClipOval(
        // child:
        staringNotEmpty(image)
            ? CachedNetworkImage(
                imageUrl: image,
                width: width,
                height: height,
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                    color: primaryColor,
                  ),
                ),
                /*placeholder: (context, url) => Container(
                    child: getPlaceholderImage(
                        image: placeholder,
                        width: width,
                        height: height,
                        prefix: prefix,
                        postfix: postfix,
                        color: color,
                        padding: padding,
                        fit: fit)
                    // new Center(
                    //   child: CircularProgressIndicator(
                    //     color: yellow,
                    //   ),
                    // ),
                    ),*/
                fit: fit ?? BoxFit.cover,
                errorWidget: (context, error, stack) => getPlaceholderImage(
                    image: placeholder,
                    width: width,
                    height: height,
                    prefix: prefix,
                    postfix: postfix,
                    color: color,
                    padding: padding,
                    fit: fit),
              )
            : getPlaceholderImage(
                image: placeholder,
                width: width,
                height: height,
                prefix: prefix,
                postfix: postfix,
                color: color,
                padding: padding,
                fit: fit);
    // );
  }

  Widget getBase64Image(
    String image, {
    double? width,
    double? height,
    String? placeholder,
    BoxFit? fit,
  }) {
    return staringNotEmpty(image)
        ? Image.memory(
            base64Decode(image),
            width: width,
            height: height,
            fit: fit ?? BoxFit.cover,
          )
        : getPlaceholderImage(
            image: placeholder, width: width, height: height, fit: fit);
  }

  Widget getAssetImage(
    String asset, {
    double? width,
    double? height,
    String prefix = 'assets/images/',
    String postfix = '.png',
    Color? color,
    double padding = 0.0,
    BoxFit? fit,
  }) {
    return postfix == '.svg'
        ? SvgPicture.asset(
            asset,
            height: height,
            width: width,
          )
        : getPlaceholderImage(
            image: asset,
            width: width,
            height: height,
            prefix: prefix,
            postfix: postfix,
            color: color,
            padding: padding,
            fit: fit);
  }

  SvgPicture svgIcon(
    String asset, {
    double? width,
    double? height,
    Color? color,
    String prefix = 'assets/images/',
  }) {
    return SvgPicture.asset(
      asset,
      height: height,
      width: width,
      colorFilter: ColorFilter.mode(color ?? violetDarkColor, BlendMode.srcIn),
    );
  }

  Widget getPlaceholderImage({
    String? image,
    double? width,
    double? height,
    String prefix = 'assets/images/',
    String postfix = '.png',
    Color? color,
    double padding = 0.0,
    BoxFit? fit,
  }) {
    return Container(
      padding: EdgeInsets.all(padding),
      child: Image.asset(
        prefix + (image ?? 'splash_icon') + postfix,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stack) => getPlaceholderImage(
            width: width,
            height: height,
            prefix: prefix,
            postfix: postfix,
            color: color,
            padding: padding,
            fit: fit),
      ),
    );
  }

  Image imageFromBase64String(
    String base64String, {
    double? width,
    double? height,
    BoxFit? fit,
  }) {
    return Image.memory(
      base64Decode(base64String),
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
    );
  }

  Uint8List dataFromBase64String(String base64String) =>
      base64Decode(base64String);

  String base64StringFromPath(String path) => base64Encode(
        io.File(path).readAsBytesSync(),
      );

  String base64StringFromUnit8(Uint8List data) => base64Encode(data);

  Future<void> downloadPdf(
      {required String base64,
      required String startDate,
      required String endDate}) async {
    final bytes = base64Decode(
      base64
          .replaceAll("data:application/pdf;base64,", "")
          .replaceAll('\n', ''),
    );

    final file = File(
      "${(await getApplicationCacheDirectory()).path}/Liquiloans_statement_${startDate}_to_$endDate.pdf",
    );
    await file.writeAsBytes(bytes.buffer.asUint8List());

    EasyLoading.dismiss();
    final result = await OpenFile.open(file.path);
    if (result.type != ResultType.done) Get.showSnackBar(result.message);

    // final result = await Share.shareXFiles(
    //   [XFile(file.path)],
    //   subject: fileName,
    //   sharePositionOrigin: Rect.fromLTWH(0, 0, screenWidth, screenHeight / 2),
    // );
    // if (result.status == ShareResultStatus.success) {
    //   debugPrint('Thank you for sharing the pdf!');
    // } else if (result.status != ShareResultStatus.dismissed) {
    //   Get.showSnackBar("something_went_wrong".tr);
    // }
  }

  logoutUser({bool reLogin = true}) async {
    Get.offAllNamed(reLogin ? otpScreen : loginScreen,
        arguments: reLogin
            ? {
                "mobile_number": myLocal.userDataConfig.userNumber,
                "accountExist": true,
                "sendOtp": true,
              }
            : {});
    if (!reLogin) myLocal.clearAppLock();
    myLocal.clearData();
  }

  phoneCall(String number) async {
    var url = "tel://${number.replaceAll(RegExp('\\s+'), '')}";
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      Get.showSnackBar("something_went_wrong".tr);
      throw 'Could not launch $url';
    }
  }

  openUrl(String url, {bool inAppView = true}) async {
    final Uri uri = Uri.parse(url);
    if (await hasNetwork) {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: inAppView
              ? LaunchMode.inAppWebView
              : LaunchMode.externalApplication,
          webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
          ),
        );
      } else {
        Get.showSnackBar("something_went_wrong".tr);
        throw 'Could not launch $url';
      }
    } else {
      Get.showSnackBar(noInternetMessage);
    }
  }

  sendMail(String toMailId, {String subject = '', String body = ''}) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.showSnackBar("something_went_wrong".tr);
      throw 'Could not launch $url';
    }
  }

  void share(String title, {String? subject}) async {
    await Share.share(
      title,
      subject: subject,
      sharePositionOrigin: Rect.fromLTWH(0, 0, screenWidth, screenHeight / 2),
    );
  }

  String get osType => Platform.isAndroid ? 'android' : 'ios';

  bool get isAndroid => Platform.isAndroid;

  bool get isOS => Platform.isIOS;

  Future<String> get appVersion async =>
      (await PackageInfo.fromPlatform()).version;

  Future<String> get appBuildNumber async =>
      (await PackageInfo.fromPlatform()).buildNumber;

  Future<bool> get isRealDevice async {
    if (Platform.isIOS) {
      return (await DeviceInfoPlugin().iosInfo).isPhysicalDevice;
    } else {
      // return (await DeviceInfoPlugin().androidInfo).isPhysicalDevice;
      return true;
    }
  }

  Future<int> get sdkVersion async {
    if (osType == 'android') {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.sdkInt;
    }
    throw UnsupportedError("Platform is not Android");
  }

  bool isNoDataFound(String msg) {
    return (msg.contains('No data found!') ||
        msg.contains('No data found') ||
        msg.contains('No Data Found!') ||
        msg.contains('No Data Found'));
  }

  void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  // FocusScope.of(Get.context!).requestFocus(FocusNode());

  bool get isDarkMode {
    return Get.isDarkMode;
  }

  String? formValidator(String value, String message, {bool isEmail = false}) {
    if (value.isEmpty) {
      return message;
    } else {
      if (isEmail) {
        if (!value.isEmailIdValid) return message;
      } else {
        return null;
      }
    }
    return null;
  }

  bool isNumeric(String s) {
    if (s.isEmpty) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }
    return utf8.decode(base64Url.decode(output));
  }

  Future<bool> showSetLocalDialog() async {
    var titles = ["English"];
    var locals = ["en"];
    // var countries = ["UK", "IND", "IND", "IND"];
    var initSelected = langPos;
    return await showDialog(
        context: Get.context!,
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('choose_language'.tr),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: titles
                        .asMap()
                        .entries
                        .map(
                          (e) => RadioListTile<String>(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              e.value,
                              style: TextStyle(
                                fontSize: isTablet ? 22.0 : 18.0,
                                fontFamily: "Poppins",
                              ),
                            ),
                            value: e.value,
                            groupValue: initSelected != -1
                                ? titles[initSelected]
                                : null,
                            selected: initSelected != -1
                                ? titles[initSelected] == e.value
                                : false,
                            onChanged: (value) {
                              setState(() {
                                initSelected = e.key;
                              });
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.cancel, color: whiteColor),
                  label: Text(
                    "cancel".tr,
                    style: TextStyle(
                        color: whiteColor, fontSize: isTablet ? 22.0 : 18.0),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: redColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: padding8)),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                if (initSelected != -1 && initSelected != langPos)
                  TextButton.icon(
                    icon: const Icon(Icons.check_circle, color: whiteColor),
                    label: Text(
                      "confirm".tr,
                      style: TextStyle(
                          color: whiteColor, fontSize: isTablet ? 22.0 : 18.0),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: greenColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: padding8)),
                    onPressed: () {
                      myLocal.localLang = locals[initSelected];
                      printLog("selected Language ${myLocal.localLang}");
                      setState(() {
                        Get.updateLocale(Locale(myLocal.localLang, 'IND'));
                      });
                      Navigator.pop(context, true);
                    },
                  ),
              ],
            );
          });
        });
  }

  int get langPos {
    switch (myLocal.localLang) {
      case "hi":
        return 1;
      case "mr":
        return 2;
      case "gu":
        return 3;
      default:
        return 0;
    }
  }

  String get appEnvironment {
    if (baseUrl == stgBaseUrl) {
      return 'stage';
    } else {
      return 'production';
    }
  }

  void extractReferralCode(String link) {
    /// extract from short link
    myLocal.referralCode = link;
  }

  void extractIfaCode(link) => myLocal.setIfaCode = '$link';

  Future<bool> get hasNetwork async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  get currencyFormat => NumberFormat('#,##,###.##');

  Color darken({required Color color, double amount = 0.3}) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0))
        .toColor();
  }
}

final myHelper = MyHelper();
