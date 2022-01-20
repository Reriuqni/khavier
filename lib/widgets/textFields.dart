import 'package:admin/constants/colors.dart';
import 'package:admin/constants/measurements.dart';
import 'package:flutter/material.dart';

class OwnTextField extends StatelessWidget{
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextInputType?  keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  OwnTextField({
    this.hintText,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.keyboardType});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: iconColor),
        labelText: labelText,
        hintStyle: TextStyle(color: iconColor),
        hintText: hintText,
        fillColor: bgColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 2.0),
        ),
      ),
    );
  }
}

class OwnTextFieldWithIcons extends StatelessWidget{
  final String? hintText;
  final String? labelText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final String? initialValue;
  final TextInputType?  keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  OwnTextFieldWithIcons({
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.initialValue,
    this.prefixIcon,
    this.onChanged,
    this.controller,
    this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: iconColor),
        labelStyle: TextStyle(color: iconColor),
        contentPadding: EdgeInsets.all(17),
        labelText: labelText,
        hintText: hintText,
        fillColor: bgColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 2.0),
        ),
        prefixIcon:  Icon(
          prefixIcon,
          color: iconColor,
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class OwnBigTextField extends StatelessWidget{
  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final TextInputType?  keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  OwnBigTextField({
    this.hintText,
    this.labelText,
    this.initialValue,
    this.onChanged,
    this.controller,
    this.keyboardType});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 6,
      keyboardType: keyboardType,
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelStyle: TextStyle(color: iconColor),
        labelText: labelText,
        hintStyle: TextStyle(color: iconColor),
        hintText: hintText,
        fillColor: bgColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(defaultBorderRadius)),
          borderSide: BorderSide(
              color: secondaryColor,
              width: 2.0),
        ),
      ),
    );
  }
}
