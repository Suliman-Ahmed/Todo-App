import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  var textStyle;
  var labelStyle;
  var hintTextStyle;
  var titleStyle;
  var prefixIcon;
  var suffixIcon;
  var hintText;
  var labelText;
  var title;
  var obscured;
  var hasTitle;
  var hasTitleIcon;
  var titleIcon;
  var textInputType;
  var onChanged;
  var validator;
  var inputFormatters;
  var width;
  var height;
  var contentPadding;
  var margin;

  CustomTextFormField({
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyle,
    this.hintTextStyle,
    this.labelStyle,
    this.titleStyle,
    this.titleIcon,
    this.hasTitleIcon = false,
    this.title,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
    this.margin,
    this.hasTitle = false,
    this.hintText,
    this.labelText,
    this.obscured = false,
    this.textInputType,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(200),
          border: Border.all(color: Colors.black,width: 1)),
      child: TextFormField(
        style: textStyle,
        keyboardType: textInputType,
        onChanged: onChanged,
        validator: validator,
        inputFormatters: inputFormatters,
        controller: controller, 
        obscuringCharacter: '*',
        decoration: InputDecoration(
          contentPadding: contentPadding,
          labelText: labelText,
          labelStyle: labelStyle,
          border: InputBorder.none,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintTextStyle,
        ),
        obscureText: obscured,
      ),
    );
  }
}
