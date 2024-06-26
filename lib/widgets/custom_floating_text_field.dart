import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:traer/provider/custom_text_style.dart';
import 'package:traer/provider/theme_helper.dart';

class CustomFloatingTextField extends StatelessWidget {
  CustomFloatingTextField({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputFormater,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.labelText,
    this.labelStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final List<TextInputFormatter>? textInputFormater;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final String? labelText;

  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final RegExp regex = RegExp(r"^[a-zA-Z0-9\s\-_.,?!@#$%^&*()]*$");


  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: floatingTextFieldWidget,
          )
        : floatingTextFieldWidget;
  }

  Widget get floatingTextFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? CustomTextStyles.titleMediumPrimaryContainer_1,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          inputFormatters: textInputFormater ?? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(regex)
          ],
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );
  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        floatingLabelBehavior : FloatingLabelBehavior.always,
        hintStyle: hintStyle ?? CustomTextStyles.titleMediumPrimaryContainer_1,
        labelText: labelText ?? "",
        labelStyle: labelStyle,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.fromLTRB(10, 29, 10, 10),
        fillColor: fillColor ?? appTheme.gray10001,
        filled: filled,
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
      );
}

/// Extension on [CustomFloatingTextField] to facilitate inclusion of all types of border style etc
extension FloatingTextFormFieldStyleHelper on CustomFloatingTextField {
  static OutlineInputBorder get custom => OutlineInputBorder(
        borderSide: BorderSide.none,
      );
}
