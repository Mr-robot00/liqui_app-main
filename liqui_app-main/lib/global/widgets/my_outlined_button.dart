import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? buttonPadding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;
  final Size? fixedSize;
  final Size? maximumSize;
  final OutlinedBorder? shape;
  final bool avoidIntrusions;
  final AlignmentGeometry? alignment;
  final BorderSide? side;

  const MyOutlinedButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.padding,
    this.margin,
    this.buttonPadding,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.shape,
    this.minimumSize,
    this.fixedSize,
    this.maximumSize,
    this.avoidIntrusions = false,
    this.alignment,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: avoidIntrusions,
      left: avoidIntrusions,
      right: avoidIntrusions,
      bottom: avoidIntrusions,
      child: Container(
        padding: padding,
        margin: margin,
        alignment: alignment,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            padding: buttonPadding,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: shape,
            side: side,
            minimumSize: minimumSize,
            maximumSize: maximumSize,
            fixedSize: fixedSize,
          ),
          child: Text(
            title,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
