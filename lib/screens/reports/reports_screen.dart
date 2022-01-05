import 'package:admin/constants/colors.dart';
import 'package:admin/constants/measurements.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/widgets/scaffold.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main/components/side_menu.dart';

class ReportsScreen extends StatefulWidget {
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final String _pageName = 'Alerts & Reports';

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isDesktop(context))
      return OwnScaffold(
        key: context
            .read<MenuController>()
            .scaffoldKey,
        body: getBody(),
      );
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      body: getBody(),
    );
  }

    Widget getBody() {
      return SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You pressed menu: ',
                  ),
                  Text(
                    '$_pageName',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      // decorationStyle: TextDecorationStyle.wavy,
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..color = Colors.blue[100]!,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'OwnButton',
                  ),
                  SizedBox(height: 10,),
                  OwnButton(label: 'Test', onPressed: () =>{},),
                  SizedBox(height: 20,),
                  Text(
                    'OwnButtonWithICon',
                  ),
                  SizedBox(height: 10,),
                  OwnButtonWithICon(label: 'Test', icon: Icons.add, onPressed: () =>{}),
                  SizedBox(height: 20,),
                  Text(
                    'OwnTextButton',
                  ),
                  SizedBox(height: 10,),
                  OwnTextButton(label: 'Test', onPressed: () =>{}),
                  SizedBox(height: 20),
                  Text(
                    'OwnButtonICon',
                  ),
                  SizedBox(height: 10,),
                  OwnButtonICon(
                    icon: Icons.add,
                    onPressed: () => {},
                  ),
                  SizedBox(height: 20),
                  Text(
                    'OwnTextField',
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.all(defaultMargin),
                    child: OwnTextField(
                        labelText: 'TestLabel',
                        hintText: 'TestHint'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'OwnTextFieldWithIcons',
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin: EdgeInsets.all(defaultMargin),
                    child: OwnTextFieldWithIcons(
                        prefixIcon: Icons.eleven_mp,
                        suffixIcon: InkWell(child: Icon(Icons.ten_k, color: iconColor)),
                        labelText: 'TestLabel',
                        hintText: 'TestHint'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'OwnContainer',
                  ),
                  SizedBox(height: 10,),
                  OwnContainer(
                    height: 200,
                    width: 400,
                    child: OwnBigTextField(
                        labelText: 'TestLabel',
                        hintText: 'TestHint',
              ),
            ),
          ],
        ),
      ),
            )
          ],
        )
    );
  }
}
