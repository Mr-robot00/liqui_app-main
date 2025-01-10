import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:liqui_app/global/constants/app_constants.dart';
import 'package:liqui_app/global/utils/helpers/my_helper.dart';
import 'package:liqui_app/global/utils/my_style.dart';

class MyInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? initialValue;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final Color? fillColor;
  final bool? filled;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final ValueChanged<String>? onFieldSubmitted;
  final String? counterValue;
  final Iterable<String>? autofillHints;
  final int? errorMaxLines;

  const MyInputField({
    super.key,
    this.hint,
    this.label,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.obscureText = false,
    this.inputFormatters,
    this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.focusNode,
    this.initialValue,
    this.textStyle,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.fillColor = filledColor,
    this.filled = true,
    this.errorText,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
    this.textInputAction,
    this.onTap,
    this.onTapOutside,
    this.onFieldSubmitted,
    this.counterValue,
    this.autofillHints,
    this.errorMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    context.theme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.validString)
          Text(
            label!,
            style: labelStyle ?? myStyle.defaultLabelStyle,
          ),
        if (label.validString)
          SizedBox(
            height: spaceS,
          ),
        TextFormField(
          autofillHints: autofillHints,
          controller: controller,
          autofocus: autofocus,
          focusNode: focusNode,
          // initialValue: initialValue,
          style: textStyle ?? myStyle.defaultFontStyle,
          decoration: InputDecoration(
            counterText: counterValue,
            contentPadding: myHelper.isTablet
                ? const EdgeInsets.all(padding16)
                : const EdgeInsets.all(padding12),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor.withOpacity(0.8)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Get.isDarkMode
                      ? grayLightColor.withOpacity(0.8)
                      : fontTitleColor.withOpacity(0.2)),
            ),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.withOpacity(0.5),
              ),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: redColor.withOpacity(0.5), width: 1.5),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: fontTitleColor.withOpacity(0.2),
              ),
            ),
            hintText: hint,
            hintStyle: hintStyle ?? myStyle.defaultHintFontStyle,
            prefixIcon: prefix,
            suffixIcon: suffix,
            fillColor: Get.isDarkMode ? fontDesColor : fillColor,
            filled: filled,
            errorText: errorText,
            errorStyle: errorStyle,
            errorMaxLines: errorMaxLines,
          ),
          maxLength: maxLength,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          textCapitalization: textCapitalization,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          readOnly: readOnly,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: autoValidateMode,
          textInputAction: textInputAction,
          onTap: onTap,
          onTapOutside: onTapOutside,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ],
    );
  }
}
