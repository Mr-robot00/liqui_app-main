/// data : {"mobileAppConfig":{"introPageInfo":[{"subtitle":"NBFC, Licensed & Regulated by RBI","title":"India's No. 1 P2P Platform","type":"Image","asset":{"url":"https://media.graphassets.com/6mPg7LX3TmV5SSSBTb3Q","fileName":"intro1.png"}},{"subtitle":"Intro slide 2 subtitle","title":"Intro slide 2","type":"Video","asset":{"url":"https://media.graphassets.com/3clsbtAVRfCyFM2eBhN4","fileName":"intro2.mp4"}},{"subtitle":"Earn up to 10.5% returns on your investment","title":"100% Investors have made money","type":"Image","asset":{"url":"https://media.graphassets.com/4bUJOkqQaG6B2tExiiUF","fileName":"intro3.png"}}],"appVersions":{"ios":{"version":"1.0.4","storeUrl":"https://apps.apple.com/in/app/liquimoney/id1612622624","changeLog":[],"buildNumber":"47","forceUpdate":true},"android":{"version":"1.1.8","storeUrl":"https://play.google.com/store/apps/details?id=com.liquimoney","changeLog":[],"buildNumber":"42","forceUpdate":true}},"appUpdateMessage":"Update Required\nAn update to LiquiMoney is required to continue","fdRoi":7,"kycStatusMapping":null,"netWorthCertificateMessage":"*T&C Apply\nRBI requirement: networth certificate for >10 lakh investments","referralMessage":"Hey! Come check out LiquiLoans investment app where you can earn upto 10.5% returns! Click this link & download the app now to start investing!","roiSourceMessage":"*Source : Avg rates are taken by the top banks of India","savingRoi":2.5,"showSip":true,"splashPageMedia":{"subtitle":"Show this icon on splash page","title":"Splash Image","asset":{"url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r","fileName":"splash.png"}},"investBanner":{"fileName":"promo_text.png","url":"https://media.graphassets.com/fjws3XpRT4S0FnSlP1RQ"},"loginPageInfo":{"title":"Welcome","subtitle":"Earn upto 10.5%* returns","asset":{"fileName":"splash.png","url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r"}},"signAgreementTnc":{"terms":{"title":"Terms","description":"Terms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to able by the terms of service in order to use the offered. Terms of service can also be merely a disclaimer, especially regarding the use of websites."},"conditions":{"title":"Conditions","description":"Violations of system or network security may result in civil or criminal liability. We will investigate such violations and prosecute users who are involved. You agree not to use any device, software or routine to interfere or attempt to interfere with the proper working of this website or any activity being conducted on Website. You agree, further not to use or attempt to use any engine, software, tool, agent or other device or mechanism including without limitation, browser, spiders, robots, avatars or intelligent agents to navigation or search this website on the search engine and search agents available from us on this Website."}},"paymentGateways":[{"title":"PayU","gatewayId":"PayU","logo":{"fileName":"payu.png","url":"https://media.graphassets.com/Wk6dDemQTBOM9KVDEXmm"}},{"title":"Paytm","gatewayId":"Paytm","logo":{"fileName":"paytm.png","url":"https://media.graphassets.com/YoOAYlgCRluCshyytkHz"}}],"transactionTabs":[{"title":"All","tabHeader":"Total Portfolio Value"},{"title":"Investment","tabHeader":"Total Invested Amount"},{"title":"Interest","tabHeader":"Total Interest Credited to your account"},{"title":"Withdraw","tabHeader":"Total Withdrawn Amount"}],"dashboardActions":{"title":"What’s in it for you","subtitle":"Know the benefits of having a LiquiMoney account","corouselItems":[{"title":"Slide 1","subtitle":"Slide 1 subtitle","imageLink":"lock-in","image":{"fileName":"slider1.png","url":"https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"}},{"title":"Slide 2","subtitle":"Slide 2 subtitle","imageLink":"lock-in","image":{"fileName":"slider2.png","url":"https://media.graphassets.com/jYzPV3kaRjKUDkRbixCQ"}},{"title":"Slide 3","subtitle":"Slide 3 subtitle","imageLink":"lock-in","image":{"fileName":"slider3.png","url":"https://media.graphassets.com/UZwUhRx6QZSjpl3OUiQ3"}}]}}}

class AppConfigResponse {
  AppConfigResponse({
    this.data,
  });

