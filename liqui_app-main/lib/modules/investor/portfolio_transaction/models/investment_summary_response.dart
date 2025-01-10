/// status : true
/// message : "Investment summary fetched successfully"
/// data : {"scheme_wise_data":[{"scheme_id":685,"scheme_name":685,"display_scheme":"12.00%","investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","invested_amount":168000,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0,"investment_summary":[{"transaction_id":105323142,"investor_id":1,"transaction_date":"2023-07-09","invested_amount":168000,"balance_principal":168000,"balance_interest":0,"scheme_id":685,"scheme_name":685,"investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"maturity_start_date":"2023-07-09","maturity_end_date":"2024-07-09","transaction_sub_type":"Reinvestment","investment_status":"Approved","parent_investment_id":91268821,"master_parent_investment_id":91268821,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"redeemed_interest_with_request":0,"name":"Sunil Lalmani Jaiswar","display_scheme":"12.00%","scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","lockin_end_date":null,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0}]}],"investment_wise_data":[{"transaction_id":105323142,"investor_id":1,"transaction_date":"2023-07-09","invested_amount":168000,"balance_principal":168000,"balance_interest":0,"scheme_id":685,"scheme_name":685,"investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"maturity_start_date":"2023-07-09","maturity_end_date":"2024-07-09","transaction_sub_type":"Reinvestment","investment_status":"Approved","parent_investment_id":91268821,"master_parent_investment_id":91268821,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"redeemed_interest_with_request":0,"name":"Sunil Lalmani Jaiswar","display_scheme":"12.00%","scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","lockin_end_date":null,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0}],"total_summary":{"investor_id":1,"name":"Sunil Lalmani Jaiswar","family_role":"Master","dashboard_summary":{"withdrawable_balance":168052.17,"flexi_lockin_withdrawable_balance":0,"portfolio_value":168052.17,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":168052.17,"net_principal_investment":168000,"original_npi":150000,"total_investment":1459600,"total_redemption":1391889.75,"total_interest":100341.93,"redeemed_interest":82289.76,"accrued_interest":52.17,"capitalised_interest":18000,"total_capitalised":18000,"redeemed_principal":1309599.99,"absolute_return":52.17,"absolute_return_xiir":0.03,"annualized_return_xiir":12.67,"locked_withdrawable_balance":0,"display_flag":"DPV"}}}
/// code : 200

class InvestmentSummaryResponse {
  InvestmentSummaryResponse({
    this.status,
    this.message,
    this.investmentSummary,
    this.code,
  });

  InvestmentSummaryResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    investmentSummary = json['data'] != null
        ? json['data'] is List
            ? null
            : InvestmentSummaryData.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  InvestmentSummaryData? investmentSummary;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (investmentSummary != null) {
      map['data'] = investmentSummary?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// scheme_wise_data : [{"scheme_id":685,"scheme_name":685,"display_scheme":"12.00%","investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","invested_amount":168000,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0,"investment_summary":[{"transaction_id":105323142,"investor_id":1,"transaction_date":"2023-07-09","invested_amount":168000,"balance_principal":168000,"balance_interest":0,"scheme_id":685,"scheme_name":685,"investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"maturity_start_date":"2023-07-09","maturity_end_date":"2024-07-09","transaction_sub_type":"Reinvestment","investment_status":"Approved","parent_investment_id":91268821,"master_parent_investment_id":91268821,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"redeemed_interest_with_request":0,"name":"Sunil Lalmani Jaiswar","display_scheme":"12.00%","scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","lockin_end_date":null,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0}]}]
/// investment_wise_data : [{"transaction_id":105323142,"investor_id":1,"transaction_date":"2023-07-09","invested_amount":168000,"balance_principal":168000,"balance_interest":0,"scheme_id":685,"scheme_name":685,"investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"maturity_start_date":"2023-07-09","maturity_end_date":"2024-07-09","transaction_sub_type":"Reinvestment","investment_status":"Approved","parent_investment_id":91268821,"master_parent_investment_id":91268821,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"redeemed_interest_with_request":0,"name":"Sunil Lalmani Jaiswar","display_scheme":"12.00%","scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","lockin_end_date":null,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0}]
/// total_summary : {"investor_id":1,"name":"Sunil Lalmani Jaiswar","family_role":"Master","dashboard_summary":{"withdrawable_balance":168052.17,"flexi_lockin_withdrawable_balance":0,"portfolio_value":168052.17,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":168052.17,"net_principal_investment":168000,"original_npi":150000,"total_investment":1459600,"total_redemption":1391889.75,"total_interest":100341.93,"redeemed_interest":82289.76,"accrued_interest":52.17,"capitalised_interest":18000,"total_capitalised":18000,"redeemed_principal":1309599.99,"absolute_return":52.17,"absolute_return_xiir":0.03,"annualized_return_xiir":12.67,"locked_withdrawable_balance":0,"display_flag":"DPV"}}

class InvestmentSummaryData {
  InvestmentSummaryData({
    this.schemeWiseData,
    this.investmentWiseData,
    this.totalSummary,
  });

  InvestmentSummaryData.fromJson(dynamic json) {
    if (json['scheme_wise_data'] != null) {
      schemeWiseData = [];
      json['scheme_wise_data'].forEach((v) {
        schemeWiseData?.add(SchemeWiseData.fromJson(v));
      });
    }
    if (json['investment_wise_data'] != null) {
      investmentWiseData = [];
      json['investment_wise_data'].forEach((v) {
        investmentWiseData?.add(InvestmentWiseData.fromJson(v));
      });
    }
    totalSummary = json['total_summary'] != null
        ? TotalSummary.fromJson(json['total_summary'])
        : null;
  }

  List<SchemeWiseData>? schemeWiseData;
  List<InvestmentWiseData>? investmentWiseData;
  TotalSummary? totalSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (schemeWiseData != null) {
      map['scheme_wise_data'] = schemeWiseData?.map((v) => v.toJson()).toList();
    }
    if (investmentWiseData != null) {
      map['investment_wise_data'] =
          investmentWiseData?.map((v) => v.toJson()).toList();
    }
    if (totalSummary != null) {
      map['total_summary'] = totalSummary?.toJson();
    }
    return map;
  }
}

/// investor_id : 1
/// name : "Sunil Lalmani Jaiswar"
/// family_role : "Master"
/// dashboard_summary : {"withdrawable_balance":168052.17,"flexi_lockin_withdrawable_balance":0,"portfolio_value":168052.17,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":168052.17,"net_principal_investment":168000,"original_npi":150000,"total_investment":1459600,"total_redemption":1391889.75,"total_interest":100341.93,"redeemed_interest":82289.76,"accrued_interest":52.17,"capitalised_interest":18000,"total_capitalised":18000,"redeemed_principal":1309599.99,"absolute_return":52.17,"absolute_return_xiir":0.03,"annualized_return_xiir":12.67,"locked_withdrawable_balance":0,"display_flag":"DPV"}

class TotalSummary {
  TotalSummary({
    this.investorId,
    this.name,
    this.familyRole,
    this.dashboardSummary,
  });

  TotalSummary.fromJson(dynamic json) {
    investorId = json['investor_id'];
    name = json['name'];
    familyRole = json['family_role'];
    dashboardSummary = json['dashboard_summary'] != null
        ? DashboardSummary.fromJson(json['dashboard_summary'])
        : null;
  }

  num? investorId;
  String? name;
  String? familyRole;
  DashboardSummary? dashboardSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['name'] = name;
    map['family_role'] = familyRole;
    if (dashboardSummary != null) {
      map['dashboard_summary'] = dashboardSummary?.toJson();
    }
    return map;
  }
}

/// withdrawable_balance : 168052.17
/// flexi_lockin_withdrawable_balance : 0
/// portfolio_value : 168052.17
/// requested_withdrawal : 0
/// requested_investment : 0
/// display_portfolio_value : 168052.17
/// net_principal_investment : 168000
/// original_npi : 150000
/// total_investment : 1459600
/// total_redemption : 1391889.75
/// total_interest : 100341.93
/// redeemed_interest : 82289.76
/// accrued_interest : 52.17
/// capitalised_interest : 18000
/// total_capitalised : 18000
/// redeemed_principal : 1309599.99
/// absolute_return : 52.17
/// absolute_return_xiir : 0.03
/// annualized_return_xiir : 12.67
/// locked_withdrawable_balance : 0
/// display_flag : "DPV"

