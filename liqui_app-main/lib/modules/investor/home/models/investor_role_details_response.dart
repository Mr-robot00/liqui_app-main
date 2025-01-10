/// status : true
/// message : "User Fetched Succesfully"
/// data : {"id":674976,"email":"kailash.suthar@liquiloans.com","is_email_verified":"True","name":"Kailash Suthar","contact_number":"9166772812","is_contact_number_verified":"False","last_login_date":null,"login_count":0,"current_role":{"id":740944,"role_id":2,"user_id":373778,"app_id":5,"is_default":"Y","name":"Internal Investor"},"roles_mapping":[{"id":740944,"sys_user_id":674976,"role_id":2,"user_id":373778,"is_default":"Y","reporting_user_id":null,"role":{"id":2,"name":"Internal Investor"}}]}

class InvestorRoleDetailsResponse {
  InvestorRoleDetailsResponse({
      this.status, 
      this.message, 
      this.investorRoleDetails,});

  InvestorRoleDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    investorRoleDetails = json['data'] != null
        ? json['data'] is List
        ? null
        : InvestorRoleDetailsModel.fromJson(json['data'])
        : null;
  }
  bool? status;
  String? message;
  InvestorRoleDetailsModel? investorRoleDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (investorRoleDetails != null) {
      map['data'] = investorRoleDetails?.toJson();
    }
    return map;
  }

}

/// id : 674976
/// email : "kailash.suthar@liquiloans.com"
/// is_email_verified : "True"
/// name : "Kailash Suthar"
/// contact_number : "9166772812"
/// is_contact_number_verified : "False"
/// last_login_date : null
/// login_count : 0
/// current_role : {"id":740944,"role_id":2,"user_id":373778,"app_id":5,"is_default":"Y","name":"Internal Investor"}
/// roles_mapping : [{"id":740944,"sys_user_id":674976,"role_id":2,"user_id":373778,"is_default":"Y","reporting_user_id":null,"role":{"id":2,"name":"Internal Investor"}}]

class InvestorRoleDetailsModel {
  InvestorRoleDetailsModel({
      this.id, 
      this.email, 
      this.isEmailVerified, 
      this.name, 
      this.contactNumber, 
      this.isContactNumberVerified, 
      this.lastLoginDate, 
      this.loginCount, 
      this.currentRole, 
      this.rolesMapping,});

  InvestorRoleDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    isEmailVerified = json['is_email_verified'];
    name = json['name'];
    contactNumber = json['contact_number'];
    isContactNumberVerified = json['is_contact_number_verified'];
    lastLoginDate = json['last_login_date'];
    loginCount = json['login_count'];
    currentRole = json['current_role'] != null ? CurrentRole.fromJson(json['current_role']) : null;
    if (json['roles_mapping'] != null) {
      rolesMapping = [];
      json['roles_mapping'].forEach((v) {
        rolesMapping?.add(RolesMapping.fromJson(v));
      });
    }
  }
  num? id;
  String? email;
  String? isEmailVerified;
  String? name;
  String? contactNumber;
  String? isContactNumberVerified;
  dynamic lastLoginDate;
  num? loginCount;
  CurrentRole? currentRole;
  List<RolesMapping>? rolesMapping;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['is_email_verified'] = isEmailVerified;
    map['name'] = name;
    map['contact_number'] = contactNumber;
    map['is_contact_number_verified'] = isContactNumberVerified;
    map['last_login_date'] = lastLoginDate;
    map['login_count'] = loginCount;
    if (currentRole != null) {
      map['current_role'] = currentRole?.toJson();
    }
    if (rolesMapping != null) {
      map['roles_mapping'] = rolesMapping?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 740944
/// sys_user_id : 674976
/// role_id : 2
/// user_id : 373778
/// is_default : "Y"
/// reporting_user_id : null
/// role : {"id":2,"name":"Internal Investor"}

class RolesMapping {
  RolesMapping({
      this.id, 
      this.sysUserId, 
      this.roleId, 
      this.userId, 
      this.isDefault, 
      this.reportingUserId, 
      this.role,});

  RolesMapping.fromJson(dynamic json) {
    id = json['id'];
    sysUserId = json['sys_user_id'];
    roleId = json['role_id'];
    userId = json['user_id'];
    isDefault = json['is_default'];
    reportingUserId = json['reporting_user_id'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }
  num? id;
  num? sysUserId;
  num? roleId;
  num? userId;
  String? isDefault;
  dynamic reportingUserId;
  Role? role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['sys_user_id'] = sysUserId;
    map['role_id'] = roleId;
    map['user_id'] = userId;
    map['is_default'] = isDefault;
    map['reporting_user_id'] = reportingUserId;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    return map;
  }

}

/// id : 2
/// name : "Internal Investor"

class Role {
  Role({
      this.id, 
      this.name,});

  Role.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  num? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }

}

/// id : 740944
/// role_id : 2
/// user_id : 373778
/// app_id : 5
/// is_default : "Y"
/// name : "Internal Investor"

class CurrentRole {
  CurrentRole({
      this.id, 
      this.roleId, 
      this.userId, 
      this.appId, 
      this.isDefault, 
      this.name,});

  CurrentRole.fromJson(dynamic json) {
    id = json['id'];
    roleId = json['role_id'];
    userId = json['user_id'];
    appId = json['app_id'];
    isDefault = json['is_default'];
    name = json['name'];
  }
  num? id;
  num? roleId;
  num? userId;
  num? appId;
  String? isDefault;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role_id'] = roleId;
    map['user_id'] = userId;
    map['app_id'] = appId;
    map['is_default'] = isDefault;
    map['name'] = name;
    return map;
  }

}