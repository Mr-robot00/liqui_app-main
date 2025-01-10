class CommonResponse {
  late bool status;
  late String message;

  CommonResponse({
    required this.status,
    required this.message,
  });

  CommonResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }
}
