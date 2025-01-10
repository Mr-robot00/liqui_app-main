import 'dart:convert';

/// status : true
/// message : "Payment gateway data built successfully"
/// data : {"payment_gateway":"PayU","order_id":"63ef168e5e3ff_374441","url":"https://test.payu.in/_payment","payload":{"key":"a9tJCC","txnid":"63ef168e5e3ff_374441","amount":"5000","firstname":"Nominee","email":"nominee123433@gmail.com","phone":"7865433333","productinfo":"63ef168e5e3ff_374441","surl":"https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource","furl":"https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource","hash":"c30eeed91a863237c10253c8990d3c3f4349db4bea69a0c544784788f1a5a70f4b44111414b5fae0f968ceccf519b9ce6df5005976ebcab24fed513986c40180"}}
/// code : 200

class MakePaymentResponse {
  MakePaymentResponse({
    this.status,
    this.message,
    this.payloadData,
    this.code,
  });

  MakePaymentResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    payloadData = json['data'] != null
        ? json['data'] is List
            ? null
            : PaymentPayloadModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  PaymentPayloadModel? payloadData;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (payloadData != null) {
      map['data'] = payloadData?.toJson();
    }
    map['code'] = code;
    return map;
  }
}

/// payment_gateway : "PayU"
/// order_id : "63ef168e5e3ff_374441"
/// url : "https://test.payu.in/_payment"
/// payload : {"key":"a9tJCC","txnid":"63ef168e5e3ff_374441","amount":"5000","firstname":"Nominee","email":"nominee123433@gmail.com","phone":"7865433333","productinfo":"63ef168e5e3ff_374441","surl":"https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource","furl":"https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource","hash":"c30eeed91a863237c10253c8990d3c3f4349db4bea69a0c544784788f1a5a70f4b44111414b5fae0f968ceccf519b9ce6df5005976ebcab24fed513986c40180"}

class PaymentPayloadModel {
  PaymentPayloadModel({
    this.paymentGateway,
    this.orderId,
    this.url,
    this.payload,
  });

  PaymentPayloadModel.fromJson(dynamic json) {
    paymentGateway = json['payment_gateway'];
    orderId = json['order_id'];
    url = json['url'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  String? paymentGateway;
  String? orderId;
  String? url;
  Payload? payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_gateway'] = paymentGateway;
    map['order_id'] = orderId;
    map['url'] = url;
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    return map;
  }
}

/// key : "a9tJCC"
/// txnid : "63ef168e5e3ff_374441"
/// amount : "5000"
/// firstname : "Nominee"
/// email : "nominee123433@gmail.com"
/// phone : "7865433333"
/// productinfo : "63ef168e5e3ff_374441"
/// surl : "https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource"
/// furl : "https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=PayU&link_token=&redirect_to=AppSource"
/// hash : "c30eeed91a863237c10253c8990d3c3f4349db4bea69a0c544784788f1a5a70f4b44111414b5fae0f968ceccf519b9ce6df5005976ebcab24fed513986c40180"
/// for paytm
/// MID : "NDXP2P84798390195997"
/// ORDER_ID : "63ef466d85cea_374441"
/// CUST_ID : "374441"
/// INDUSTRY_TYPE_ID : "Retail"
/// CHANNEL_ID : "WEB"
/// TXN_AMOUNT : "5000"
/// WEBSITE : "WEBSTAGING"
/// CALLBACK_URL : "https://api-router.liquiloan.in/o/web/supply/PaymentGatewayCallback?payment_gateway=Paytm&link_token=&redirect_to=AppSource","CHECKSUMHASH":"E5l/9OD6mJHfftzpKywIxaHdNafW7d6sLeNZgYJugCeqMUrzZGAO5WE7Jy47rLShlQTpFBCETlVB6JHGqHL5WPdi8dc+NwnH2B/Brb/TOPY="
class Payload {
  Payload({
    this.key,
    this.txnid,
    this.amount,
    this.firstname,
    this.email,
    this.phone,
    this.productinfo,
    this.surl,
    this.furl,
    this.hash,
    this.mid,
    this.orderId,
    this.custId,
    this.industryTypeId,
    this.channelId,
    this.txnAmount,
    this.website,
    this.callbackUrl,
    this.checksumHash,
  });

  Payload.fromJson(dynamic json) {
    key = json['key'];
    txnid = json['txnid'];
    amount = json['amount'];
    firstname = json['firstname'];
    email = json['email'];
    phone = json['phone'];
    productinfo = json['productinfo'];
    surl = json['surl'];
    furl = json['furl'];
    hash = json['hash'];
    mid = json['MID'];
    orderId = json['ORDER_ID'];
    custId = json['CUST_ID'];
    industryTypeId = json['INDUSTRY_TYPE_ID'];
    channelId = json['CHANNEL_ID'];
    txnAmount = json['TXN_AMOUNT'];
    website = json['WEBSITE'];
    callbackUrl = json['CALLBACK_URL'];
    checksumHash = json['CHECKSUMHASH'];
  }

  String? key;
  String? txnid;
  String? amount;
  String? firstname;
  String? email;
  String? phone;
  String? productinfo;
  String? surl;
  String? furl;
  String? hash;
  String? mid;
  String? orderId;
  String? custId;
  String? industryTypeId;
  String? channelId;
  String? txnAmount;
  String? website;
  String? callbackUrl;
  String? checksumHash;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['txnid'] = txnid;
    map['amount'] = amount;
    map['firstname'] = firstname;
    map['email'] = email;
    map['phone'] = phone;
    map['productinfo'] = productinfo;
    map['surl'] = surl;
    map['furl'] = furl;
    map['hash'] = hash;
    map['MID'] = mid;
    map['ORDER_ID'] = orderId;
    map['CUST_ID'] = custId;
    map['INDUSTRY_TYPE_ID'] = industryTypeId;
    map['CHANNEL_ID'] = channelId;
    map['TXN_AMOUNT'] = txnAmount;
    map['WEBSITE'] = website;
    map['CALLBACK_URL'] = callbackUrl;
    map['CHECKSUMHASH'] = checksumHash;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}
