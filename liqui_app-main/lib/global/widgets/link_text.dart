import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';

class LinkText extends StatelessWidget {
  final String linkLabel;
  final String linkUrl;

  const LinkText({Key? key, required this.linkLabel, required this.linkUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: linkLabel.tr,
        style: myStyle.defaultTitleFontStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () => myHelper.openUrl(linkUrl),
      ),
    );
  }
}
