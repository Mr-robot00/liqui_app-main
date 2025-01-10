/// status : false
/// message : "Please wait for 31 seconds"
/// data : {"otp_time":31}
/// code : 400

class SendOtpResponse {
  SendOtpResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  SendOtpResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    //data = json['data'] != null ? Data.fromJson(json['data']) : null;
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : SendOtpData.fromJson(json['data'])
        : null;
    code = json['code'];
  }
  bool? status;
  String? message;
  SendOtpData? data;
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

/// otp_time : 31

class SendOtpData {
  SendOtpData({
      this.otpTime,});

  SendOtpData.fromJson(dynamic json) {
    otpTime = json['otp_time'];
  }
  num? otpTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp_time'] = otpTime;
    return map;
  }

}