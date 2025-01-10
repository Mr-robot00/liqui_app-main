import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/networking/api_path.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';

// Colors

// const MaterialColor primarySwatchColor = MaterialColor(
//   0xFF3B86F7,
//   <int, Color>{
//     50: Color(0xFF9dc3fb),
//     100: Color(0xFF89b6fa),
//     200: Color(0xFF76aaf9),
//     300: Color(0xFF629ef9),
//     400: Color(0xFF4f92f8),
//     500: Color(0xFF3B86F7),
//     600: Color(0xFF4d75a5),
//     700: Color(0xFF336198),
//     800: Color(0xFF1a4e8b),
//     900: Color(0xFF003A7E),
//   },
// );

const Color primaryColor = Color(0xFF3B86F7);
const Color secondaryColor = Color(0xFF003A7E);
const Color primaryDarkColor = Color(0xFF212121);
const Color secondaryDarkColor = Color(0xFF303030);
const Color buttonColor = Color(0xFF3B86F7);
const Color buttonDisabledColor = Color(0xFFE3E3EC);
const Color fontTitleColor = Color(0xFF000A33);
const Color fontDesColor = Color(0xFF2B2B2B);
const Color fontHintColor = Color(0xFF4D4F66);
const Color fontPlaceholderColor = Color(0xFFBDBDBB);
const Color backgroundColor = Color(0xFFF5F9FF);
const Color redColor = Color(0xFFFC4C70);
const Color redLightColor = Color(0xFFE57373);
const Color redLighterColor = Color(0xFFFFCDD2);
const Color greenColor = Color(0xFF3FC67D);
const Color greenDarkColor = Color(0xFF008E41);
const Color greenLightColor = Color(0xFF81C784);
const Color yellowColor = Color(0xFFFFB74A);
const Color whiteColor = Color(0xFFFFFFFF);
const Color grayColor = Color(0xFF808080);
const Color grayDarkColor = Color(0xFF808192);
const Color grayLightColor = Color(0xFFE3E3EC);
const Color blackColor = Color(0xFF000000);
const Color blueColor = Color(0xFF01B7CD);
const Color blueDarkColor = Color(0xFF018998);
const Color blueLightColor = Color(0xFFE3FAFF);
const Color violetColor = Color(0xFF8801B7);
const Color violetDarkColor = Color(0xFF070C24);
const Color violetLightColor = Color(0xFF82579C);
const Color filledColor = Color(0xFFF9F9FF);
const Color transparentColor = Color(0x00000000);
const Color kycBeigeColor = Color(0xFFFFEBC5);
const Color portfolioCardColor = Color(0xFF003A7E);
const Color peachLightColor = Color(0xFFFDF0E9);
const Color navyDarkColor = Color(0xFF000A33);
const Color shimmerHighlightColor = Color(0xFFF5F5F5);
const Color shimmerBaseColor = Color(0xFFE0E0E0);
const Color greyColor = Color(0xFF070C24);
const Color darkGrayColor = Color(0xFF808192);
const Color lightYellowColor = Color(0xFFFFEBC5);
const Color blackLightColor = Color(0xFF424242);
const Color kycRejectBeigeColor = Color(0xFFf9dee1);
const Color kycRejectTitleColor = Color(0xFFFC4C57);

// Font side
final double fontSizeDefault = myHelper.isTablet ? fontSize18 : fontSize14;
final double fontSizeTitle = myHelper.isTablet ? fontSize20 : fontSize16;
final double fontSizeDes = myHelper.isTablet ? fontSize18 : fontSize14;
final double fontSizeButton = myHelper.isTablet ? fontSize20 : fontSize16;
final double fontSizeS = myHelper.isTablet ? fontSize18 : fontSize14;
final double fontSizeM = myHelper.isTablet ? fontSize20 : fontSize16;
final double fontSizeL = myHelper.isTablet ? fontSize22 : fontSize18;
const double fontSize1 = 1.0;
const double fontSize2 = 2.0;
const double fontSize3 = 3.0;
const double fontSize4 = 4.0;
const double fontSize5 = 5.0;
const double fontSize6 = 6.0;
const double fontSize7 = 7.0;
const double fontSize8 = 8.0;
const double fontSize9 = 9.0;
const double fontSize10 = 10.0;
const double fontSize12 = 12.0;
const double fontSize14 = 14.0;
const double fontSize16 = 16.0;
const double fontSize18 = 18.0;
const double fontSize20 = 20.0;
const double fontSize22 = 22.0;
const double fontSize24 = 24.0;
const double fontSize26 = 26.0;
const double fontSize28 = 28.0;
const double fontSize30 = 30.0;
const double fontSize32 = 32.0;

// Padding
const double padding0 = 0.0;
const double padding1 = 1.0;
const double padding2 = 2.0;
const double padding3 = 3.0;
const double padding4 = 4.0;
const double padding5 = 5.0;
const double padding6 = 6.0;
const double padding7 = 7.0;
const double padding8 = 8.0;
const double padding9 = 9.0;
const double padding10 = 10.0;
const double padding12 = 12.0;
const double padding14 = 14.0;
const double padding15 = 15.0;
const double padding16 = 16.0;
const double padding18 = 18.0;
const double padding20 = 20.0;
const double padding22 = 22.0;
const double padding24 = 24.0;
const double padding25 = 25.0;
const double padding26 = 26.0;
const double padding28 = 28.0;
const double padding30 = 30.0;
const double padding35 = 35.0;
const double padding32 = 32.0;
const double padding40 = 40.0;
const double padding50 = 50.0;
const double padding60 = 60.0;
const double padding70 = 70.0;
const double padding85 = 85.0;
const double padding100 = 100.0;
const double padding120 = 120.0;
const double padding130 = 130.0;
const double padding140 = 140.0;
const double padding150 = 150.0;
const double padding170 = 170.0;
const double padding200 = 200.0;

