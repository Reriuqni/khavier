import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/controllers/MenuController.dart';

class OwnTextField extends StatelessWidget{
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  OwnTextField({this.hintText, this.labelText, this.controller});


  @override
  Widget build(BuildContext context) {
    return TextField(
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
  final TextEditingController? controller;
  OwnTextFieldWithIcons({this.hintText, this.labelText, this.suffixIcon, this.controller, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintStyle: TextStyle(color: iconColor),
        labelStyle: TextStyle(color: iconColor),
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
  final TextEditingController? controller;
  OwnBigTextField({this.hintText, this.labelText, this.controller});


  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 6,
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
