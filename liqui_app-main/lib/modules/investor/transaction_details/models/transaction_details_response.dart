/// status : true
/// message : "Credit history fetched successfully"
/// data : {"utr":"","current_value":5001.630230985332,"data":[{"id":95724083,"transaction_date":"2022-08-03 13:10:06","transaction_type":"Credit","transaction_sub_type":"AddMoney","amount":5000,"opening_balance":0,"opening_principal":0,"opening_interest":0,"redeemed_principal":0,"redeemed_interest":0,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":0,"other":[]},{"id":95724167,"transaction_date":"2022-10-10 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":4000,"opening_balance":5035.0306,"opening_principal":5000,"opening_interest":35.0306,"redeemed_principal":0,"redeemed_interest":35.0306,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":35.0306,"other":[]},{"id":95724177,"transaction_date":"2022-10-19 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":1000,"opening_balance":5003.4164,"opening_principal":5000,"opening_interest":3.4164,"redeemed_principal":0,"redeemed_interest":3.4164,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":3.4164,"other":[]},{"id":95724182,"transaction_date":"2022-10-31 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":3000,"opening_balance":5003.1508,"opening_principal":5000,"opening_interest":3.1508,"redeemed_principal":0,"redeemed_interest":3.1508,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":3.1508,"other":[]},{"id":95724194,"transaction_date":"2022-11-14 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":600,"opening_balance":5002.2157,"opening_principal":5000,"opening_interest":2.2157,"redeemed_principal":0,"redeemed_interest":2.2157,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":2.2157,"other":[]},{"id":95724248,"transaction_date":"2022-12-15 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":1000,"opening_balance":5002.0473,"opening_principal":5000,"opening_interest":2.0473,"redeemed_principal":0,"redeemed_interest":2.0473,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":2.0473,"other":[]}]}
/// code : 200

class TransactionDetailsResponse {
  TransactionDetailsResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  TransactionDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
            ? null
            : TransactionMainModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  TransactionMainModel? data;
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

/// utr : ""
/// current_value : 5001.630230985332
/// data : [{"id":95724083,"transaction_date":"2022-08-03 13:10:06","transaction_type":"Credit","transaction_sub_type":"AddMoney","amount":5000,"opening_balance":0,"opening_principal":0,"opening_interest":0,"redeemed_principal":0,"redeemed_interest":0,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":0,"other":[]},{"id":95724167,"transaction_date":"2022-10-10 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":4000,"opening_balance":5035.0306,"opening_principal":5000,"opening_interest":35.0306,"redeemed_principal":0,"redeemed_interest":35.0306,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":35.0306,"other":[]},{"id":95724177,"transaction_date":"2022-10-19 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":1000,"opening_balance":5003.4164,"opening_principal":5000,"opening_interest":3.4164,"redeemed_principal":0,"redeemed_interest":3.4164,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":3.4164,"other":[]},{"id":95724182,"transaction_date":"2022-10-31 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":3000,"opening_balance":5003.1508,"opening_principal":5000,"opening_interest":3.1508,"redeemed_principal":0,"redeemed_interest":3.1508,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":3.1508,"other":[]},{"id":95724194,"transaction_date":"2022-11-14 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":600,"opening_balance":5002.2157,"opening_principal":5000,"opening_interest":2.2157,"redeemed_principal":0,"redeemed_interest":2.2157,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":2.2157,"other":[]},{"id":95724248,"transaction_date":"2022-12-15 00:00:00","transaction_type":"Debit","transaction_sub_type":"WithdrawMoney","amount":1000,"opening_balance":5002.0473,"opening_principal":5000,"opening_interest":2.0473,"redeemed_principal":0,"redeemed_interest":2.0473,"closing_principal":5000,"closing_interest":0,"closing_balance":5000,"total_redeemed_amount":2.0473,"other":[]}]

class TransactionMainModel {
  TransactionMainModel({
    this.utr,
    this.currentValue,
    this.data,
  });

  TransactionMainModel.fromJson(dynamic json) {
    utr = json['utr'];
    currentValue = json['current_value'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TransactionDataModel.fromJson(v));
      });
    }
  }

  String? utr;
  num? currentValue;
  List<TransactionDataModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['utr'] = utr;
    map['current_value'] = currentValue;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 95724083
/// transaction_date : "2022-08-03 13:10:06"
/// transaction_type : "Credit"
/// transaction_sub_type : "AddMoney"
/// amount : 5000
/// opening_balance : 0
/// opening_principal : 0
/// opening_interest : 0
/// redeemed_principal : 0
/// redeemed_interest : 0
/// closing_principal : 5000
/// closing_interest : 0
/// closing_balance : 5000
/// total_redeemed_amount : 0
/// other : []

class TransactionDataModel {
  TransactionDataModel({
    this.id,
    this.transactionDate,
    this.transactionType,
    this.transactionSubType,
    this.amount,
    this.openingBalance,
    this.openingPrincipal,
    this.openingInterest,
    this.redeemedPrincipal,
    this.redeemedInterest,
    this.closingPrincipal,
    this.closingInterest,
    this.closingBalance,
    this.totalRedeemedAmount,
    this.other,
  });

  TransactionDataModel.fromJson(dynamic json) {
    id = json['id'];
    transactionDate = json['transaction_date'];
    transactionType = json['transaction_type'];
    transactionSubType = json['transaction_sub_type'];
    amount = json['amount'];
    openingBalance = json['opening_balance'];
    openingPrincipal = json['opening_principal'];
    openingInterest = json['opening_interest'];
    redeemedPrincipal = json['redeemed_principal'];
    redeemedInterest = json['redeemed_interest'];
    closingPrincipal = json['closing_principal'];
    closingInterest = json['closing_interest'];
    closingBalance = json['closing_balance'];
    totalRedeemedAmount = json['total_redeemed_amount'];
    /*if (json['other'] != null) {
      other = [];
      json['other'].forEach((v) {
        other?.add(Dynamic.fromJson(v));
      });
    }*/
  }

  num? id;
  String? transactionDate;
  String? transactionType;
  String? transactionSubType;
  num? amount;
  num? openingBalance;
  num? openingPrincipal;
  num? openingInterest;
  num? redeemedPrincipal;
  num? redeemedInterest;
  num? closingPrincipal;
  num? closingInterest;
  num? closingBalance;
  num? totalRedeemedAmount;
  List<dynamic>? other;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['transaction_date'] = transactionDate;
    map['transaction_type'] = transactionType;
    map['transaction_sub_type'] = transactionSubType;
    map['amount'] = amount;
    map['opening_balance'] = openingBalance;
    map['opening_principal'] = openingPrincipal;
    map['opening_interest'] = openingInterest;
    map['redeemed_principal'] = redeemedPrincipal;
    map['redeemed_interest'] = redeemedInterest;
    map['closing_principal'] = closingPrincipal;
    map['closing_interest'] = closingInterest;
    map['closing_balance'] = closingBalance;
    map['total_redeemed_amount'] = totalRedeemedAmount;
    /*if (other != null) {
      map['other'] = other?.map((v) => v.toJson()).toList();
    }*/
    return map;
  }
}
