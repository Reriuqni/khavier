import 'package:admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/main/components/side_menu.dart';

class OwnScaffold extends StatelessWidget{
  final Key key;
  final Widget body;
  OwnScaffold({this.key, this.body});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Header(),
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: iconColor),
      ),
      drawer: SideMenu(),
      key: key,
      body: body,
    );
  }
}

class OwnContainer extends StatelessWidget{
  final double height;
  final double width;
  final double padding;
  final Widget child;
  OwnContainer({this.height, this.width, this.padding, this.child});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(defaultBorderRadius)),
        border: Border.all(width: 1.0, color: secondaryColor)
      ),
      child: child,
    );
  }
}

