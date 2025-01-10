import 'package:flutter/material.dart';

class MyChoiceChip extends StatelessWidget {
  final Widget label;
  final bool selected;
  final TextStyle? labelStyle;
  final Color? disabledColor;
  final Color? selectedColor;
  final EdgeInsetsGeometry? labelPadding;
  final ValueChanged<bool>? onSelected;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final Widget? avatar;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool isDisable;

  const MyChoiceChip({
    Key? key,
    required this.label,
    required this.selected,
    this.labelStyle,
    this.disabledColor,
    this.selectedColor,
    this.labelPadding,
    this.onSelected,
    this.backgroundColor,
    this.padding,
    this.shape,
    this.avatar,
    this.visualDensity,
    this.materialTapTargetSize,
    this.isDisable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      materialTapTargetSize: materialTapTargetSize,
      padding: padding,
      label: label,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      disabledColor: disabledColor,
      selectedColor: selectedColor,
      onSelected: onSelected,
      backgroundColor: backgroundColor,
      avatar: avatar,
      selected: selected,
      shape: shape,
      visualDensity: visualDensity,
    );
  }
}
