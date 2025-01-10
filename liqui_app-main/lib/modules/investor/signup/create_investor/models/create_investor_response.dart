
class CreateInvestorResponse {
  CreateInvestorResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  CreateInvestorResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : CreateInvestorModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  CreateInvestorModel? data;
  int? code;

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

class CreateInvestorModel {
  CreateInvestorModel({
    this.investorId,
    this.nIfaId,
    this.bankingId,
    this.token,
  });

  CreateInvestorModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    nIfaId = json['ifa_id'];
    bankingId = json['banking_id'];
    token = json['token'];
  }

  int? investorId;
  dynamic nIfaId;
  String get ifaId => nIfaId.toString();
  dynamic bankingId;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['ifa_id'] = nIfaId;
    map['banking_id'] = bankingId;
    map['token'] = token;
    return map;
  }
}
