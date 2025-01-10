/// status : true
/// message : "CKyc fetched successfully."
/// data : {"CKYC_NO":"50091397548594","NAME":"Mr wesa asdwq Shaikh ","KYC_DATE":"10-05-2023"}
/// code : 200

class VerifyCKYCResponse {
  bool? status;
  String? message;
  CKYCModel? ckycData;
  num? code;

  VerifyCKYCResponse({
    this.status,
    this.message,
    this.ckycData,
    this.code,
  });

  VerifyCKYCResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    ckycData = json['data'] != null
        ? json['data'] is List
            ? null
            : CKYCModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (ckycData != null) {
      map['data'] = ckycData?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// CKYC_NO : "50091397548594"
/// NAME : "Mr wesa asdwq Shaikh "
/// KYC_DATE : "10-05-2023"

class CKYCModel {
  String? ckycno;
  String? name;
  String? kycdate;

  CKYCModel({
    this.ckycno,
    this.name,
    this.kycdate,
  });

  CKYCModel.fromJson(dynamic json) {
    ckycno = json['CKYC_NO'];
    name = json['NAME'];
    kycdate = json['KYC_DATE'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CKYC_NO'] = ckycno;
    map['NAME'] = name;
    map['KYC_DATE'] = kycdate;
    return map;
  }
}
