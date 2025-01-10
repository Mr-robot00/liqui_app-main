import 'package:liqui_app/global/utils/storage/my_local.dart';

class UserData {
  String? _userId;
  String? _userName;
  String? _userNumber;
  String? _userEmail;
  String? _userPAN;
  String? _userDob;
  String? _userGender;

  set userId(String? value) => _userId = value;

  String get userId => _userId ?? myLocal.oldInvestorId;

  set userName(String? value) => _userName = value;

  String get userName => _userName ?? myLocal.userName;

  set userNumber(String? value) => _userNumber = value;

  String get userNumber => _userNumber ?? myLocal.userNumber;

  set userEmail(String? value) => _userEmail = value;

  String get userEmail => _userEmail ?? myLocal.userEmail;

  set userPAN(String? value) => _userPAN = value;

  String get userPAN => _userPAN ?? myLocal.userPAN;

  set userDob(String? value) => _userDob = value;

  String get userDob => _userDob ?? "";

  set userGender(String? value) => _userGender = value;

  String get userGender => _userGender ?? "";

  UserData({
    String? userId,
    String? userName,
    String? userNumber,
    String? userEmail,
    String? userPAN,
    String? referralCode,
    String? userDob,
    String? userGender,
  }) {
    _userId = userId;
    _userName = userName;
    _userNumber = userNumber;
    _userEmail = userEmail;
    _userPAN = userPAN;
    _userDob = userDob;
    _userGender = userGender;
  }

  UserData.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userName = json['user_name'];
    _userNumber = json['user_number'];
    _userEmail = json['user_email'];
    _userPAN = json['user_pan'];
    _userDob = json['user_dob'];
    _userGender = json['user_gender'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_name'] = _userName;
    map['user_number'] = _userNumber;
    map['user_email'] = _userEmail;
    map['user_pan'] = _userPAN;
    map['user_dob'] = _userDob;
    map['user_gender'] = _userGender;
    return map;
  }
}
