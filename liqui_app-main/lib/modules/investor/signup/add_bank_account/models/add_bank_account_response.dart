/// status : true
/// message : "Banking created successfully"
/// data : {"banking_id":373968,"name_match_percent":40}
/// code : 200

class AddBankAccountResponse {
  AddBankAccountResponse({
    this.status,
    this.message,
    this.data,
    this.code,});

  AddBankAccountResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : AddBankAccountModel.fromJson(json['data'])
        : null;

    code = json['code'];
  }
  bool? status;
  String? message;
  AddBankAccountModel? data;
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

/// banking_id : 373968
/// name_match_percent : 40

class AddBankAccountModel {
  AddBankAccountModel({
    this.bankingId,
    this.nameMatchPercent,});

  AddBankAccountModel.fromJson(dynamic json) {
    bankingId = json['banking_id'];
    nameMatchPercent = json['name_match_percent'];
  }
  num? bankingId;
  num? nameMatchPercent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banking_id'] = bankingId;
    map['name_match_percent'] = nameMatchPercent;
    return map;
  }

}
