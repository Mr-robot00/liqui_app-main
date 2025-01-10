/// status : true
/// message : "Investor data fetched successfully"
/// data : [{"investor_id":373778,"name":"Kailash Suthar","investor_type_id":2,"investor_type":"Internal Investor","agreement_status":"Signed","family_role":"Master","master_id":373778,"member_count":1,"kyc":{"status":"Pending","pending_documents":[],"pending_data":["kyc_status"]},"ifa_id":1035,"ifa_name":"PRATHMESH SATYAWAN GHADIGAONKAR","l1_ifa_id":1035,"l1_ifa_name":"PRATHMESH SATYAWAN GHADIGAONKAR","maximum_investment_amount":5000000,"approval_status":"Approved","kyc_status":"Pending","kyc_rejection_reasons":null,"kyc_date":null,"kyc_verification_mode":null}]
/// code : 200

class InvestorDetailsResponse {
  InvestorDetailsResponse({
    this.status,
    this.message,
    this.investorDetails,
    this.code,
  });

  InvestorDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      investorDetails = [];
      json['data'].forEach((v) {
        investorDetails?.add(InvestorDetailsModel.fromJson(v));
      });
    }
    code = json['code'];
  }

  bool? status;
  String? message;
  List<InvestorDetailsModel>? investorDetails;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (investorDetails != null) {
      map['data'] = investorDetails?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    return map;
  }
}

/// investor_id : 373778
/// name : "Kailash Suthar"
/// investor_type_id : 2
/// investor_type : "Internal Investor"
/// agreement_status : "Signed"
/// family_role : "Master"
/// master_id : 373778
/// member_count : 1
/// kyc : {"status":"Pending","pending_documents":[],"pending_data":["kyc_status"]}
/// ifa_id : 1035
/// ifa_name : "PRATHMESH SATYAWAN GHADIGAONKAR"
/// l1_ifa_id : 1035
/// l1_ifa_name : "PRATHMESH SATYAWAN GHADIGAONKAR"
/// maximum_investment_amount : 5000000
/// approval_status : "Approved"
/// kyc_status : "Pending"
/// kyc_rejection_reasons : null
/// kyc_date : null
/// kyc_verification_mode : null

class InvestorDetailsModel {
  InvestorDetailsModel({
    this.investorId,
    this.name,
    this.investorTypeId,
    this.investorType,
    this.agreementStatus,
    this.familyRole,
    this.masterId,
    this.memberCount,
    this.kyc,
    this.ifaId,
    this.ifaName,
    this.l1IfaId,
    this.l1IfaName,
    this.maximumInvestmentAmount,
    this.approvalStatus,
    this.kycStatus,
    this.kycRejectionReasons,
    this.kycDate,
    this.kycVerificationMode,
  });

  InvestorDetailsModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    name = json['name'];
    investorTypeId = json['investor_type_id'];
    investorType = json['investor_type'];
    agreementStatus = json['agreement_status'];
    familyRole = json['family_role'];
    masterId = json['master_id'];
    memberCount = json['member_count'];
    kyc = json['kyc'] != null ? Kyc.fromJson(json['kyc']) : null;
    ifaId = json['ifa_id'];
    ifaName = json['ifa_name'];
    l1IfaId = json['l1_ifa_id'];
    l1IfaName = json['l1_ifa_name'];
    maximumInvestmentAmount = json['maximum_investment_amount'];
    approvalStatus = json['approval_status'];
    kycStatus = json['kyc_status'];
    kycRejectionReasons = json['kyc_rejection_reasons'];
    kycDate = json['kyc_date'];
    kycVerificationMode = json['kyc_verification_mode'];
  }

  num? investorId;
  String? name;
  num? investorTypeId;
  String? investorType;
  String? agreementStatus;
  String? familyRole;
  num? masterId;
  num? memberCount;
  Kyc? kyc;
  num? ifaId;
  String? ifaName;
  num? l1IfaId;
  String? l1IfaName;
  num? maximumInvestmentAmount;
  String? approvalStatus;
  String? kycStatus;
  dynamic kycRejectionReasons;
  dynamic kycDate;
  dynamic kycVerificationMode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['name'] = name;
    map['investor_type_id'] = investorTypeId;
    map['investor_type'] = investorType;
    map['agreement_status'] = agreementStatus;
    map['family_role'] = familyRole;
    map['master_id'] = masterId;
    map['member_count'] = memberCount;
    if (kyc != null) {
      map['kyc'] = kyc?.toJson();
    }
    map['ifa_id'] = ifaId;
    map['ifa_name'] = ifaName;
    map['l1_ifa_id'] = l1IfaId;
    map['l1_ifa_name'] = l1IfaName;
    map['maximum_investment_amount'] = maximumInvestmentAmount;
    map['approval_status'] = approvalStatus;
    map['kyc_status'] = kycStatus;
    map['kyc_rejection_reasons'] = kycRejectionReasons;
    map['kyc_date'] = kycDate;
    map['kyc_verification_mode'] = kycVerificationMode;
    return map;
  }
}

/// status : "Pending"
/// pending_documents : []
/// pending_data : ["kyc_status"]

class Kyc {
  Kyc({
    this.status,
    this.pendingDocuments,
    this.pendingData,
  });

  Kyc.fromJson(dynamic json) {
    status = json['status'];
    if (json['pending_documents'] != null) {
      pendingDocuments = [];
      json['pending_documents'].forEach((v) {
        pendingDocuments?.add(json['doc']);
      });
    }
    pendingData =
        json['pending_data'] != null ? json['pending_data'].cast<String>() : [];
  }

  String? status;
  List<String>? pendingDocuments;
  List<String>? pendingData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (pendingDocuments != null) {
      map['pending_documents'] = pendingDocuments?.map((v) => v).toList();
    }
    map['pending_data'] = pendingData;
    return map;
  }
}
