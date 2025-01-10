/// status : true
/// message : "Bank account number verified."
/// data : {"accountNumber":"054101506351","ifsc":"ICIC0000541","accountName":"ANIL PRAKASH SAINI  ","bankResponse":"Transaction Successful","bankTxnStatus":true}
/// code : 200

class VerifyBankResponse {
  VerifyBankResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  VerifyBankResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : VerifyBankModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }
  bool? status;
  String? message;
  VerifyBankModel? data;
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

/// accountNumber : "054101506351"
/// ifsc : "ICIC0000541"
/// accountName : "ANIL PRAKASH SAINI  "
/// bankResponse : "Transaction Successful"
/// bankTxnStatus : true

class VerifyBankModel {
  VerifyBankModel({
      this.accountNumber, 
      this.ifsc, 
      this.accountName, 
      this.bankResponse, 
      this.bankTxnStatus,});

  VerifyBankModel.fromJson(dynamic json) {
    accountNumber = json['accountNumber'];
    ifsc = json['ifsc'];
    accountName = json['accountName'];
    bankResponse = json['bankResponse'];
    bankTxnStatus = json['bankTxnStatus'];
  }
  String? accountNumber;
  String? ifsc;
  String? accountName;
  String? bankResponse;
  bool? bankTxnStatus;
VerifyBankModel copyWith({  String? accountNumber,
  String? ifsc,
  String? accountName,
  String? bankResponse,
  bool? bankTxnStatus,
}) => VerifyBankModel(  accountNumber: accountNumber ?? this.accountNumber,
  ifsc: ifsc ?? this.ifsc,
  accountName: accountName ?? this.accountName,
  bankResponse: bankResponse ?? this.bankResponse,
  bankTxnStatus: bankTxnStatus ?? this.bankTxnStatus,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountNumber'] = accountNumber;
    map['ifsc'] = ifsc;
    map['accountName'] = accountName;
    map['bankResponse'] = bankResponse;
    map['bankTxnStatus'] = bankTxnStatus;
    return map;
  }

}