// Spacing
final double spaceS = myHelper.isTablet ? space10 : space8;
final double spaceM = myHelper.isTablet ? space16 : space12;
final double spaceL = myHelper.isTablet ? space28 : space24;
const double space2 = 2.0;
const double space4 = 4.0;
const double space6 = 6.0;
const double space8 = 8.0;
const double space10 = 10.0;
const double space12 = 12.0;
const double space14 = 14.0;
const double space16 = 16.0;
const double space18 = 18.0;
const double space20 = 20.0;
const double space22 = 22.0;
const double space24 = 24.0;
const double space28 = 28.0;
const double space30 = 30.0;

// screen width and height
final double screenWidth = mediaQuery.size.width;
final double screenHeight = mediaQuery.size.height;
final MediaQueryData mediaQuery = Get.mediaQuery;

// Assets

//Strings
final String noInternetMessage = "no_internet_message".tr;
// final String commonErrorMessage = 'something_went_wrong'.tr;
final String unauthorizedMessage = 'unauthorized_error'.tr;
final String invalidRequestMessage = 'invalid_request_error'.tr;
final String serverErrorMessage = 'server_internal_error'.tr;
final String resourceErrorMessage = 'resource_not_found_error'.tr;
const String rupeeSymbol = '\u{20B9}';

const String termsAndConditionLink =
    'https://www.liquiloans.com/terms-and-condition';
const String privacyPolicyLink = 'https://www.liquiloans.com/privacy-policy';
const String faqLink = 'https://www.liquiloans.com/faq';
const String mailId = 'investor_ops@liquiloans.com';
const String facebookLink = 'https://www.facebook.com/LiquiLoans/';
const String linkedInLink = 'https://in.linkedin.com/company/liquiloans';
const String twitterLink = 'https://twitter.com/liquiloans';
// const String referralDomainLink = 'https://liquimoney.page.link';
// const String referralDomainStageLink = 'https://liquimoneystage.page.link';
// const String androidPackageId = 'com.liquimoney';
// const String iOSBundleId = 'com.liquimoney';
// const String appStoreId = '1612622624';
const String moEngageToken = 'T2TNL64IKIHYAKA11E2DWJR9';
const String graphQLToken =
    'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImdjbXMtbWFpbi1wcm9kdWN0aW9uIn0.eyJ2ZXJzaW9uIjozLCJpYXQiOjE2ODEyOTk0ODEsImF1ZCI6WyJodHRwczovL2FwaS1hcC1zb3V0aC0xLmh5Z3JhcGguY29tL3YyL2NsZnJxZDF0YzE0YzUwMXVuZGdtOWNucGMvbWFzdGVyIiwibWFuYWdlbWVudC1uZXh0LmdyYXBoY21zLmNvbSJdLCJpc3MiOiJodHRwczovL21hbmFnZW1lbnQuZ3JhcGhjbXMuY29tLyIsInN1YiI6ImM2Y2U3MjYzLWYxYzctNDkxYy1hYjUxLTZmYWJiOTFiMWQ3NyIsImp0aSI6ImNsZ2RtYXVsazA5d3cwMXVsYTBoeTZkcGQifQ.ZTFOPOd59wyLfbQQwV2tkMPl2Zu4iCBsIGOCDYQT1NrbM7LX9JdHvK4YHgCXNCUz_iYV_ukGYGefv_DVRuB4_W9bE1FoQ6Q2xyi1ayiibRupI2ByHTOqfVNeWeC_UaMWgm5J9ouhfOwaChCveWyelJET4w9VNKXTNaCFj36bQiZg8hhuBikm3pgYqG3rbCATjOIZw4y3SP1ozk8JTz2ewOlZROD6wBEpvBZAxeBCvI2ey0_C2HjeBF4kGFXbLib1htdBEW0Cv5yVpSZ2qrPMR4q1qallET9APbASZORB0JjgoEoDRZo7ESzBV7FHi72K2g2L7WjZ0NfWDJw8V7q51Hz25m9Fhmt9Mj2SFTDkqSk1-uXVGnXxSEJfaUhGr3Jvz02_t00g6af74XPfR70t2lGVB1UZrUcJr8-diZgLAu-Bdz5FzQQxfpnDjPRMqif1H8Zj_YlwSCBKktaLSP3-R8Y9NP_CBaiOPwDWhxjyMUrrG6lOjjaIT7bP2UdwUX5B9bGa1sePCWJsQcBnF8gaoR1apAs3c4V7oMRnPMl1Ho4nndO1TzWmYnqsP7vy9P_WnUakySZ6wiArz7INrHEPaZFZK3l8GtMwR8qE_xZLdisWzhAVOy66DT93JTFZSgODNu-ud32d0XzNaJsz694gpTHkqAP-zfBlA0H54pZaRvg';
const String _mixPanelSTGToken = 'e405c9602f9c3e098c3d482c57e61d00';
const String _mixPanelPRODToken = '4ba80fa8eeedfe5e9abff0d5193552f4';
const String mixPanelToken = debugMode ? _mixPanelSTGToken : _mixPanelPRODToken;