  AppConfigResponse.fromJson(dynamic json) {
    data = json['data'] != null ? AppData.fromJson(json['data']) : null;
  }

  AppData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// mobileAppConfig : {"introPageInfo":[{"subtitle":"NBFC, Licensed & Regulated by RBI","title":"India's No. 1 P2P Platform","type":"Image","asset":{"url":"https://media.graphassets.com/6mPg7LX3TmV5SSSBTb3Q","fileName":"intro1.png"}},{"subtitle":"Intro slide 2 subtitle","title":"Intro slide 2","type":"Video","asset":{"url":"https://media.graphassets.com/3clsbtAVRfCyFM2eBhN4","fileName":"intro2.mp4"}},{"subtitle":"Earn up to 10.5% returns on your investment","title":"100% Investors have made money","type":"Image","asset":{"url":"https://media.graphassets.com/4bUJOkqQaG6B2tExiiUF","fileName":"intro3.png"}}],"appVersions":{"ios":{"version":"1.0.4","storeUrl":"https://apps.apple.com/in/app/liquimoney/id1612622624","changeLog":[],"buildNumber":"47","forceUpdate":true},"android":{"version":"1.1.8","storeUrl":"https://play.google.com/store/apps/details?id=com.liquimoney","changeLog":[],"buildNumber":"42","forceUpdate":true}},"appUpdateMessage":"Update Required\nAn update to LiquiMoney is required to continue","fdRoi":7,"kycStatusMapping":null,"netWorthCertificateMessage":"*T&C Apply\nRBI requirement: networth certificate for >10 lakh investments","referralMessage":"Hey! Come check out LiquiLoans investment app where you can earn upto 10.5% returns! Click this link & download the app now to start investing!","roiSourceMessage":"*Source : Avg rates are taken by the top banks of India","savingRoi":2.5,"showSip":true,"splashPageMedia":{"subtitle":"Show this icon on splash page","title":"Splash Image","asset":{"url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r","fileName":"splash.png"}},"investBanner":{"fileName":"promo_text.png","url":"https://media.graphassets.com/fjws3XpRT4S0FnSlP1RQ"},"loginPageInfo":{"title":"Welcome","subtitle":"Earn upto 10.5%* returns","asset":{"fileName":"splash.png","url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r"}},"signAgreementTnc":{"terms":{"title":"Terms","description":"Terms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to able by the terms of service in order to use the offered. Terms of service can also be merely a disclaimer, especially regarding the use of websites."},"conditions":{"title":"Conditions","description":"Violations of system or network security may result in civil or criminal liability. We will investigate such violations and prosecute users who are involved. You agree not to use any device, software or routine to interfere or attempt to interfere with the proper working of this website or any activity being conducted on Website. You agree, further not to use or attempt to use any engine, software, tool, agent or other device or mechanism including without limitation, browser, spiders, robots, avatars or intelligent agents to navigation or search this website on the search engine and search agents available from us on this Website."}},"paymentGateways":[{"title":"PayU","gatewayId":"PayU","logo":{"fileName":"payu.png","url":"https://media.graphassets.com/Wk6dDemQTBOM9KVDEXmm"}},{"title":"Paytm","gatewayId":"Paytm","logo":{"fileName":"paytm.png","url":"https://media.graphassets.com/YoOAYlgCRluCshyytkHz"}}],"transactionTabs":[{"title":"All","tabHeader":"Total Portfolio Value"},{"title":"Investment","tabHeader":"Total Invested Amount"},{"title":"Interest","tabHeader":"Total Interest Credited to your account"},{"title":"Withdraw","tabHeader":"Total Withdrawn Amount"}],"dashboardActions":{"title":"What’s in it for you","subtitle":"Know the benefits of having a LiquiMoney account","corouselItems":[{"title":"Slide 1","subtitle":"Slide 1 subtitle","imageLink":"lock-in","image":{"fileName":"slider1.png","url":"https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"}},{"title":"Slide 2","subtitle":"Slide 2 subtitle","imageLink":"lock-in","image":{"fileName":"slider2.png","url":"https://media.graphassets.com/jYzPV3kaRjKUDkRbixCQ"}},{"title":"Slide 3","subtitle":"Slide 3 subtitle","imageLink":"lock-in","image":{"fileName":"slider3.png","url":"https://media.graphassets.com/UZwUhRx6QZSjpl3OUiQ3"}}]}}

class AppData {
  AppData({
    this.mobileAppConfig,
  });

