class VerifySignInOtpResponse {
  VerifySignInOtpResponse({
    this.status,
    this.message,
    this.data,
  });

  VerifySignInOtpResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
            ? null
            : VerifySignInOtpModel.fromJson(json['data'])
        : null;
  }

  bool? status;
  String? message;
  VerifySignInOtpModel? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class VerifySignInOtpModel {
  VerifySignInOtpModel({
    this.redirectUrl,
    this.token,
  });

  VerifySignInOtpModel.fromJson(dynamic json) {
    redirectUrl = json['redirect_url'];
    token = json['token'];
  }

  String? redirectUrl;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['redirect_url'] = redirectUrl;
    map['token'] = token;
    return map;
  }
}
