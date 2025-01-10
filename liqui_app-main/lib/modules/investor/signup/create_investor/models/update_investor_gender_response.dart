/// status : true
/// message : "Investor details has been updated successfully with provided details."
/// data : []
/// code : 200

class UpdateInvestorGenderResponse {
  UpdateInvestorGenderResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  UpdateInvestorGenderResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
       // data?.add(Dynamic.fromJson(v));
      });
    }
    code = json['code'];
  }
  bool? status;
  String? message;
  List<dynamic>? data;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    return map;
  }

}