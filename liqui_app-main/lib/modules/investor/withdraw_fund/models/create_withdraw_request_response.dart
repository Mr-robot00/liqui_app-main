/// status : true
/// message : "You have placed a request for sale of loans, you shall be notified on successful sale of loans and amount will remitted to the bank account within 48 working hrs of sale confirmation."
/// data : {"investor_id":"364455","amount":1,"transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","approval_status":"Progress","transaction_id":null,"transaction_source":"InvestorDash","transaction_date":"2023-02-02T10:51:50.842247Z","banking_date":null,"banking_id":365496,"ext_transaction_date":null,"dpv_as_on_request":1030839.7,"tpv_as_on_request":944872.8125,"tpv_interest_as_on_request":0,"withdrawal_method":"Auto","manual_parameters":"null","created_by":535396,"reason_id":0,"updated_by":535396,"created_at":"2023-02-02 16:21:50","updated_at":"2023-02-02 16:21:50","id":10961579,"otp_verification":true,"email_notification":"Yes","mobile_notification":"Yes","link_token":"63db95c6de78c"}
/// code : 200

class CreateWithdrawRequestResponse {
  CreateWithdrawRequestResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  CreateWithdrawRequestResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : CreateWithdrawRequestModel.fromJson(json['data'])
        : null;

    code = json['code'];
  }
  bool? status;
  String? message;
  CreateWithdrawRequestModel? data;
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

/// investor_id : "364455"
/// amount : 1
/// transaction_type : "Debit"
/// transaction_sub_type : "WithdrawMoney"
/// approval_status : "Progress"
/// transaction_id : null
/// transaction_source : "InvestorDash"
/// transaction_date : "2023-02-02T10:51:50.842247Z"
/// banking_date : null
/// banking_id : 365496
/// ext_transaction_date : null
/// dpv_as_on_request : 1030839.7
/// tpv_as_on_request : 944872.8125
/// tpv_interest_as_on_request : 0
/// withdrawal_method : "Auto"
/// manual_parameters : "null"
/// created_by : 535396
/// reason_id : 0
/// updated_by : 535396
/// created_at : "2023-02-02 16:21:50"
/// updated_at : "2023-02-02 16:21:50"
/// id : 10961579
/// otp_verification : true
/// email_notification : "Yes"
/// mobile_notification : "Yes"
/// link_token : "63db95c6de78c"

class CreateWithdrawRequestModel {
  CreateWithdrawRequestModel({
    this.investorId,
    this.amount,
    this.transactionType,
    this.transactionSubType,
    this.approvalStatus,
    this.transactionId,
    this.transactionSource,
    this.transactionDate,
    this.bankingDate,
    this.bankingId,
    this.extTransactionDate,
    this.dpvAsOnRequest,
    this.tpvAsOnRequest,
    this.tpvInterestAsOnRequest,
    this.withdrawalMethod,
    this.manualParameters,
    this.createdBy,
    this.reasonId,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.otpVerification,
    this.emailNotification,
    this.mobileNotification,
    this.linkToken,
  });

  CreateWithdrawRequestModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    amount = json['amount'];
    transactionType = json['transaction_type'];
    transactionSubType = json['transaction_sub_type'];
    approvalStatus = json['approval_status'];
    transactionId = json['transaction_id'];
    transactionSource = json['transaction_source'];
    transactionDate = json['transaction_date'];
    bankingDate = json['banking_date'];
    bankingId = json['banking_id'];
    extTransactionDate = json['ext_transaction_date'];
    dpvAsOnRequest = json['dpv_as_on_request'];
    tpvAsOnRequest = json['tpv_as_on_request'];
    tpvInterestAsOnRequest = json['tpv_interest_as_on_request'];
    withdrawalMethod = json['withdrawal_method'];
    manualParameters = json['manual_parameters'];
    createdBy = json['created_by'];
    reasonId = json['reason_id'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    otpVerification = json['otp_verification'];
    emailNotification = json['email_notification'];
    mobileNotification = json['mobile_notification'];
    linkToken = json['link_token'];
  }
  String? investorId;
  String? amount;
  String? transactionType;
  String? transactionSubType;
  String? approvalStatus;
  dynamic transactionId;
  String? transactionSource;
  String? transactionDate;
  dynamic bankingDate;
  num? bankingId;
  dynamic extTransactionDate;
  num? dpvAsOnRequest;
  num? tpvAsOnRequest;
  num? tpvInterestAsOnRequest;
  String? withdrawalMethod;
  String? manualParameters;
  num? createdBy;
  num? reasonId;
  num? updatedBy;
  String? createdAt;
  String? updatedAt;
  num? id;
  bool? otpVerification;
  String? emailNotification;
  String? mobileNotification;
  String? linkToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['amount'] = amount;
    map['transaction_type'] = transactionType;
    map['transaction_sub_type'] = transactionSubType;
    map['approval_status'] = approvalStatus;
    map['transaction_id'] = transactionId;
    map['transaction_source'] = transactionSource;
    map['transaction_date'] = transactionDate;
    map['banking_date'] = bankingDate;
    map['banking_id'] = bankingId;
    map['ext_transaction_date'] = extTransactionDate;
    map['dpv_as_on_request'] = dpvAsOnRequest;
    map['tpv_as_on_request'] = tpvAsOnRequest;
    map['tpv_interest_as_on_request'] = tpvInterestAsOnRequest;
    map['withdrawal_method'] = withdrawalMethod;
    map['manual_parameters'] = manualParameters;
    map['created_by'] = createdBy;
    map['reason_id'] = reasonId;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['id'] = id;
    map['otp_verification'] = otpVerification;
    map['email_notification'] = emailNotification;
    map['mobile_notification'] = mobileNotification;
    map['link_token'] = linkToken;
    return map;
  }
}
