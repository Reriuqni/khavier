import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main/components/side_menu.dart';

class SettingsScreen extends StatelessWidget {
  final String _pageName = 'Settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
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
                        ..color = Colors.blue[100],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
