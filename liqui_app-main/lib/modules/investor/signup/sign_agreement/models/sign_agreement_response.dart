/// status : true
/// message : "Agreement signed successfully!"
/// data : []
/// code : 200

class SignAgreementResponse {
  SignAgreementResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  SignAgreementResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        //data?.add(Dynamic.fromJson(v));
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