  AppData.fromJson(dynamic json) {
    mobileAppConfig = json['mobileAppConfig'] != null
        ? MobileAppConfig.fromJson(json['mobileAppConfig'])
        : null;
  }

  MobileAppConfig? mobileAppConfig;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (mobileAppConfig != null) {
      map['mobileAppConfig'] = mobileAppConfig?.toJson();
    }
    return map;
  }
}

/// introPageInfo : [{"subtitle":"NBFC, Licensed & Regulated by RBI","title":"India's No. 1 P2P Platform","type":"Image","asset":{"url":"https://media.graphassets.com/6mPg7LX3TmV5SSSBTb3Q","fileName":"intro1.png"}},{"subtitle":"Intro slide 2 subtitle","title":"Intro slide 2","type":"Video","asset":{"url":"https://media.graphassets.com/3clsbtAVRfCyFM2eBhN4","fileName":"intro2.mp4"}},{"subtitle":"Earn up to 10.5% returns on your investment","title":"100% Investors have made money","type":"Image","asset":{"url":"https://media.graphassets.com/4bUJOkqQaG6B2tExiiUF","fileName":"intro3.png"}}]
/// appVersions : {"ios":{"version":"1.0.4","storeUrl":"https://apps.apple.com/in/app/liquimoney/id1612622624","changeLog":[],"buildNumber":"47","forceUpdate":true},"android":{"version":"1.1.8","storeUrl":"https://play.google.com/store/apps/details?id=com.liquimoney","changeLog":[],"buildNumber":"42","forceUpdate":true}}
/// appUpdateMessage : "Update Required\nAn update to LiquiMoney is required to continue"
/// fdRoi : 7
/// kycStatusMapping : null
/// netWorthCertificateMessage : "*T&C Apply\nRBI requirement: networth certificate for >10 lakh investments"
/// referralMessage : "Hey! Come check out LiquiLoans investment app where you can earn upto 10.5% returns! Click this link & download the app now to start investing!"
/// roiSourceMessage : "*Source : Avg rates are taken by the top banks of India"
/// savingRoi : 2.5
/// showSip : true
/// splashPageMedia : {"subtitle":"Show this icon on splash page","title":"Splash Image","asset":{"url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r","fileName":"splash.png"}}
/// investBanner : {"fileName":"promo_text.png","url":"https://media.graphassets.com/fjws3XpRT4S0FnSlP1RQ"}
/// loginPageInfo : {"title":"Welcome","subtitle":"Earn upto 10.5%* returns","asset":{"fileName":"splash.png","url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r"}}
/// signAgreementTnc : {"terms":{"title":"Terms","description":"Terms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to able by the terms of service in order to use the offered. Terms of service can also be merely a disclaimer, especially regarding the use of websites."},"conditions":{"title":"Conditions","description":"Violations of system or network security may result in civil or criminal liability. We will investigate such violations and prosecute users who are involved. You agree not to use any device, software or routine to interfere or attempt to interfere with the proper working of this website or any activity being conducted on Website. You agree, further not to use or attempt to use any engine, software, tool, agent or other device or mechanism including without limitation, browser, spiders, robots, avatars or intelligent agents to navigation or search this website on the search engine and search agents available from us on this Website."}}
/// paymentGateways : [{"title":"PayU","gatewayId":"PayU","logo":{"fileName":"payu.png","url":"https://media.graphassets.com/Wk6dDemQTBOM9KVDEXmm"}},{"title":"Paytm","gatewayId":"Paytm","logo":{"fileName":"paytm.png","url":"https://media.graphassets.com/YoOAYlgCRluCshyytkHz"}}]
/// transactionTabs : [{"title":"All","tabHeader":"Total Portfolio Value"},{"title":"Investment","tabHeader":"Total Invested Amount"},{"title":"Interest","tabHeader":"Total Interest Credited to your account"},{"title":"Withdraw","tabHeader":"Total Withdrawn Amount"}]
/// dashboardActions : {"title":"What’s in it for you","subtitle":"Know the benefits of having a LiquiMoney account","corouselItems":[{"title":"Slide 1","subtitle":"Slide 1 subtitle","imageLink":"lock-in","image":{"fileName":"slider1.png","url":"https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"}},{"title":"Slide 2","subtitle":"Slide 2 subtitle","imageLink":"lock-in","image":{"fileName":"slider2.png","url":"https://media.graphassets.com/jYzPV3kaRjKUDkRbixCQ"}},{"title":"Slide 3","subtitle":"Slide 3 subtitle","imageLink":"lock-in","image":{"fileName":"slider3.png","url":"https://media.graphassets.com/UZwUhRx6QZSjpl3OUiQ3"}}]}
///ifaData: {"stage":["12","123","123"], "prod":["12","123","123"]}
class MobileAppConfig {
  MobileAppConfig({
    this.introPageInfo,
    this.appVersions,
    this.appUpdateMessage,
    this.fdRoi,
    this.kycStatusMapping,
    this.netWorthCertificateMessage,
    this.referralMessage,
    this.roiSourceMessage,
    this.savingRoi,
    this.showSip,
    this.splashPageMedia,
    this.investBanner,
    this.loginPageInfo,
    this.signAgreementTnc,
    this.paymentGateways,
    this.transactionTabs,
    this.dashboardActions,
    this.ifaData,
    this.actionWidgetData,
    this.skipSchemesData,
    this.appIfaId,
  });

