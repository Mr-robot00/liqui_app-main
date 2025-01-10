import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';

class CountDownTimer extends StatefulWidget {
  final Duration interval;
  final int timerMaxSeconds;
  final int currentSeconds;
  final VoidCallback? onComplete;
  final bool showIcon;

  const CountDownTimer({
    Key? key,
    this.interval = const Duration(seconds: 1),
    required this.timerMaxSeconds,
    this.currentSeconds = 0,
    this.onComplete,
    this.showIcon = false,
  }) : super(key: key);

  @override
  CountDownTimerState createState() => CountDownTimerState();
}

class CountDownTimerState extends State<CountDownTimer> {
  late Duration interval;
  late int timerMaxSeconds;
  late int currentSeconds;
  bool finished = false;

  // String get timerText =>
  //     '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  String get timerText => "${timerMaxSeconds - currentSeconds}";

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          // printLog(timer.tick);
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) {
            timer.cancel();
            stopTimer();
          }
        });
      }
    });
  }

  stopTimer() {
    timerMaxSeconds = 0;
    currentSeconds = 0;
    finished = true;
    _onComplete();
    if (mounted) setState(() {});
  }

  void _onComplete() {
    if (widget.onComplete != null) widget.onComplete!();
  }

  @override
  void initState() {
    super.initState();
    interval = widget.interval;
    timerMaxSeconds = widget.timerMaxSeconds;
    currentSeconds = widget.currentSeconds;
    if (timerMaxSeconds > 0) {
      startTimeout();
    } else {
      stopTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.showIcon)
          Icon(
            Icons.timer,
            size: fontSize20,
            color: finished
                ? Colors.red
                : Get.isDarkMode
                    ? whiteColor
                    : fontDesColor,
          ),
        const SizedBox(width: padding5),
        Text(
          timerText,
          style: TextStyle(
            fontSize: fontSize12,
            fontFamily: "Poppins",
            color: finished ? Colors.red : buttonColor,
          ),
        ),
        const SizedBox(width: padding5),
      ],
    );
  }
}
