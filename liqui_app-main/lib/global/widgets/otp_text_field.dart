import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/print_log.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../constants/index.dart';
import 'otp_auto_fill.dart';

class OTPTextField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;

  const OTPTextField({
    super.key,
    required this.controller,
    required this.onCompleted,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> with CodeAutoFill {
  @override
  void initState() {
    // printSmsSignature();
    super.initState();
    listenForCode();
  }

  @override
  void dispose() {
    cancel();
    unregisterListener();
    super.dispose();
  }

  void printSmsSignature() async {
    printLog('AppSignature: ${await OTPAutoFill().getAppSignature}');
  }

  @override
  Widget build(BuildContext context) {
    context.theme;
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: const TextStyle(
        color: buttonColor,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      animationType: AnimationType.none,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeColor: buttonColor,
        inactiveColor: buttonColor,
        selectedFillColor: transparentColor,
        activeFillColor: transparentColor,
        inactiveFillColor: transparentColor,
      ),
      cursorColor: Get.isDarkMode ? whiteColor : blackColor,
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      beforeTextPaste: (text) {
        return true;
      },
      autoFocus: true,
    );
  }

  @override
  void codeUpdated() {
    if (widget.controller.text != code) {
      widget.controller.text = code ?? "";
    }
    //listen again
    unregisterListener();
    listenForCode();
  }
}
