/// status : true
/// message : "Investment Schedule."
/// schemeReturnData : {"AccruedValue":50430.7214,"PrincipalAmount":"50000","InterestAmount":430.7214,"MaturityDate":"2023-03-18","Tenure":"1M"}
/// code : 200

class GetReturnsResponse {
  GetReturnsResponse({
      this.status, 
      this.message, 
      this.schemeReturnData, 
      this.code,});

  GetReturnsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    schemeReturnData = json['data'] != null
        ? json['data'] is List
        ? null
        : SchemeReturnData.fromJson(json['data']):null;
    code = json['code'];
  }
  bool? status;
  String? message;
  SchemeReturnData? schemeReturnData;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (schemeReturnData != null) {
      map['data'] = schemeReturnData?.toJson();
    }
    map['code'] = code;
    return map;
  }

}

/// AccruedValue : 50430.7214
/// PrincipalAmount : "50000"
/// InterestAmount : 430.7214
/// MaturityDate : "2023-03-18"
/// Tenure : "1M"

class SchemeReturnData {
  SchemeReturnData({
      this.accruedValue, 
      this.principalAmount, 
      this.interestAmount, 
      this.maturityDate, 
      this.tenure,});

  SchemeReturnData.fromJson(dynamic json) {
    accruedValue = json['AccruedValue'];
    principalAmount = json['PrincipalAmount'];
    interestAmount = json['InterestAmount'];
    maturityDate = json['MaturityDate'];
    tenure = json['Tenure'];
  }
  num? accruedValue;
  String? principalAmount;
  num? interestAmount;
  String? maturityDate;
  String? tenure;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['AccruedValue'] = accruedValue;
    map['PrincipalAmount'] = principalAmount;
    map['InterestAmount'] = interestAmount;
    map['MaturityDate'] = maturityDate;
    map['Tenure'] = tenure;
    return map;
  }

}