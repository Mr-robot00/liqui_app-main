import 'package:flutter/material.dart';

import '../constants/index.dart';

class RoundedContainer extends StatelessWidget {
  final double radius;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? borderColor;
  final Widget? child;
  final bool shadow;
  final bool border;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? shadowColor;
  final AlignmentGeometry? alignment;

  const RoundedContainer({
    super.key,
    this.radius = 0,
    this.height,
    this.width,
    this.backgroundColor,
    this.borderColor,
    this.child,
    this.shadow = false,
    this.border = false,
    this.margin,
    this.padding,
    this.shadowColor,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        border: Border.all(
            color: border ? borderColor ?? transparentColor : transparentColor),
        boxShadow: [
          shadow
              ? BoxShadow(
                  color: shadowColor ?? transparentColor,
                  blurRadius: 4,
                  offset: const Offset(0, 2), // Shadow position
                )
              : const BoxShadow(color: transparentColor)
        ],
        color: backgroundColor ?? whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }
}
