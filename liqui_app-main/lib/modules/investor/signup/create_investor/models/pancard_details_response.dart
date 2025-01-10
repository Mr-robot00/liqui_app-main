/// status : true
/// message : "Pan card verified."
/// data : {"name":"SATAT  MISHRA"}
/// code : 200

class PanCardDetailsResponse {
  PanCardDetailsResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  PanCardDetailsResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? json['data'] is List
        ? null
        : PanCardModel.fromJson(json['data'])
        : null;
    code = json['code'];
  }

  bool? status;
  String? message;
  PanCardModel? data;
  num? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    //map['data'] = data?.toJson();

    if (data != null) {
      map['data'] = data?.toJson();
    }

    map['code'] = code;
    return map;
  }
}

/// name : "SATAT  MISHRA"

class PanCardModel {
  PanCardModel({
    this.name,
  });

  PanCardModel.fromJson(dynamic json) {
    name = json['name'];
  }

  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }
}
