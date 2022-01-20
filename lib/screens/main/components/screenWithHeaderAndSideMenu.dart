import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/responsive.dart';

class HeaderAndSideMenu extends StatelessWidget {
  final Widget widget;
  HeaderAndSideMenu({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 134 : 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 1,
                  child: SideMenu()),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: widget,
                ))
            ],
          ),
        ),
        StackHeader()
      ],
    );
  }
}
