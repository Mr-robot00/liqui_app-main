/// status : true
/// message : "Statement generated successfully"
/// data : {"file_name":"Liquiloans_statement_2023-08-01_to_2023-08-31","file":"data:application/pdf;base64,JVBERi0xLjcKMSA"}
/// code : 200

class DownloadPassbookResponse {
  DownloadPassbookResponse({
    this.status,
    this.message,
    this.data,
    this.code,
  });

  DownloadPassbookResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] = json['data'] != null
        ? json['data'] is List
            ? null
            : StatementData.fromJson(json['data'])
        : null;

    code = json['code'];
  }

  bool? status;
  String? message;
  StatementData? data;
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

/// file_name : "Liquiloans_statement_2023-08-01_to_2023-08-31"
/// file : "data:application/pdf;base64,JVBERi0xLjcKMSA"

class StatementData {
  StatementData({
    this.fileName,
    this.file,
  });

  StatementData.fromJson(dynamic json) {
    fileName = json['file_name'];
    file = json['file'];
  }

  String? fileName;
  String? file;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file_name'] = fileName;
    map['file'] = file;
    return map;
  }
}
