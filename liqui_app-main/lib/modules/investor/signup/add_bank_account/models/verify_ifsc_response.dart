/// status : true
/// message : "Bank ifsc code verified."
/// data : {"city":"ERNAKULAM","office":"COCHIN - PALARIVATTAM","district":"ERNAKULAM","bank_name":"HDFC BANK","ifsc":"HDFC0000520","micr":"","branch_name":"COCHIN - PALARIVATTAM","state":"KERALA","contact":"9895663333","phone_no":"9895663333","branch":"COCHIN - PALARIVATTAM","add_address":"PALARIVATTAM.BUILDING NO. 32/1182,GROUND FLOOR,PALARIVATTAM JUNCTION,COCHINKERALA682025","city_name":"KOCHI","city2":"KOCHI","city1":"ERNAKULAM","bank":"HDFC BANK"}
/// code : 200

class VerifyIFSCResponse {
  VerifyIFSCResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  VerifyIFSCResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : VerifyIFSCModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }
  bool? status;
  String? message;
  VerifyIFSCModel? data;
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

/// city : "ERNAKULAM"
/// office : "COCHIN - PALARIVATTAM"
/// district : "ERNAKULAM"
/// bank_name : "HDFC BANK"
/// ifsc : "HDFC0000520"
/// micr : ""
/// branch_name : "COCHIN - PALARIVATTAM"
/// state : "KERALA"
/// contact : "9895663333"
/// phone_no : "9895663333"
/// branch : "COCHIN - PALARIVATTAM"
/// add_address : "PALARIVATTAM.BUILDING NO. 32/1182,GROUND FLOOR,PALARIVATTAM JUNCTION,COCHINKERALA682025"
/// city_name : "KOCHI"
/// city2 : "KOCHI"
/// city1 : "ERNAKULAM"
/// bank : "HDFC BANK"

class VerifyIFSCModel {
  VerifyIFSCModel({
      this.city, 
      this.office, 
      this.district, 
      this.bankName, 
      this.ifsc, 
      this.micr, 
      this.branchName, 
      this.state, 
      this.contact, 
      this.phoneNo, 
      this.branch, 
      this.address, 
      this.cityName, 
      this.city2, 
      this.city1, 
      this.bank,});

  VerifyIFSCModel.fromJson(dynamic json) {
    city = json['city'];
    office = json['office'];
    district = json['district'];
    bankName = json['bank_name'];
    ifsc = json['ifsc'];
    micr = json['micr'];
    branchName = json['branch_name'];
    state = json['state'];
    contact = json['contact'];
    phoneNo = json['phone_no'];
    branch = json['branch'];
    address = json['add_address'];
    cityName = json['city_name'];
    city2 = json['city2'];
    city1 = json['city1'];
    bank = json['bank'];
  }
  String? city;
  String? office;
  String? district;
  String? bankName;
  String? ifsc;
  String? micr;
  String? branchName;
  String? state;
  String? contact;
  String? phoneNo;
  String? branch;
  String? address;
  String? cityName;
  String? city2;
  String? city1;
  String? bank;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city'] = city;
    map['office'] = office;
    map['district'] = district;
    map['bank_name'] = bankName;
    map['ifsc'] = ifsc;
    map['micr'] = micr;
    map['branch_name'] = branchName;
    map['state'] = state;
    map['contact'] = contact;
    map['phone_no'] = phoneNo;
    map['branch'] = branch;
    map['add_address'] = address;
    map['city_name'] = cityName;
    map['city2'] = city2;
    map['city1'] = city1;
    map['bank'] = bank;
    return map;
  }

}