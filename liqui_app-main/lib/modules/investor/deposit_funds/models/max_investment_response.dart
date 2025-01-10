/// status : true
/// message : "Investor Max Investment Amount Calculated"
/// data : {"investor_id":"373778","max_investment_allowed":4980211}
/// code : 200

class MinMaxInvestmentResponse {
  MinMaxInvestmentResponse({
    this.status,
    this.message,
    this.minMaxInvestment,
    this.code,
  });

  MinMaxInvestmentResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    minMaxInvestment = json['data'] != null
        ? json['data'] is List
            ? null
            : MinMaxInvestmentModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  MinMaxInvestmentModel? minMaxInvestment;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (minMaxInvestment != null) {
      map['data'] = minMaxInvestment?.toJson();
    }

    map['code'] = code;
    return map;
  }
}

/// investor_id : "373778"
/// max_investment_allowed : 4980211
/// min_investment_allowed : 2000

class MinMaxInvestmentModel {
  MinMaxInvestmentModel({
    this.investorId,
    this.maxInvestmentAllowed,
    this.minInvestmentAllowed,
  });

  MinMaxInvestmentModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    maxInvestmentAllowed = json['max_investment_allowed'];
    minInvestmentAllowed = json['min_investment_allowed'];
  }

  String? investorId;
  num? maxInvestmentAllowed;
  num? minInvestmentAllowed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['max_investment_allowed'] = maxInvestmentAllowed;
    map['min_investment_allowed'] = minInvestmentAllowed;
    return map;
  }
}
