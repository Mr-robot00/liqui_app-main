import 'dart:convert';

class BankAccountsResponse {
  BankAccountsResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  BankAccountsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(BankAccountModel.fromJson(v));
      });
    }
    code = json['code'];
  }
  bool? status;
  String? message;
  List<BankAccountModel>? data;
  num? code;
  BankAccountsResponse copyWith({
    bool? status,
    String? message,
    List<BankAccountModel>? data,
    num? code,
  }) =>
      BankAccountsResponse(
        status: status ?? this.status,
        message: message ?? this.message,
        data: data ?? this.data,
        code: code ?? this.code,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    return map;
  }
}

class BankAccountModel {
  BankAccountModel({
    this.id,
    this.accountType,
    this.bankName,
    this.branchName,
    this.ifsc,
    this.accountNumber,
    this.accountHolderName,
    this.isDefault,
    this.status,
    this.kycStatus,
    this.createdAt,
  });

  BankAccountModel.fromJson(dynamic json) {
    id = json['id'];
    accountType = json['account_type'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    ifsc = json['ifsc'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    isDefault = json['is_default'];
    status = json['status'];
    kycStatus = json['kyc_status'];
    createdAt = json['created_at'];
  }
  num? id;
  String? accountType;
  String? bankName;
  String? branchName;
  String? ifsc;
  String? accountNumber;
  String? accountHolderName;
  String? isDefault;
  String? status;
  String? kycStatus;
  String? createdAt;

  BankAccountModel copyWith({
    num? id,
    String? accountType,
    String? bankName,
    String? branchName,
    String? ifsc,
    String? accountNumber,
    String? accountHolderName,
    String? isDefault,
    String? status,
    String? kycStatus,
    String? createdAt,
  }) =>
      BankAccountModel(
        id: id ?? this.id,
        accountType: accountType ?? this.accountType,
        bankName: bankName ?? this.bankName,
        branchName: branchName ?? this.branchName,
        ifsc: ifsc ?? this.ifsc,
        accountNumber: accountNumber ?? this.accountNumber,
        accountHolderName: accountHolderName ?? this.accountHolderName,
        isDefault: isDefault ?? this.isDefault,
        status: status ?? this.status,
        kycStatus: kycStatus ?? this.kycStatus,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['account_type'] = accountType;
    map['bank_name'] = bankName;
    map['branch_name'] = branchName;
    map['ifsc'] = ifsc;
    map['account_number'] = accountNumber;
    map['account_holder_name'] = accountHolderName;
    map['is_default'] = isDefault;
    map['status'] = status;
    map['kyc_status'] = kycStatus;
    map['created_at'] = createdAt;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