  MobileAppConfig.fromJson(dynamic json) {
    if (json['introPageInfo'] != null) {
      introPageInfo = [];
      json['introPageInfo'].forEach((v) {
        introPageInfo?.add(IntroPageInfo.fromJson(v));
      });
    }
    appVersions = json['appVersions'] != null
        ? AppVersions.fromJson(json['appVersions'])
        : null;
    appUpdateMessage = json['appUpdateMessage'];
    fdRoi = json['fdRoi'];
    kycStatusMapping = json['kycStatusMapping'];
    netWorthCertificateMessage = json['netWorthCertificateMessage'];
    referralMessage = json['referralMessage'];
    roiSourceMessage = json['roiSourceMessage'];
    savingRoi = json['savingRoi'];
    showSip = json['showSip'];
    splashPageMedia = json['splashPageMedia'] != null
        ? SplashPageMedia.fromJson(json['splashPageMedia'])
        : null;
    investBanner = json['investBanner'] != null
        ? InvestBanner.fromJson(json['investBanner'])
        : null;
    loginPageInfo = json['loginPageInfo'] != null
        ? LoginPageInfo.fromJson(json['loginPageInfo'])
        : null;
    signAgreementTnc = json['signAgreementTnc'] != null
        ? SignAgreementTnc.fromJson(json['signAgreementTnc'])
        : null;
    if (json['paymentGateways'] != null) {
      paymentGateways = [];
      json['paymentGateways'].forEach((v) {
        paymentGateways?.add(PaymentGateways.fromJson(v));
      });
    }
    if (json['transactionTabs'] != null) {
      transactionTabs = [];
      json['transactionTabs'].forEach((v) {
        transactionTabs?.add(TransactionTabs.fromJson(v));
      });
    }
    dashboardActions = json['dashboardActions'] != null
        ? DashboardActions.fromJson(json['dashboardActions'])
        : null;
    ifaData =
        json['ifaData'] != null ? IfaData.fromJson(json['ifaData']) : null;
    skipSchemesData = json['skipSchemes'] != null
        ? SkipSchemesData.fromJson(json['skipSchemes'])
        : null;
    if (json['actionWidgets'] != null) {
      actionWidgetData = [];
      json['actionWidgets'].forEach((v) {
        actionWidgetData?.add(ActionWidgetData.fromJson(v));
      });
    }
    appIfaId = json['appIfaId'];
  }

