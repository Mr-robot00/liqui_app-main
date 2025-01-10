import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';

class OTPAutoFill {
  static OTPAutoFill? _singleton;
  static const MethodChannel _channel = MethodChannel('otp_autofill');
  final StreamController<String> _code = StreamController.broadcast();

  factory OTPAutoFill() => _singleton ??= OTPAutoFill._();

  OTPAutoFill._() {
    _channel.setMethodCallHandler(_didReceive);
  }

  Future<void> _didReceive(MethodCall method) async {
    if (method.method == 'otpcode') {
      _code.add(method.arguments);
    }
  }

  Stream<String> get code => _code.stream;

  Future<void> listenForCode({String smsCodeRegexPattern = '\\d{4,6}'}) async {
    if (!Platform.isAndroid) return Future.value();
    await _channel.invokeMethod('listenForCode',
        <String, String>{'smsCodeRegexPattern': smsCodeRegexPattern});
  }

  Future<void> unregisterListener() async {
    if (!Platform.isAndroid) return Future.value();
    await _channel.invokeMethod('unregisterListener');
  }

  Future<String> get getAppSignature async {
    if (!Platform.isAndroid) return Future.value("not supported");
    final String? appSignature = await _channel.invokeMethod('getAppSignature');
    return appSignature ?? '';
  }
}

mixin CodeAutoFill {
  final OTPAutoFill _autoFill = OTPAutoFill();
  String? code;
  StreamSubscription? _subscription;

  void listenForCode({String? smsCodeRegexPattern}) {
    if (!Platform.isAndroid) return;
    _subscription = _autoFill.code.listen((code) {
      this.code = code;
      codeUpdated();
    });
    (smsCodeRegexPattern == null)
        ? _autoFill.listenForCode()
        : _autoFill.listenForCode(smsCodeRegexPattern: smsCodeRegexPattern);
  }

  Future<void> cancel() async {
    if (!Platform.isAndroid) return Future.value();
    return _subscription?.cancel();
  }

  Future<void> unregisterListener() {
    if (!Platform.isAndroid) return Future.value();
    return _autoFill.unregisterListener();
  }

  void codeUpdated();
}
