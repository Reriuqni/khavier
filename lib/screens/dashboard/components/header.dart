// import 'package:admin/controllers/MenuController.dart';
import 'dart:html';
import 'dart:io';

import 'package:admin/responsive.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/scaffold.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:admin/widgets/buttons.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool searchField = false;
  bool settingsShow = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.fromLTRB(100, 15, 100, 15),
            color: Color(0xB2000000),
            child: Column(
              children: [
                // if (!Responsive.isDesktop(context))
                //   IconButton(
                //     icon: Icon(Icons.menu),
                //     onPressed: context.read<MenuController>().controlMenu,
                //   ),
                // if (!Responsive.isMobile(context))
                //   Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                // Expanded(child: SearchField()),
                // ProfileCard()
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(secondaryColor)),
                      child: SvgPicture.asset(
                          'assets/icons/exclamation-square.svg',
                          width: 20,
                          height: 20,
                          color: primaryColor),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          settingsShow = settingsShow == false ? true : false;
                        });
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(secondaryColor)),
                      child: SvgPicture.asset('assets/icons/cog.svg',
                          width: 20, height: 20, color: primaryColor),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(secondaryColor)),
                      child: SvgPicture.asset('assets/icons/user.svg',
                          width: 20, height: 20, color: primaryColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(secondaryColor)),
                      child: SvgPicture.asset('assets/icons/sign-out.svg',
                          width: 20, height: 20, color: primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (searchField == false)
                      Row(
                        children: [
                          Image.asset('assets/images/logo_white.png'),
                          Text(
                            'MATTERS',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )
                        ],
                      ),
                    if (searchField == true)
                      SizedBox(
                        width: 700,
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Search',
                              labelStyle: TextStyle(color: primaryColor)),
                        ),
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          searchField = searchField == false ? true : false;
                        });
                      },
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(secondaryColor)),
                      child: SvgPicture.asset('assets/icons/search.svg',
                          width: 20, height: 20, color: primaryColor),
                    ),
                  ],
                ),
              ],
            )),
        if (settingsShow == true)
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 630,
                  width: 260,
                  child: Material(
                    type: MaterialType.transparency,
                    child: SideMenu(),
                  ))
            ],
          )
      ],
    ));
  }
}