  List<IntroPageInfo>? introPageInfo;
  AppVersions? appVersions;
  String? appUpdateMessage;
  num? fdRoi;
  dynamic kycStatusMapping;
  String? netWorthCertificateMessage;
  String? referralMessage;
  String? roiSourceMessage;
  num? savingRoi;
  bool? showSip;
  SplashPageMedia? splashPageMedia;
  InvestBanner? investBanner;
  LoginPageInfo? loginPageInfo;
  SignAgreementTnc? signAgreementTnc;
  List<PaymentGateways>? paymentGateways;
  List<TransactionTabs>? transactionTabs;
  DashboardActions? dashboardActions;
  IfaData? ifaData;
  List<ActionWidgetData>? actionWidgetData;
  SkipSchemesData? skipSchemesData;
  String? appIfaId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (introPageInfo != null) {
      map['introPageInfo'] = introPageInfo?.map((v) => v.toJson()).toList();
    }
    if (appVersions != null) {
      map['appVersions'] = appVersions?.toJson();
    }
    map['appUpdateMessage'] = appUpdateMessage;
    map['fdRoi'] = fdRoi;
    map['kycStatusMapping'] = kycStatusMapping;
    map['netWorthCertificateMessage'] = netWorthCertificateMessage;
    map['referralMessage'] = referralMessage;
    map['roiSourceMessage'] = roiSourceMessage;
    map['savingRoi'] = savingRoi;
    map['showSip'] = showSip;
    if (splashPageMedia != null) {
      map['splashPageMedia'] = splashPageMedia?.toJson();
    }
    if (investBanner != null) {
      map['investBanner'] = investBanner?.toJson();
    }
    if (loginPageInfo != null) {
      map['loginPageInfo'] = loginPageInfo?.toJson();
    }
    if (signAgreementTnc != null) {
      map['signAgreementTnc'] = signAgreementTnc?.toJson();
    }
    if (paymentGateways != null) {
      map['paymentGateways'] = paymentGateways?.map((v) => v.toJson()).toList();
    }
    if (transactionTabs != null) {
      map['transactionTabs'] = transactionTabs?.map((v) => v.toJson()).toList();
    }
    if (dashboardActions != null) {
      map['dashboardActions'] = dashboardActions?.toJson();
    }
    if (ifaData != null) {
      map['ifaData'] = ifaData?.toJson();
    }
    if (skipSchemesData != null) {
      map['skipSchemes'] = skipSchemesData?.toJson();
    }
    if (actionWidgetData != null) {
      map['actionWidgets'] = actionWidgetData?.map((v) => v.toJson()).toList();
    }
    map['appIfaId'] = appIfaId;
    return map;
  }
}

/// title : "What’s in it for you"
/// subtitle : "Know the benefits of having a LiquiMoney account"
/// corouselItems : [{"title":"Slide 1","subtitle":"Slide 1 subtitle","imageLink":"lock-in","image":{"fileName":"slider1.png","url":"https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"}},{"title":"Slide 2","subtitle":"Slide 2 subtitle","imageLink":"lock-in","image":{"fileName":"slider2.png","url":"https://media.graphassets.com/jYzPV3kaRjKUDkRbixCQ"}},{"title":"Slide 3","subtitle":"Slide 3 subtitle","imageLink":"lock-in","image":{"fileName":"slider3.png","url":"https://media.graphassets.com/UZwUhRx6QZSjpl3OUiQ3"}}]

class DashboardActions {
  DashboardActions({
    this.title,
    this.subtitle,
    this.corouselItems,
  });

  DashboardActions.fromJson(dynamic json) {
    title = json['title'];
    subtitle = json['subtitle'];
    if (json['corouselItems'] != null) {
      corouselItems = [];
      json['corouselItems'].forEach((v) {
        corouselItems?.add(CorouselItems.fromJson(v));
      });
    }
  }

  String? title;
  String? subtitle;
  List<CorouselItems>? corouselItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle;
    if (corouselItems != null) {
      map['corouselItems'] = corouselItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// title : "Slide 1"
/// subtitle : "Slide 1 subtitle"
/// imageLink : "lock-in"
/// image : {"fileName":"slider1.png","url":"https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"}

class CorouselItems {
  CorouselItems({
    this.title,
    this.subtitle,
    this.imageLink,
    this.type,
    this.image,
    this.data,
  });

  CorouselItems.fromJson(dynamic json) {
    title = json['title'];
    subtitle = json['subtitle'];
    imageLink = json['imageLink'];
    type = json['type'];
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    data = json['data'];
  }

  String? title;
  String? subtitle;
  String? imageLink;
  String? type;
  Image? image;
  Map? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle;
    map['imageLink'] = imageLink;
    map['type'] = type;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['data'] = data;
    return map;
  }
}

/// fileName : "slider1.png"
/// url : "https://media.graphassets.com/y8vVH3yRzCRRkgesYgjF"

class Image {
  Image({
    this.fileName,
    this.url,
  });

  Image.fromJson(dynamic json) {
    fileName = json['fileName'];
    url = json['url'];
  }