class DashboardSummary {
  DashboardSummary({
    this.withdrawableBalance,
    this.flexiLockinWithdrawableBalance,
    this.portfolioValue,
    this.requestedWithdrawal,
    this.requestedInvestment,
    this.displayPortfolioValue,
    this.netPrincipalInvestment,
    this.originalNpi,
    this.totalInvestment,
    this.totalRedemption,
    this.totalInterest,
    this.redeemedInterest,
    this.accruedInterest,
    this.capitalisedInterest,
    this.totalCapitalised,
    this.redeemedPrincipal,
    this.absoluteReturn,
    this.absoluteReturnXiir,
    this.annualizedReturnXiir,
    this.lockedWithdrawableBalance,
    this.displayFlag,
  });

  DashboardSummary.fromJson(dynamic json) {
    withdrawableBalance = json['withdrawable_balance'];
    flexiLockinWithdrawableBalance = json['flexi_lockin_withdrawable_balance'];
    portfolioValue = json['portfolio_value'];
    requestedWithdrawal = json['requested_withdrawal'];
    requestedInvestment = json['requested_investment'];
    displayPortfolioValue = json['display_portfolio_value'];
    netPrincipalInvestment = json['net_principal_investment'];
    originalNpi = json['original_npi'];
    totalInvestment = json['total_investment'];
    totalRedemption = json['total_redemption'];
    totalInterest = json['total_interest'];
    redeemedInterest = json['redeemed_interest'];
    accruedInterest = json['accrued_interest'];
    capitalisedInterest = json['capitalised_interest'];
    totalCapitalised = json['total_capitalised'];
    redeemedPrincipal = json['redeemed_principal'];
    absoluteReturn = json['absolute_return'];
    absoluteReturnXiir = json['absolute_return_xiir'];
    annualizedReturnXiir = json['annualized_return_xiir'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
    displayFlag = json['display_flag'];
  }

  num? withdrawableBalance;
  num? flexiLockinWithdrawableBalance;
  num? portfolioValue;
  num? requestedWithdrawal;
  num? requestedInvestment;
  num? displayPortfolioValue;
  num? netPrincipalInvestment;
  num? originalNpi;
  num? totalInvestment;
  num? totalRedemption;
  num? totalInterest;
  num? redeemedInterest;
  num? accruedInterest;
  num? capitalisedInterest;
  num? totalCapitalised;
  num? redeemedPrincipal;
  num? absoluteReturn;
  num? absoluteReturnXiir;
  num? annualizedReturnXiir;
  num? lockedWithdrawableBalance;
  String? displayFlag;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['withdrawable_balance'] = withdrawableBalance;
    map['flexi_lockin_withdrawable_balance'] = flexiLockinWithdrawableBalance;
    map['portfolio_value'] = portfolioValue;
    map['requested_withdrawal'] = requestedWithdrawal;
    map['requested_investment'] = requestedInvestment;
    map['display_portfolio_value'] = displayPortfolioValue;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['original_npi'] = originalNpi;
    map['total_investment'] = totalInvestment;
    map['total_redemption'] = totalRedemption;
    map['total_interest'] = totalInterest;
    map['redeemed_interest'] = redeemedInterest;
    map['accrued_interest'] = accruedInterest;
    map['capitalised_interest'] = capitalisedInterest;
    map['total_capitalised'] = totalCapitalised;
    map['redeemed_principal'] = redeemedPrincipal;
    map['absolute_return'] = absoluteReturn;
    map['absolute_return_xiir'] = absoluteReturnXiir;
    map['annualized_return_xiir'] = annualizedReturnXiir;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    map['display_flag'] = displayFlag;
    return map;
  }
}

