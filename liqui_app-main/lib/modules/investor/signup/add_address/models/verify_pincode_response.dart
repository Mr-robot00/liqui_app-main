/// status : true
/// message : "Pincode verified."
/// data : {"id":5480,"pin_code":"400065","sub_district":"MUMBAI","district":"MUMBAI","state":"MAHARASHTRA"}
/// code : 200

class VerifyPinCodeResponse {
  VerifyPinCodeResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  VerifyPinCodeResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];

    data = json['data'] != null
        ? json['data'] is List
        ? null
        : VerifyPinCodeModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }
  bool? status;
  String? message;
  VerifyPinCodeModel? data;
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

/// id : 5480
/// pin_code : "400065"
/// sub_district : "MUMBAI"
/// district : "MUMBAI"
/// state : "MAHARASHTRA"

class VerifyPinCodeModel {
  VerifyPinCodeModel({
      this.id, 
      this.pinCode, 
      this.subDistrict, 
      this.district, 
      this.state,});

  VerifyPinCodeModel.fromJson(dynamic json) {
    id = json['id'];
    pinCode = json['pin_code'];
    subDistrict = json['sub_district'];
    district = json['district'];
    state = json['state'];
  }
  num? id;
  String? pinCode;
  String? subDistrict;
  String? district;
  String? state;
VerifyPinCodeModel copyWith({  num? id,
  String? pinCode,
  String? subDistrict,
  String? district,
  String? state,
}) => VerifyPinCodeModel(  id: id ?? this.id,
  pinCode: pinCode ?? this.pinCode,
  subDistrict: subDistrict ?? this.subDistrict,
  district: district ?? this.district,
  state: state ?? this.state,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pin_code'] = pinCode;
    map['sub_district'] = subDistrict;
    map['district'] = district;
    map['state'] = state;
    return map;
  }

}