  String? fileName;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = fileName;
    map['url'] = url;
    return map;
  }
}

/// title : "All"
/// tabHeader : "Total Portfolio Value"

class TransactionTabs {
  TransactionTabs({
    this.title,
    this.tabHeader,
  });

  TransactionTabs.fromJson(dynamic json) {
    title = json['title'];
    tabHeader = json['tabHeader'];
  }

  String? title;
  String? tabHeader;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['tabHeader'] = tabHeader;
    return map;
  }
}

/// title : "PayU"
/// gatewayId : "PayU"
/// logo : {"fileName":"payu.png","url":"https://media.graphassets.com/Wk6dDemQTBOM9KVDEXmm"}

class PaymentGateways {
  PaymentGateways({
    this.title,
    this.gatewayId,
    this.logo,
  });

  PaymentGateways.fromJson(dynamic json) {
    title = json['title'];
    gatewayId = json['gatewayId'];
    logo = json['logo'] != null ? Logo.fromJson(json['logo']) : null;
  }

  String? title;
  String? gatewayId;
  Logo? logo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['gatewayId'] = gatewayId;
    if (logo != null) {
      map['logo'] = logo?.toJson();
    }
    return map;
  }
}

/// fileName : "payu.png"
/// url : "https://media.graphassets.com/Wk6dDemQTBOM9KVDEXmm"

class Logo {
  Logo({
    this.fileName,
    this.url,
  });

  Logo.fromJson(dynamic json) {
    fileName = json['fileName'];
    url = json['url'];
  }

  String? fileName;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = fileName;
    map['url'] = url;
    return map;
  }
}

/// terms : {"title":"Terms","description":"Terms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to able by the terms of service in order to use the offered. Terms of service can also be merely a disclaimer, especially regarding the use of websites."}
/// conditions : {"title":"Conditions","description":"Violations of system or network security may result in civil or criminal liability. We will investigate such violations and prosecute users who are involved. You agree not to use any device, software or routine to interfere or attempt to interfere with the proper working of this website or any activity being conducted on Website. You agree, further not to use or attempt to use any engine, software, tool, agent or other device or mechanism including without limitation, browser, spiders, robots, avatars or intelligent agents to navigation or search this website on the search engine and search agents available from us on this Website."}

class SignAgreementTnc {
  SignAgreementTnc({
    this.terms,
    this.conditions,
  });

  SignAgreementTnc.fromJson(dynamic json) {
    terms = json['terms'] != null ? Terms.fromJson(json['terms']) : null;
    conditions = json['conditions'] != null
        ? Conditions.fromJson(json['conditions'])
        : null;
  }

  Terms? terms;
  Conditions? conditions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (terms != null) {
      map['terms'] = terms?.toJson();
    }
    if (conditions != null) {
      map['conditions'] = conditions?.toJson();
    }
    return map;
  }
}

/// title : "Conditions"
/// description : "Violations of system or network security may result in civil or criminal liability. We will investigate such violations and prosecute users who are involved. You agree not to use any device, software or routine to interfere or attempt to interfere with the proper working of this website or any activity being conducted on Website. You agree, further not to use or attempt to use any engine, software, tool, agent or other device or mechanism including without limitation, browser, spiders, robots, avatars or intelligent agents to navigation or search this website on the search engine and search agents available from us on this Website."

class Conditions {
  Conditions({
    this.title,
    this.description,
  });

  Conditions.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }

  String? title;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    return map;
  }
}

/// title : "Terms"
/// description : "Terms of service are the legal agreements between a service provider and a person who wants to use that service. The person must agree to able by the terms of service in order to use the offered. Terms of service can also be merely a disclaimer, especially regarding the use of websites."

class Terms {
  Terms({
    this.title,
    this.description,
  });

  Terms.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }

  String? title;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    return map;
  }
}

/// title : "Welcome"
/// subtitle : "Earn upto 10.5%* returns"
/// asset : {"fileName":"splash.png","url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r"}

class LoginPageInfo {
  LoginPageInfo({
    this.title,
    this.subtitle,
    this.asset,
  });

  LoginPageInfo.fromJson(dynamic json) {
    title = json['title'];
    subtitle = json['subtitle'];
    asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;
  }

  String? title;
  String? subtitle;
  Asset? asset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['subtitle'] = subtitle;
    if (asset != null) {
      map['asset'] = asset?.toJson();
    }
    return map;
  }
}

