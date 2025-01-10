/// status : true
/// message : "Investor dashboard data fetched successfully"
/// data : {"investor_id":374222,"name":"Sadashiv shendye","family_role":"Master","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"},"folio_plus_family_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"folio_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"folio_data":{"103":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":[{"investor_id":374222,"name":"Sadashiv shendye","family_role":"Master","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}]},"59":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":{"1":{"investor_id":374229,"name":"Sadashiv shendye","family_role":"FolioChild","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}}},"56":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":{"2":{"investor_id":374230,"name":"Sadashiv shendye","family_role":"FolioChild","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}}}}}
/// code : 200

class DashboardSummaryResponse {
  DashboardSummaryResponse({
    this.status,
    this.message,
    this.dashboardSummary,
    this.code,
  });

  DashboardSummaryResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    dashboardSummary = json['data'] != null
        ? json['data'] is List
        ? null
        : DashboardSummaryModel.fromJson(json['data']) : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  DashboardSummaryModel? dashboardSummary;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (dashboardSummary != null) {
      map['data'] = dashboardSummary?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// investor_id : 374222
/// name : "Sadashiv shendye"
/// family_role : "Master"
/// dashboard_summary : {"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}
/// folio_plus_family_summary : {"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0}
/// folio_summary : {"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0}
/// folio_data : {"103":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":[{"investor_id":374222,"name":"Sadashiv shendye","family_role":"Master","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}]},"59":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":{"1":{"investor_id":374229,"name":"Sadashiv shendye","family_role":"FolioChild","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}}},"56":{"family_dashboard_summary":{"total_investment":0,"total_redemption":0,"net_principal_investment":0,"original_npi":0,"portfolio_value":0,"total_interest":0,"redeemed_interest":0,"capitalised_interest":0,"accrued_interest":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"withdrawable_balance":0,"requested_investment":0,"requested_withdrawal":0},"family_members":{"2":{"investor_id":374230,"name":"Sadashiv shendye","family_role":"FolioChild","dashboard_summary":{"withdrawable_balance":0,"flexi_lockin_withdrawable_balance":0,"portfolio_value":0,"requested_withdrawal":0,"requested_investment":0,"display_portfolio_value":0,"net_principal_investment":0,"original_npi":0,"total_investment":0,"total_redemption":0,"total_interest":0,"redeemed_interest":0,"accrued_interest":0,"capitalised_interest":0,"total_capitalised":0,"redeemed_principal":0,"absolute_return":0,"absolute_return_xiir":0,"annualized_return_xiir":0,"locked_withdrawable_balance":0,"display_flag":"DPV"}}}}}

class DashboardSummaryModel {
  DashboardSummaryModel({
    this.investorId,
    this.name,
    this.familyRole,
    this.dashboardDetails,
    this.folioDashboardDetails,
    this.folioSummary,
  });

  DashboardSummaryModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    name = json['name'];
    familyRole = json['family_role'];
    dashboardDetails = json['dashboard_summary'] != null
        ? DashboardDetailsModel.fromJson(json['dashboard_summary'])
        : null;
    folioDashboardDetails = json['folio_plus_family_summary'] != null
        ? FolioDashboardDetailsModel.fromJson(json['folio_plus_family_summary'])
        : null;
    folioSummary = json['folio_summary'] != null
        ? FolioSummary.fromJson(json['folio_summary'])
        : null;
  }

  num? investorId;
  String? name;
  String? familyRole;
  DashboardDetailsModel? dashboardDetails;
  FolioDashboardDetailsModel? folioDashboardDetails;
  FolioSummary? folioSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['name'] = name;
    map['family_role'] = familyRole;
    if (dashboardDetails != null) {
      map['dashboard_summary'] = dashboardDetails?.toJson();
    }
    if (folioDashboardDetails != null) {
      map['folio_plus_family_summary'] = folioDashboardDetails?.toJson();
    }
    if (folioSummary != null) {
      map['folio_summary'] = folioSummary?.toJson();
    }
    return map;
  }
}