/// transaction_id : 105323142
/// investor_id : 1
/// transaction_date : "2023-07-09"
/// invested_amount : 168000
/// balance_principal : 168000
/// balance_interest : 0
/// scheme_id : 685
/// scheme_name : 685
/// investment_roi : 12
/// return_type : "Xirr"
/// payout_type : "Growth"
/// lockin_tenure : 0
/// lockin_break : null
/// maturity_start_date : "2023-07-09"
/// maturity_end_date : "2024-07-09"
/// transaction_sub_type : "Reinvestment"
/// investment_status : "Approved"
/// parent_investment_id : 91268821
/// master_parent_investment_id : 91268821
/// redeemed_principal : 0
/// redeemed_interest : 0
/// total_redemption : 0
/// redeemed_interest_with_request : 0
/// name : "Sunil Lalmani Jaiswar"
/// display_scheme : "12.00%"
/// scheme_details : "Xirr | 12.00% | MHP:0 | Payout Type:Growth"
/// lockin_end_date : null
/// net_principal_investment : 168000
/// interest_amount : 52.17
/// accrued_value : 168052.17
/// withdrawable_balance : 168052.17
/// locked_withdrawable_balance : 0

class InvestmentWiseData {
  InvestmentWiseData({
    this.transactionId,
    this.investorId,
    this.transactionDate,
    this.investedAmount,
    this.balancePrincipal,
    this.balanceInterest,
    this.schemeId,
    this.schemeName,
    this.investmentRoi,
    this.returnType,
    this.payoutType,
    this.lockinTenure,
    this.lockinBreak,
    this.maturityStartDate,
    this.maturityEndDate,
    this.transactionSubType,
    this.investmentStatus,
    this.parentInvestmentId,
    this.masterParentInvestmentId,
    this.redeemedPrincipal,
    this.redeemedInterest,
    this.totalRedemption,
    this.redeemedInterestWithRequest,
    this.name,
    this.displayScheme,
    this.schemeDetails,
    this.lockinEndDate,
    this.netPrincipalInvestment,
    this.interestAmount,
    this.accruedValue,
    this.withdrawableBalance,
    this.lockedWithdrawableBalance,
  });

  InvestmentWiseData.fromJson(dynamic json) {
    transactionId = json['transaction_id'];
    investorId = json['investor_id'];
    transactionDate = json['transaction_date'];
    investedAmount = json['invested_amount'];
    balancePrincipal = json['balance_principal'];
    balanceInterest = json['balance_interest'];
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
    investmentRoi = json['investment_roi'];
    returnType = json['return_type'];
    payoutType = json['payout_type'];
    lockinTenure = json['lockin_tenure'];
    lockinBreak = json['lockin_break'];
    maturityStartDate = json['maturity_start_date'];
    maturityEndDate = json['maturity_end_date'];
    transactionSubType = json['transaction_sub_type'];
    investmentStatus = json['investment_status'];
    parentInvestmentId = json['parent_investment_id'];
    masterParentInvestmentId = json['master_parent_investment_id'];
    redeemedPrincipal = json['redeemed_principal'];
    redeemedInterest = json['redeemed_interest'];
    totalRedemption = json['total_redemption'];
    redeemedInterestWithRequest = json['redeemed_interest_with_request'];
    name = json['name'];
    displayScheme = json['display_scheme'];
    schemeDetails = json['scheme_details'];
    lockinEndDate = json['lockin_end_date'];
    netPrincipalInvestment = json['net_principal_investment'];
    interestAmount = json['interest_amount'];
    accruedValue = json['accrued_value'];
    withdrawableBalance = json['withdrawable_balance'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
  }

  num? transactionId;
  num? investorId;
  String? transactionDate;
  num? investedAmount;
  num? balancePrincipal;
  num? balanceInterest;
  num? schemeId;
  num? schemeName;
  num? investmentRoi;
  String? returnType;
  String? payoutType;
  num? lockinTenure;
  dynamic lockinBreak;
  String? maturityStartDate;
  String? maturityEndDate;
  String? transactionSubType;
  String? investmentStatus;
  num? parentInvestmentId;
  num? masterParentInvestmentId;
  num? redeemedPrincipal;
  num? redeemedInterest;
  num? totalRedemption;
  num? redeemedInterestWithRequest;
  String? name;
  String? displayScheme;
  String? schemeDetails;
  dynamic lockinEndDate;
  num? netPrincipalInvestment;
  num? interestAmount;
  num? accruedValue;
  num? withdrawableBalance;
  num? lockedWithdrawableBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = transactionId;
    map['investor_id'] = investorId;
    map['transaction_date'] = transactionDate;
    map['invested_amount'] = investedAmount;
    map['balance_principal'] = balancePrincipal;
    map['balance_interest'] = balanceInterest;
    map['scheme_id'] = schemeId;
    map['scheme_name'] = schemeName;
    map['investment_roi'] = investmentRoi;
    map['return_type'] = returnType;
    map['payout_type'] = payoutType;
    map['lockin_tenure'] = lockinTenure;
    map['lockin_break'] = lockinBreak;
    map['maturity_start_date'] = maturityStartDate;
    map['maturity_end_date'] = maturityEndDate;
    map['transaction_sub_type'] = transactionSubType;
    map['investment_status'] = investmentStatus;
    map['parent_investment_id'] = parentInvestmentId;
    map['master_parent_investment_id'] = masterParentInvestmentId;
    map['redeemed_principal'] = redeemedPrincipal;
    map['redeemed_interest'] = redeemedInterest;
    map['total_redemption'] = totalRedemption;
    map['redeemed_interest_with_request'] = redeemedInterestWithRequest;
    map['name'] = name;
    map['display_scheme'] = displayScheme;
    map['scheme_details'] = schemeDetails;
    map['lockin_end_date'] = lockinEndDate;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['interest_amount'] = interestAmount;
    map['accrued_value'] = accruedValue;
    map['withdrawable_balance'] = withdrawableBalance;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    return map;
  }
}