/// fileName : "promo_text.png"
/// url : "https://media.graphassets.com/fjws3XpRT4S0FnSlP1RQ"

class InvestBanner {
  InvestBanner({
    this.fileName,
    this.url,
  });

  InvestBanner.fromJson(dynamic json) {
    fileName = json['fileName'];
    url = json['url'];
  }

  String? fileName;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fileName'] = fileName;
    map['url'] = url;
    return map;
  }
}

/// subtitle : "Show this icon on splash page"
/// title : "Splash Image"
/// asset : {"url":"https://media.graphassets.com/aDcG34hQTrOmsBY8Zy3r","fileName":"splash.png"}

class SplashPageMedia {
  SplashPageMedia({
    this.subtitle,
    this.title,
    this.asset,
  });

  SplashPageMedia.fromJson(dynamic json) {
    subtitle = json['subtitle'];
    title = json['title'];
    asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;
  }

  String? subtitle;
  String? title;
  Asset? asset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subtitle'] = subtitle;
    map['title'] = title;
    if (asset != null) {
      map['asset'] = asset?.toJson();
    }
    return map;
  }
}

/// ios : {"version":"1.0.4","storeUrl":"https://apps.apple.com/in/app/liquimoney/id1612622624","changeLog":[],"buildNumber":"47","forceUpdate":true}
/// android : {"version":"1.1.8","storeUrl":"https://play.google.com/store/apps/details?id=com.liquimoney","changeLog":[],"buildNumber":"42","forceUpdate":true}

class AppVersions {
  AppVersions({
    this.ios,
    this.android,
  });

  AppVersions.fromJson(dynamic json) {
    ios = json['ios'] != null ? Ios.fromJson(json['ios']) : null;
    android =
        json['android'] != null ? Android.fromJson(json['android']) : null;
  }

  Ios? ios;
  Android? android;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (ios != null) {
      map['ios'] = ios?.toJson();
    }
    if (android != null) {
      map['android'] = android?.toJson();
    }
    return map;
  }
}

/// version : "1.1.8"
/// storeUrl : "https://play.google.com/store/apps/details?id=com.liquimoney"
/// changeLog : []
/// buildNumber : "42"
/// forceUpdate : true

class Android {
  Android({
    this.version,
    this.storeUrl,
    this.changeLog,
    this.buildNumber,
    this.forceUpdate,
  });

  Android.fromJson(dynamic json) {
    version = json['version'];
    storeUrl = json['storeUrl'];
    if (json['changeLog'] != null) {
      changeLog = [];
      json['changeLog'].forEach((v) {
        //changeLog?.add(Dynamic.fromJson(v));
      });
    }
    buildNumber = json['buildNumber'];
    forceUpdate = json['forceUpdate'];
  }

  String? version;
  String? storeUrl;
  List<dynamic>? changeLog;
  String? buildNumber;
  bool? forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['storeUrl'] = storeUrl;
    if (changeLog != null) {
      map['changeLog'] = changeLog?.map((v) => v.toJson()).toList();
    }
    map['buildNumber'] = buildNumber;
    map['forceUpdate'] = forceUpdate;
    return map;
  }
}

/// version : "1.0.4"
/// storeUrl : "https://apps.apple.com/in/app/liquimoney/id1612622624"
/// changeLog : []
/// buildNumber : "47"
/// forceUpdate : true

class Ios {
  Ios({
    this.version,
    this.storeUrl,
    this.changeLog,
    this.buildNumber,
    this.forceUpdate,
  });

  Ios.fromJson(dynamic json) {
    version = json['version'];
    storeUrl = json['storeUrl'];
    if (json['changeLog'] != null) {
      changeLog = [];
      json['changeLog'].forEach((v) {
        //changeLog?.add(Dynamic.fromJson(v));
      });
    }
    buildNumber = json['buildNumber'];
    forceUpdate = json['forceUpdate'];
  }

  String? version;
  String? storeUrl;
  List<dynamic>? changeLog;
  String? buildNumber;
  bool? forceUpdate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['version'] = version;
    map['storeUrl'] = storeUrl;
    if (changeLog != null) {
      map['changeLog'] = changeLog?.map((v) => v.toJson()).toList();
    }
    map['buildNumber'] = buildNumber;
    map['forceUpdate'] = forceUpdate;
    return map;
  }
}

