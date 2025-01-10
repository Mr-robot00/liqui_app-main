/// status : true
/// message : "Investor hierarchy created"
/// data : [{"ifa_id":103,"ifa_name":"Liquiloans","family_master_investor_id":374222,"family_master_name":"Sadashiv shendye","family_members":[{"investor_id":374222,"name":"Sadashiv shendye"}]},{"ifa_id":59,"ifa_name":"Oro-Wealth","family_master_investor_id":374229,"family_master_name":"Sadashiv shendye","family_members":[{"investor_id":374229,"name":"Sadashiv shendye"}]},{"ifa_id":56,"ifa_name":"CUBE CONSUMER SERVICES PRIVATE LIMITED","family_master_investor_id":374230,"family_master_name":"Sadashiv shendye","family_members":[{"investor_id":374230,"name":"Sadashiv shendye"}]}]
/// code : 200

class InvestorHierarchyResponse {
  InvestorHierarchyResponse({
      this.status, 
      this.message, 
      this.hierarchyDetails,
      this.code,});

  InvestorHierarchyResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      hierarchyDetails = [];
      json['data'].forEach((v) {
        hierarchyDetails?.add(InvestorHierarchyModel.fromJson(v));
      });
    }
    code = json['code'];
  }
  bool? status;
  String? message;
  List<InvestorHierarchyModel>? hierarchyDetails;
  dynamic code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (hierarchyDetails != null) {
      map['data'] = hierarchyDetails?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    return map;
  }

}

/// ifa_id : 103
/// ifa_name : "Liquiloans"
/// family_master_investor_id : 374222
/// family_master_name : "Sadashiv shendye"
/// family_members : [{"investor_id":374222,"name":"Sadashiv shendye"}]

class InvestorHierarchyModel {
  InvestorHierarchyModel({
      this.ifaId, 
      this.ifaName, 
      this.familyMasterInvestorId, 
      this.familyMasterName, 
      this.familyMembers,});

  InvestorHierarchyModel.fromJson(dynamic json) {
    ifaId = json['ifa_id'];
    ifaName = json['ifa_name'];
    familyMasterInvestorId = json['family_master_investor_id'];
    familyMasterName = json['family_master_name'];
    if (json['family_members'] != null) {
      familyMembers = [];
      json['family_members'].forEach((v) {
        familyMembers?.add(FamilyMembers.fromJson(v));
      });
    }
  }
  num? ifaId;
  String? ifaName;
  num? familyMasterInvestorId;
  String? familyMasterName;
  List<FamilyMembers>? familyMembers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ifa_id'] = ifaId;
    map['ifa_name'] = ifaName;
    map['family_master_investor_id'] = familyMasterInvestorId;
    map['family_master_name'] = familyMasterName;
    if (familyMembers != null) {
      map['family_members'] = familyMembers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// investor_id : 374222
/// name : "Sadashiv shendye"

class FamilyMembers {
  FamilyMembers({
      this.investorId, 
      this.name,});

  FamilyMembers.fromJson(dynamic json) {
    investorId = json['investor_id'];
    name = json['name'];
  }
  num? investorId;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['name'] = name;
    return map;
  }

}