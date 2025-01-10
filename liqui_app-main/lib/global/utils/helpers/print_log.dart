import 'dart:developer';
import 'package:flutter/foundation.dart';

extension PrintLog on dynamic {
  void printLog(
      dynamic value, {
        String? key,
        bool isError = false,
      }) {
    if (isError || kDebugMode) {
      log('${key != null ? '$key \u{2192} ' : ""}$value', name: 'LIQUIMONEY');
    }
  }
}