// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ok_kosher/utils/colors_utils.dart';
import 'package:ok_kosher/utils/contants.dart';


// ignore: must_be_immutable
class CommonTextFormFields extends StatelessWidget {
  final Widget? icon;
  int maxLine = 1;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String hintTxt;
  final Function? onTap;
  final bool? enable;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final AutovalidateMode? autovalidateMode;
  final TextEditingController? controller;
  final Function? onTapForSuffix;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color? color;
  final Color? fontcolor;
  final Color? borderColor;
  final Color? hintColor;
  final void Function(String)? onEditingComplete;
  CommonTextFormFields({
    Key? key,
    this.icon,
    this.suffixIcon,
    required this.hintTxt,
    this.onTap,
    this.maxLine = 1,
    this.enable,
    this.validator,
    this.onChanged,
    this.autovalidateMode,
    this.controller,
    this.onTapForSuffix,
    this.focusNode,
    this.color,
    this.onEditingComplete,
    this.obscureText,
    this.fontcolor,
    this.borderColor,
    this.hintColor, this.inputFormatters,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          autovalidateMode: autovalidateMode,
          enabled: enable ?? true,
          onTap: () {
            onTap!();
            print("asdfasdsa");
          },
          inputFormatters: inputFormatters,
          style: TextStyle(
              color: fontcolor ?? blackColor,
              fontWeight: FontWeight.w400,
              fontSize: 14,
              fontFamily: ROBOTO_FONT
          ),
          obscureText: obscureText ?? false,
          onFieldSubmitted: onEditingComplete,
          validator: validator,
          cursorColor: fontcolor??textColor,
          onChanged: onChanged,
          maxLines: maxLine,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
                vertical:  0, horizontal: 16),
            hintText: hintTxt,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
                color: hintColor ?? textColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                fontFamily: ROBOTO_FONT),
            focusColor: Colors.transparent,
            filled: true,
            fillColor: color ?? lightGrayColor,
            prefixIcon: icon,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                BorderSide(color: borderColor ?? Colors.transparent)),
          )),
    );
  }
}