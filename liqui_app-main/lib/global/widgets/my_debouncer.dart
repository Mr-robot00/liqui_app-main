import 'package:flutter/foundation.dart';
import 'dart:async';

class MyDeBouncer {
  final int milliseconds;
  Timer? _timer;

  MyDeBouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
final myDeBouncer = MyDeBouncer(milliseconds: 500);
