/// status : true
/// message : "App version data"
/// data : {"ios_version_no":"1.0.2","android_version_no":"1.0.3","ios_version_name":"ios 1.2.0","android_version_name":"and 1.2.0","android_force":"True","ios_force":"False","android_url":"www.andriodlocal.com","ios_url":"www.ioslocal.com","id":5}
/// code : 200

class AppVersionResponse {
  AppVersionResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  AppVersionResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : AppVersionData.fromJson(json['data'])
        : null;
    code = json['code'];
  }
  bool? status;
  String? message;
  AppVersionData? data;
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

/// ios_version_no : "1.0.2"
/// android_version_no : "1.0.3"
/// ios_version_name : "ios 1.2.0"
/// android_version_name : "and 1.2.0"
/// android_force : "True"
/// ios_force : "False"
/// android_url : "www.andriodlocal.com"
/// ios_url : "www.ioslocal.com"
/// id : 5

class AppVersionData {
  AppVersionData({
      this.iosVersionNo, 
      this.androidVersionNo, 
      this.iosVersionName, 
      this.androidVersionName, 
      this.androidForce, 
      this.iosForce, 
      this.androidUrl, 
      this.iosUrl, 
      this.id,});

  AppVersionData.fromJson(dynamic json) {
    iosVersionNo = json['ios_version_no'];
    androidVersionNo = json['android_version_no'];
    iosVersionName = json['ios_version_name'];
    androidVersionName = json['android_version_name'];
    androidForce = json['android_force'];
    iosForce = json['ios_force'];
    androidUrl = json['android_url'];
    iosUrl = json['ios_url'];
    id = json['id'];
  }
  String? iosVersionNo;
  String? androidVersionNo;
  String? iosVersionName;
  String? androidVersionName;
  String? androidForce;
  String? iosForce;
  String? androidUrl;
  String? iosUrl;
  num? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ios_version_no'] = iosVersionNo;
    map['android_version_no'] = androidVersionNo;
    map['ios_version_name'] = iosVersionName;
    map['android_version_name'] = androidVersionName;
    map['android_force'] = androidForce;
    map['ios_force'] = iosForce;
    map['android_url'] = androidUrl;
    map['ios_url'] = iosUrl;
    map['id'] = id;
    return map;
  }

}