/// subtitle : "NBFC, Licensed & Regulated by RBI"
/// title : "India's No. 1 P2P Platform"
/// type : "Image"
/// asset : {"url":"https://media.graphassets.com/6mPg7LX3TmV5SSSBTb3Q","fileName":"intro1.png"}

class IntroPageInfo {
  IntroPageInfo({
    this.subtitle,
    this.title,
    this.type,
    this.asset,
  });

  IntroPageInfo.fromJson(dynamic json) {
    subtitle = json['subtitle'];
    title = json['title'];
    type = json['type'];
    asset = json['asset'] != null ? Asset.fromJson(json['asset']) : null;
  }

  String? subtitle;
  String? title;
  String? type;
  Asset? asset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subtitle'] = subtitle;
    map['title'] = title;
    map['type'] = type;
    if (asset != null) {
      map['asset'] = asset?.toJson();
    }
    return map;
  }
}

/// url : "https://media.graphassets.com/6mPg7LX3TmV5SSSBTb3Q"
/// fileName : "intro1.png"

class Asset {
  Asset({
    this.url,
    this.fileName,
  });

  Asset.fromJson(dynamic json) {
    url = json['url'];
    fileName = json['fileName'];
  }

  String? url;
  String? fileName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    map['fileName'] = fileName;
    return map;
  }
}

///stage : ["12","123","123"]
///prod : ["12","123","123"]
class IfaData {
  IfaData({
    this.stage,
    this.prod,
  });

  IfaData.fromJson(dynamic json) {
    if (json['stage'] != null) {
      stage = [];
      json['stage'].forEach((v) {
        stage?.add(v);
      });
    }
    if (json['prod'] != null) {
      prod = [];
      json['prod'].forEach((v) {
        prod?.add(v);
      });
    }
  }

  List<String>? stage;
  List<String>? prod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stage != null) {
      map['stage'] = stage?.map((v) => v).toList();
    }
    if (prod != null) {
      map['prod'] = prod?.map((v) => v).toList();
    }
    return map;
  }
}

///stage : [12,123,123]
///prod : [12,123,123]
class SkipSchemesData {
  SkipSchemesData({
    this.stage,
    this.prod,
  });

  SkipSchemesData.fromJson(dynamic json) {
    if (json['stage'] != null) {
      stage = [];
      json['stage'].forEach((v) {
        stage?.add(v);
      });
    }
    if (json['prod'] != null) {
      prod = [];
      json['prod'].forEach((v) {
        prod?.add(v);
      });
    }
  }

  List<num>? stage;
  List<num>? prod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (stage != null) {
      map['stage'] = stage?.map((v) => v).toList();
    }
    if (prod != null) {
      map['prod'] = prod?.map((v) => v).toList();
    }
    return map;
  }
}

///"description": "Invest Funds", "deeplink": "invest-fund", "logo": { "fileName": "deposit_funds.png", "url": "https://media.graphassets.com/SZcubNXORQaE1csF62Dp" }, "title": "Invest Funds", "widgetScreen": "dashboard"
class ActionWidgetData {
  ActionWidgetData({
    this.title,
    this.description,
    this.deeplink,
    this.widgetScreen,
    this.logo,
    this.backgroundColor,
  });

  ActionWidgetData.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    deeplink = json['deeplink'];
    widgetScreen = json['widgetScreen'];
    logo = json['logo'] != null ? Image.fromJson(json['logo']) : null;
    backgroundColor = json['backgroundColor'] != null
        ? BackgroundColorData.fromJson(json['backgroundColor'])
        : null;
  }

  String? title;
  String? description;
  String? deeplink;
  String? widgetScreen;
  Image? logo;
  BackgroundColorData? backgroundColor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['deeplink'] = deeplink;
    map['widgetScreen'] = widgetScreen;
    if (logo != null) {
      map['logo'] = logo?.toJson();
    }
    if (backgroundColor != null) {
      map['backgroundColor'] = backgroundColor?.toJson();
    }
    return map;
  }
}

/// hex : "#e3faff"

class BackgroundColorData {
  BackgroundColorData({
    this.hex,
  });

  BackgroundColorData.fromJson(dynamic json) {
    hex = json['hex'];
  }

  String? hex;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['hex'] = hex;
    return map;
  }
}
