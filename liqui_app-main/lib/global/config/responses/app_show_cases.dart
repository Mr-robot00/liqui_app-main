class AppShowCases {
  //dashboard
  bool portfolio = true;
  bool withdrawableDash = true;
  bool lockedDash = true;
  bool accruedDash = true;
  bool investNow = true;
  bool chooseFolioDash = true;

  //Transaction
  bool allTransaction = true;
  bool investmentTransaction = true;
  bool interest = true;
  bool withdrawTransaction = true;

  //profile
  bool investorId = true;
  bool myProfile = true;
  bool appLock = true;

  //deposit
  bool selectScheme = true;
  bool investmentAmount = true;
  bool payoutType = true;
  bool earnedInterest = true;
  bool annualInterest = true;
  bool chooseFolioInvest = true;
  bool compareReturns = true;
  bool mhpTenure = true;

  //withdraw
  bool withdrawAmount = true;
  bool withdrawToBank = true;

  AppShowCases({
    //dashboard
    this.portfolio = true,
    this.withdrawableDash = true,
    this.lockedDash = true,
    this.accruedDash = true,
    this.investNow = true,
    this.chooseFolioDash = true,

    //Transaction
    this.allTransaction = true,
    this.investmentTransaction = true,
    this.interest = true,
    this.withdrawTransaction = true,

    //profile
    this.investorId = true,
    this.myProfile = true,
    this.appLock = true,

    //deposit
    this.selectScheme = true,
    this.investmentAmount = true,
    this.payoutType = true,
    this.earnedInterest = true,
    this.annualInterest = true,
    this.chooseFolioInvest = true,
    this.compareReturns = true,
    this.mhpTenure = true,

    //withdraw
    this.withdrawAmount = true,
    this.withdrawToBank = true,
  });

  AppShowCases.fromJson(dynamic json) {
    //dashboard
    portfolio = json['portfolio_amount'];
    withdrawableDash = json['withdrawable_amount'];
    lockedDash = json['locked_amount'];
    accruedDash = json['accrued_interest'];
    investNow = json['invest_now'];
    chooseFolioDash = json['choose_folio_dash'];

    //transaction
    allTransaction = json['all_transaction'];
    investmentTransaction = json['investment_transaction'];
    interest = json['interest'];
    withdrawTransaction = json['withdraw_transaction'];

    //profile
    investorId = json['investor_id'];
    myProfile = json['my_profile'];
    appLock = json['app_lock'];
    //deposit
    selectScheme = json['select_scheme'];
    investmentAmount = json['investment_amount'];
    payoutType = json['payout_type'];
    earnedInterest = json['earned_interest'];
    annualInterest = json['annual_interest'];
    chooseFolioInvest = json['choose_folio_invest'];
    compareReturns = json['compare_returns'];
    mhpTenure = json['mhp_tenure'];

    //withdraw
    withdrawAmount = json['withdraw_amount'];
    withdrawToBank = json['withdraw_to_bank'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    //dashboard
    map['portfolio_amount'] = portfolio;
    map['withdrawable_amount'] = withdrawableDash;
    map['locked_amount'] = lockedDash;
    map['accrued_interest'] = accruedDash;
    map['invest_now'] = investNow;
    map['choose_folio_dash'] = chooseFolioDash;
    //Transaction
    map['all_transaction'] = allTransaction;
    map['investment_transaction'] = investmentTransaction;
    map['interest'] = interest;
    map['withdraw_transaction'] = withdrawTransaction;
    //profile
    map['investor_id'] = investorId;
    map['my_profile'] = myProfile;
    map['app_lock'] = appLock;
    //deposit
    map['select_scheme'] = selectScheme;
    map['investment_amount'] = investmentAmount;
    map['payout_type'] = payoutType;
    map['earned_interest'] = earnedInterest;
    map['annual_interest'] = annualInterest;
    map['choose_folio_invest'] = chooseFolioInvest;
    map['compare_returns'] = compareReturns;
    map['mhp_tenure'] = mhpTenure;
    //withdraw
    map['withdraw_amount'] = withdrawAmount;
    map['withdraw_to_bank'] = withdrawToBank;
    return map;
  }
}