/// scheme_id : 685
/// scheme_name : 685
/// display_scheme : "12.00%"
/// investment_roi : 12
/// return_type : "Xirr"
/// payout_type : "Growth"
/// lockin_tenure : 0
/// lockin_break : null
/// scheme_details : "Xirr | 12.00% | MHP:0 | Payout Type:Growth"
/// invested_amount : 168000
/// redeemed_principal : 0
/// redeemed_interest : 0
/// total_redemption : 0
/// net_principal_investment : 168000
/// interest_amount : 52.17
/// accrued_value : 168052.17
/// withdrawable_balance : 168052.17
/// locked_withdrawable_balance : 0
/// investment_summary : [{"transaction_id":105323142,"investor_id":1,"transaction_date":"2023-07-09","invested_amount":168000,"balance_principal":168000,"balance_interest":0,"scheme_id":685,"scheme_name":685,"investment_roi":12,"return_type":"Xirr","payout_type":"Growth","lockin_tenure":0,"lockin_break":null,"maturity_start_date":"2023-07-09","maturity_end_date":"2024-07-09","transaction_sub_type":"Reinvestment","investment_status":"Approved","parent_investment_id":91268821,"master_parent_investment_id":91268821,"redeemed_principal":0,"redeemed_interest":0,"total_redemption":0,"redeemed_interest_with_request":0,"name":"Sunil Lalmani Jaiswar","display_scheme":"12.00%","scheme_details":"Xirr | 12.00% | MHP:0 | Payout Type:Growth","lockin_end_date":null,"net_principal_investment":168000,"interest_amount":52.17,"accrued_value":168052.17,"withdrawable_balance":168052.17,"locked_withdrawable_balance":0}]

class SchemeWiseData {
  SchemeWiseData({
    this.schemeId,
    this.schemeName,
    this.displayScheme,
    this.investmentRoi,
    this.returnType,
    this.payoutType,
    this.lockinTenure,
    this.lockinBreak,
    this.schemeDetails,
    this.investedAmount,
    this.redeemedPrincipal,
    this.redeemedInterest,
    this.totalRedemption,
    this.netPrincipalInvestment,
    this.interestAmount,
    this.accruedValue,
    this.withdrawableBalance,
    this.lockedWithdrawableBalance,
    this.investmentSummary,
  });

