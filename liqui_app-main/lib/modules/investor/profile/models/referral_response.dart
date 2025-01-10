/// status : true
/// message : "Referral url fetched successfully"
/// data : {"app_referral_url": "https://liquimoney.test-app.link/MDAwNzQxMTAy","referral_url":"https://staging-web-front-v2.liquiloan.in/investor/register/MDAwNzQxMzM2","referral_code":"MDAwNzQxMzM2"}
/// code : 200

class ReferralResponse {
  ReferralResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  ReferralResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
            ? null
            : Data.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  Data? data;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

///"app_referral_url": "https://liquimoney.test-app.link/MDAwNzQxMTAy"
/// referral_url : "https://staging-web-front-v2.liquiloan.in/investor/register/MDAwNzQxMzM2"
/// referral_code : "MDAwNzQxMzM2"

class Data {
  Data({
    this.appReferralUrl,
    this.referralUrl,
    this.referralCode,
  });

  Data.fromJson(dynamic json) {
    appReferralUrl = json['app_referral_url'];
    referralUrl = json['referral_url'];
    referralCode = json['referral_code'];
  }

  String? appReferralUrl;
  String? referralUrl;
  String? referralCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['app_referral_url'] = appReferralUrl;
    map['referral_url'] = referralUrl;
    map['referral_code'] = referralCode;
    return map;
  }
}
