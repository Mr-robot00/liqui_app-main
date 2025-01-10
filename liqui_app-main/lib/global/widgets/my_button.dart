import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
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

  const MyButton({
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
    this.avoidIntrusions = true,
    this.alignment,
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
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: buttonPadding,
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shape: shape,
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
