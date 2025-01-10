import 'dart:convert';

class DocumentListResponse {
  DocumentListResponse({
      this.status, 
      this.message, 
      this.data, 
      this.code,});

  DocumentListResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    code = json['code'];
  }
  bool? status;
  String? message;
  String? data;
  int? code;

  Map<String, dynamic> toJson() {
    final  map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] =  data;
    map['code'] = code;
    return map;
  }

  @override
  String toString() {
    return jsonEncode(this);
  }
}

class KYCDocModel {
  KYCDocModel(
      this.id,
      this.label,
      );

  String id;
  String label;

  @override
  String toString() {
    return "Id: $id, Label: $label";
  }
}