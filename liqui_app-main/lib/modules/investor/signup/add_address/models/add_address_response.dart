class AddAddressResponse {
  AddAddressResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  AddAddressResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
      data = json['data'] != null
          ? json['data'] is List
          ? null
          : CreateAddressModel.fromJson(json['data'])
          : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  CreateAddressModel? data;
  int? code;

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

class CreateAddressModel {
  CreateAddressModel({
    this.investorId,
    this.addressLine1,
    this.addressLine2,
    this.area,
    this.pinCode,
    this.city,
    this.state,
    this.addressType,
    this.ownershipType,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  CreateAddressModel.fromJson(dynamic json) {
    investorId = json['investor_id'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    area = json['area'];
    pinCode = json['pin_code'];
    city = json['city'];
    state = json['state'];
    addressType = json['address_type'];
    ownershipType = json['ownership_type'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
  }

  String? investorId;
  String? addressLine1;
  dynamic addressLine2;
  dynamic area;
  String? pinCode;
  String? city;
  String? state;
  String? addressType;
  dynamic ownershipType;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  int? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['investor_id'] = investorId;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['area'] = area;
    map['pin_code'] = pinCode;
    map['city'] = city;
    map['state'] = state;
    map['address_type'] = addressType;
    map['ownership_type'] = ownershipType;
    map['created_by'] = createdBy;
    map['updated_by'] = updatedBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['id'] = id;
    return map;
  }
}