  SchemeWiseData.fromJson(dynamic json) {
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
    displayScheme = json['display_scheme'];
    investmentRoi = json['investment_roi'];
    returnType = json['return_type'];
    payoutType = json['payout_type'];
    lockinTenure = json['lockin_tenure'];
    lockinBreak = json['lockin_break'];
    schemeDetails = json['scheme_details'];
    investedAmount = json['invested_amount'];
    redeemedPrincipal = json['redeemed_principal'];
    redeemedInterest = json['redeemed_interest'];
    totalRedemption = json['total_redemption'];
    netPrincipalInvestment = json['net_principal_investment'];
    interestAmount = json['interest_amount'];
    accruedValue = json['accrued_value'];
    withdrawableBalance = json['withdrawable_balance'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
    if (json['investment_summary'] != null) {
      investmentSummary = [];
      json['investment_summary'].forEach((v) {
        investmentSummary?.add(InvestmentSummary.fromJson(v));
      });
    }
  }

  num? schemeId;
  num? schemeName;
  String? displayScheme;
  num? investmentRoi;
  String? returnType;
  String? payoutType;
  num? lockinTenure;
  dynamic lockinBreak;
  String? schemeDetails;
  num? investedAmount;
  num? redeemedPrincipal;
  num? redeemedInterest;
  num? totalRedemption;
  num? netPrincipalInvestment;
  num? interestAmount;
  num? accruedValue;
  num? withdrawableBalance;
  num? lockedWithdrawableBalance;
  List<InvestmentSummary>? investmentSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['scheme_id'] = schemeId;
    map['scheme_name'] = schemeName;
    map['display_scheme'] = displayScheme;
    map['investment_roi'] = investmentRoi;
    map['return_type'] = returnType;
    map['payout_type'] = payoutType;
    map['lockin_tenure'] = lockinTenure;
    map['lockin_break'] = lockinBreak;
    map['scheme_details'] = schemeDetails;
    map['invested_amount'] = investedAmount;
    map['redeemed_principal'] = redeemedPrincipal;
    map['redeemed_interest'] = redeemedInterest;
    map['total_redemption'] = totalRedemption;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['interest_amount'] = interestAmount;
    map['accrued_value'] = accruedValue;
    map['withdrawable_balance'] = withdrawableBalance;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    if (investmentSummary != null) {
      map['investment_summary'] =
          investmentSummary?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// transaction_id : 105323142
/// investor_id : 1
/// transaction_date : "2023-07-09"
/// invested_amount : 168000
/// balance_principal : 168000
/// balance_interest : 0
/// scheme_id : 685
/// scheme_name : 685
/// investment_roi : 12
/// return_type : "Xirr"
/// payout_type : "Growth"
/// lockin_tenure : 0
/// lockin_break : null
/// maturity_start_date : "2023-07-09"
/// maturity_end_date : "2024-07-09"
/// transaction_sub_type : "Reinvestment"
/// investment_status : "Approved"
/// parent_investment_id : 91268821
/// master_parent_investment_id : 91268821
/// redeemed_principal : 0
/// redeemed_interest : 0
/// total_redemption : 0
/// redeemed_interest_with_request : 0
/// name : "Sunil Lalmani Jaiswar"
/// display_scheme : "12.00%"
/// scheme_details : "Xirr | 12.00% | MHP:0 | Payout Type:Growth"
/// lockin_end_date : null
/// net_principal_investment : 168000
/// interest_amount : 52.17
/// accrued_value : 168052.17
/// withdrawable_balance : 168052.17
/// locked_withdrawable_balance : 0

class InvestmentSummary {
  InvestmentSummary({
    this.transactionId,
    this.investorId,
    this.transactionDate,
    this.investedAmount,
    this.balancePrincipal,
    this.balanceInterest,
    this.schemeId,
    this.schemeName,
    this.investmentRoi,
    this.returnType,
    this.payoutType,
    this.lockinTenure,
    this.lockinBreak,
    this.maturityStartDate,
    this.maturityEndDate,
    this.transactionSubType,
    this.investmentStatus,
    this.parentInvestmentId,
    this.masterParentInvestmentId,
    this.redeemedPrincipal,
    this.redeemedInterest,
    this.totalRedemption,
    this.redeemedInterestWithRequest,
    this.name,
    this.displayScheme,
    this.schemeDetails,
    this.lockinEndDate,
    this.netPrincipalInvestment,
    this.interestAmount,
    this.accruedValue,
    this.withdrawableBalance,
    this.lockedWithdrawableBalance,
  });

  InvestmentSummary.fromJson(dynamic json) {
    transactionId = json['transaction_id'];
    investorId = json['investor_id'];
    transactionDate = json['transaction_date'];
    investedAmount = json['invested_amount'];
    balancePrincipal = json['balance_principal'];
    balanceInterest = json['balance_interest'];
    schemeId = json['scheme_id'];
    schemeName = json['scheme_name'];
    investmentRoi = json['investment_roi'];
    returnType = json['return_type'];
    payoutType = json['payout_type'];
    lockinTenure = json['lockin_tenure'];
    lockinBreak = json['lockin_break'];
    maturityStartDate = json['maturity_start_date'];
    maturityEndDate = json['maturity_end_date'];
    transactionSubType = json['transaction_sub_type'];
    investmentStatus = json['investment_status'];
    parentInvestmentId = json['parent_investment_id'];
    masterParentInvestmentId = json['master_parent_investment_id'];
    redeemedPrincipal = json['redeemed_principal'];
    redeemedInterest = json['redeemed_interest'];
    totalRedemption = json['total_redemption'];
    redeemedInterestWithRequest = json['redeemed_interest_with_request'];
    name = json['name'];
    displayScheme = json['display_scheme'];
    schemeDetails = json['scheme_details'];
    lockinEndDate = json['lockin_end_date'];
    netPrincipalInvestment = json['net_principal_investment'];
    interestAmount = json['interest_amount'];
    accruedValue = json['accrued_value'];
    withdrawableBalance = json['withdrawable_balance'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
  }

  num? transactionId;
  num? investorId;
  String? transactionDate;
  num? investedAmount;
  num? balancePrincipal;
  num? balanceInterest;
  num? schemeId;
  num? schemeName;
  num? investmentRoi;
  String? returnType;
  String? payoutType;
  num? lockinTenure;
  dynamic lockinBreak;
  String? maturityStartDate;
  String? maturityEndDate;
  String? transactionSubType;
  String? investmentStatus;
  num? parentInvestmentId;
  num? masterParentInvestmentId;
  num? redeemedPrincipal;
  num? redeemedInterest;
  num? totalRedemption;
  num? redeemedInterestWithRequest;
  String? name;
  String? displayScheme;
  String? schemeDetails;
  dynamic lockinEndDate;
  num? netPrincipalInvestment;
  num? interestAmount;
  num? accruedValue;
  num? withdrawableBalance;
  num? lockedWithdrawableBalance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transaction_id'] = transactionId;
    map['investor_id'] = investorId;
    map['transaction_date'] = transactionDate;
    map['invested_amount'] = investedAmount;
    map['balance_principal'] = balancePrincipal;
    map['balance_interest'] = balanceInterest;
    map['scheme_id'] = schemeId;
    map['scheme_name'] = schemeName;
    map['investment_roi'] = investmentRoi;
    map['return_type'] = returnType;
    map['payout_type'] = payoutType;
    map['lockin_tenure'] = lockinTenure;
    map['lockin_break'] = lockinBreak;
    map['maturity_start_date'] = maturityStartDate;
    map['maturity_end_date'] = maturityEndDate;
    map['transaction_sub_type'] = transactionSubType;
    map['investment_status'] = investmentStatus;
    map['parent_investment_id'] = parentInvestmentId;
    map['master_parent_investment_id'] = masterParentInvestmentId;
    map['redeemed_principal'] = redeemedPrincipal;
    map['redeemed_interest'] = redeemedInterest;
    map['total_redemption'] = totalRedemption;
    map['redeemed_interest_with_request'] = redeemedInterestWithRequest;
    map['name'] = name;
    map['display_scheme'] = displayScheme;
    map['scheme_details'] = schemeDetails;
    map['lockin_end_date'] = lockinEndDate;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['interest_amount'] = interestAmount;
    map['accrued_value'] = accruedValue;
    map['withdrawable_balance'] = withdrawableBalance;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    return map;
  }
}
