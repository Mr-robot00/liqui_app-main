class InvestorSchemeResponse {
  InvestorSchemeResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  InvestorSchemeResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(InvestorSchemeData.fromJson(v));
      });
    }
    code = json['code'];
  }
  bool? status;
  String? message;
  List<InvestorSchemeData>? data;
  num? code;

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

class InvestorSchemeData {
  InvestorSchemeData({
    this.schemeId,
    this.schemeType,
    this.investmentType,
    this.interestCalculationType,
    this.roi,
    this.lockinMonth,
    this.lockinBreak,
    this.chargeType,
    this.mhpDisplay,
    this.lockinAmountType,
    this.lockinType,
    this.invPayoutType,
    this.payoutDay,
    this.defaultSchemeId,
    this.startAmount,
    this.endAmount,
    this.nextSchemeId,
    this.prevSchemeId,
    this.status,
    this.defaultScheme,
    this.schemeFor,
    this.displayScheme,
    this.doubleAdvantageScheme,
    this.schemeName,
    this.qualityId,
    this.qualityValue,
  });

  InvestorSchemeData.fromJson(dynamic json) {
    schemeId = json['scheme_id'];
    schemeType = json['scheme_type'];
    investmentType = json['investment_type'];
    interestCalculationType = json['interest_calculation_type'];
    roi = json['roi'];
    lockinMonth = json['lockin_month'];
    lockinBreak = json['lockin_break'];
    chargeType = json['charge_type'];
    mhpDisplay = json['mhp_display'];
    lockinAmountType = json['lockin_amount_type'];
    lockinType = json['lockin_type'];
    invPayoutType = json['inv_payout_type'];
    payoutDay = json['payout_day'];
    defaultSchemeId = json['default_scheme_id'];
    startAmount = json['start_amount'];
    endAmount = json['end_amount'];
    nextSchemeId = json['next_scheme_id'];
    prevSchemeId = json['prev_scheme_id'];
    status = json['status'];
    defaultScheme = json['default_scheme'];
    schemeFor = json['scheme_for'];
    displayScheme = json['display_scheme'];
    doubleAdvantageScheme = json['double_advantage_scheme'];
    schemeName = json['scheme_name'];
    qualityId = json['quality_id'];
    qualityValue = json['quality_value'];
  }
  num? schemeId;
  String? schemeType;
  String? investmentType;
  String? interestCalculationType;
  num? roi;
  num? lockinMonth;
  dynamic lockinBreak;
  dynamic chargeType;
  String? mhpDisplay;
  String? lockinAmountType;
  String? lockinType;
  String? invPayoutType;
  num? payoutDay;
  dynamic defaultSchemeId;
  num? startAmount;
  num? endAmount;
  num? nextSchemeId;
  num? prevSchemeId;
  String? status;
  String? defaultScheme;
  String? schemeFor;
  String? displayScheme;
  String? doubleAdvantageScheme;
  String? schemeName;
  int? qualityId;
  String? qualityValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_id'] = schemeId;
    map['scheme_type'] = schemeType;
    map['investment_type'] = investmentType;
    map['interest_calculation_type'] = interestCalculationType;
    map['roi'] = roi;
    map['lockin_month'] = lockinMonth;
    map['lockin_break'] = lockinBreak;
    map['charge_type'] = chargeType;
    map['mhp_display'] = mhpDisplay;
    map['lockin_amount_type'] = lockinAmountType;
    map['lockin_type'] = lockinType;
    map['inv_payout_type'] = invPayoutType;
    map['payout_day'] = payoutDay;
    map['default_scheme_id'] = defaultSchemeId;
    map['start_amount'] = startAmount;
    map['end_amount'] = endAmount;
    map['next_scheme_id'] = nextSchemeId;
    map['prev_scheme_id'] = prevSchemeId;
    map['status'] = status;
    map['default_scheme'] = defaultScheme;
    map['scheme_for'] = schemeFor;
    map['display_scheme'] = displayScheme;
    map['double_advantage_scheme'] = doubleAdvantageScheme;
    map['scheme_name'] = schemeName;
    map['quality_id'] = schemeName;
    map['quality_value'] = schemeName;
    return map;
  }
}