/// withdrawable_balance : 0
/// flexi_lockin_withdrawable_balance : 0
/// portfolio_value : 0
/// requested_withdrawal : 0
/// requested_investment : 0
/// display_portfolio_value : 0
/// net_principal_investment : 0
/// original_npi : 0
/// total_investment : 0
/// total_redemption : 0
/// total_interest : 0
/// redeemed_interest : 0
/// accrued_interest : 0
/// capitalised_interest : 0
/// total_capitalised : 0
/// redeemed_principal : 0
/// absolute_return : 0
/// absolute_return_xiir : 0
/// annualized_return_xiir : 0
/// locked_withdrawable_balance : 0
/// display_flag : "DPV"

class DashboardDetailsModel {
  DashboardDetailsModel({
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

  DashboardDetailsModel.fromJson(dynamic json) {
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

/// total_investment : 0
/// total_redemption : 0
/// net_principal_investment : 0
/// original_npi : 0
/// portfolio_value : 0
/// total_interest : 0
/// redeemed_interest : 0
/// capitalised_interest : 0
/// accrued_interest : 0
/// redeemed_principal : 0
/// absolute_return : 0
/// absolute_return_xiir : 0
/// annualized_return_xiir : 0
/// locked_withdrawable_balance : 0
/// withdrawable_balance : 0
/// requested_investment : 0
/// requested_withdrawal : 0

class FolioSummary {
  FolioSummary({
    this.totalInvestment,
    this.totalRedemption,
    this.netPrincipalInvestment,
    this.originalNpi,
    this.portfolioValue,
    this.totalInterest,
    this.redeemedInterest,
    this.capitalisedInterest,
    this.accruedInterest,
    this.redeemedPrincipal,
    this.absoluteReturn,
    this.absoluteReturnXiir,
    this.annualizedReturnXiir,
    this.lockedWithdrawableBalance,
    this.withdrawableBalance,
    this.requestedInvestment,
    this.requestedWithdrawal,
  });

  FolioSummary.fromJson(dynamic json) {
    totalInvestment = json['total_investment'];
    totalRedemption = json['total_redemption'];
    netPrincipalInvestment = json['net_principal_investment'];
    originalNpi = json['original_npi'];
    portfolioValue = json['portfolio_value'];
    totalInterest = json['total_interest'];
    redeemedInterest = json['redeemed_interest'];
    capitalisedInterest = json['capitalised_interest'];
    accruedInterest = json['accrued_interest'];
    redeemedPrincipal = json['redeemed_principal'];
    absoluteReturn = json['absolute_return'];
    absoluteReturnXiir = json['absolute_return_xiir'];
    annualizedReturnXiir = json['annualized_return_xiir'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
    withdrawableBalance = json['withdrawable_balance'];
    requestedInvestment = json['requested_investment'];
    requestedWithdrawal = json['requested_withdrawal'];
  }

  num? totalInvestment;
  num? totalRedemption;
  num? netPrincipalInvestment;
  num? originalNpi;
  num? portfolioValue;
  num? totalInterest;
  num? redeemedInterest;
  num? capitalisedInterest;
  num? accruedInterest;
  num? redeemedPrincipal;
  num? absoluteReturn;
  num? absoluteReturnXiir;
  num? annualizedReturnXiir;
  num? lockedWithdrawableBalance;
  num? withdrawableBalance;
  num? requestedInvestment;
  num? requestedWithdrawal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_investment'] = totalInvestment;
    map['total_redemption'] = totalRedemption;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['original_npi'] = originalNpi;
    map['portfolio_value'] = portfolioValue;
    map['total_interest'] = totalInterest;
    map['redeemed_interest'] = redeemedInterest;
    map['capitalised_interest'] = capitalisedInterest;
    map['accrued_interest'] = accruedInterest;
    map['redeemed_principal'] = redeemedPrincipal;
    map['absolute_return'] = absoluteReturn;
    map['absolute_return_xiir'] = absoluteReturnXiir;
    map['annualized_return_xiir'] = annualizedReturnXiir;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    map['withdrawable_balance'] = withdrawableBalance;
    map['requested_investment'] = requestedInvestment;
    map['requested_withdrawal'] = requestedWithdrawal;
    return map;
  }
}

/// total_investment : 0
/// total_redemption : 0
/// net_principal_investment : 0
/// original_npi : 0
/// portfolio_value : 0
/// total_interest : 0
/// redeemed_interest : 0
/// capitalised_interest : 0
/// accrued_interest : 0
/// redeemed_principal : 0
/// absolute_return : 0
/// absolute_return_xiir : 0
/// annualized_return_xiir : 0
/// locked_withdrawable_balance : 0
/// withdrawable_balance : 0
/// requested_investment : 0
/// requested_withdrawal : 0

class FolioDashboardDetailsModel {
  FolioDashboardDetailsModel({
    this.totalInvestment,
    this.totalRedemption,
    this.netPrincipalInvestment,
    this.originalNpi,
    this.portfolioValue,
    this.totalInterest,
    this.redeemedInterest,
    this.capitalisedInterest,
    this.accruedInterest,
    this.redeemedPrincipal,
    this.absoluteReturn,
    this.absoluteReturnXiir,
    this.annualizedReturnXiir,
    this.lockedWithdrawableBalance,
    this.withdrawableBalance,
    this.requestedInvestment,
    this.requestedWithdrawal,
  });

  FolioDashboardDetailsModel.fromJson(dynamic json) {
    totalInvestment = json['total_investment'];
    totalRedemption = json['total_redemption'];
    netPrincipalInvestment = json['net_principal_investment'];
    originalNpi = json['original_npi'];
    portfolioValue = json['portfolio_value'];
    totalInterest = json['total_interest'];
    redeemedInterest = json['redeemed_interest'];
    capitalisedInterest = json['capitalised_interest'];
    accruedInterest = json['accrued_interest'];
    redeemedPrincipal = json['redeemed_principal'];
    absoluteReturn = json['absolute_return'];
    absoluteReturnXiir = json['absolute_return_xiir'];
    annualizedReturnXiir = json['annualized_return_xiir'];
    lockedWithdrawableBalance = json['locked_withdrawable_balance'];
    withdrawableBalance = json['withdrawable_balance'];
    requestedInvestment = json['requested_investment'];
    requestedWithdrawal = json['requested_withdrawal'];
  }

  num? totalInvestment;
  num? totalRedemption;
  num? netPrincipalInvestment;
  num? originalNpi;
  num? portfolioValue;
  num? totalInterest;
  num? redeemedInterest;
  num? capitalisedInterest;
  num? accruedInterest;
  num? redeemedPrincipal;
  num? absoluteReturn;
  num? absoluteReturnXiir;
  num? annualizedReturnXiir;
  num? lockedWithdrawableBalance;
  num? withdrawableBalance;
  num? requestedInvestment;
  num? requestedWithdrawal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_investment'] = totalInvestment;
    map['total_redemption'] = totalRedemption;
    map['net_principal_investment'] = netPrincipalInvestment;
    map['original_npi'] = originalNpi;
    map['portfolio_value'] = portfolioValue;
    map['total_interest'] = totalInterest;
    map['redeemed_interest'] = redeemedInterest;
    map['capitalised_interest'] = capitalisedInterest;
    map['accrued_interest'] = accruedInterest;
    map['redeemed_principal'] = redeemedPrincipal;
    map['absolute_return'] = absoluteReturn;
    map['absolute_return_xiir'] = absoluteReturnXiir;
    map['annualized_return_xiir'] = annualizedReturnXiir;
    map['locked_withdrawable_balance'] = lockedWithdrawableBalance;
    map['withdrawable_balance'] = withdrawableBalance;
    map['requested_investment'] = requestedInvestment;
    map['requested_withdrawal'] = requestedWithdrawal;
    return map;
  }
}
