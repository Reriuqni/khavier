import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants.dart';
// import 'package:admin/provider/UserProvider.dart';
import 'package:admin/responsive.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/screens/main/components/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

double _width = 0;

class Header extends StatefulWidget {
  final void Function()? tapCog;
  final void Function()? tapSquare;
  final void Function()? tapUser;
  final void Function()? tapMore;
  final void Function()? tapBurger;
  final Animation? controller;
  Header(
      {this.tapCog,
      this.tapSquare,
      this.tapUser,
      this.tapMore,
      this.tapBurger,
      this.controller});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> with SingleTickerProviderStateMixin {
  bool searchField = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            color: headerColor,
            child: Container(
              padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  HeaderIcons(
                    tapCog: () {
                      setState(() {
                        _width = _width == 0 ? 260 : 0;
                      });
                    },
                    tapSquare: () {},
                    tapUser: () {},
                  )
                ],
              ),
            )),
        Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
            color: Color(0xB2000000),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (searchField == false)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            'assets/images/logo2.png',
                            width: 280,
                            height: 54,
                          ),
                          OwnAnimatedTextButton(
                            childText: 'MATTERS',
                            onPressed: () {
                              Navigator.pushNamed(context, '/main');
                            },
                          )
                        ],
                      ),
                    if (searchField == true)
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 300,
                          child: Material(
                            type: MaterialType.transparency,
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Search',
                                  labelStyle: TextStyle(color: primaryColor)),
                              style: TextStyle(color: primaryColor),
                            ),
                          )),
                    OwnAnimatedButton(
                        onTap: () {
                          setState(() {
                            searchField = !searchField;
                          });
                        },
                        child: FaIcon(
                          FontAwesomeIcons.search,
                          size: 20,
                        ))
                  ],
                ),
              ],
            )),
        SideMenuContainer(
          width: _width,
          height: MediaQuery.of(context).size.height - 134,
        )
      ],
    ));
  }
}

class HeaderIcons extends StatefulWidget {
  final void Function()? tapCog;
  final void Function()? tapSquare;
  final void Function()? tapUser;

  HeaderIcons({this.tapCog, this.tapSquare, this.tapUser});

  @override
  State<HeaderIcons> createState() => _HeaderIcons();
}

class _HeaderIcons extends State<HeaderIcons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OwnAnimatedButton(
          onTap: () {},
          child: FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            size: 17,
            color: primaryColor,
          ),
        ),
        OwnAnimatedButton(
          onTap: widget.tapCog,
          child: FaIcon(
            FontAwesomeIcons.cog,
            size: 17,
            color: primaryColor,
          ),
        ),
        OwnAnimatedButton(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/profile',
            );
          },
          child: FaIcon(
            FontAwesomeIcons.user,
            size: 17,
            color: primaryColor,
          ),
        ),
        OwnAnimatedButton(
          onTap: () {
            FirebaseAuth.instance.signOut();
            // userProvider.signOut();
            // Navigator.pushNamed(context, '/login');
          },
          child: FaIcon(
            FontAwesomeIcons.signOutAlt, 
            size: 17,
            color: primaryColor,            
          ),
        ),
      ],
    );
  }
}

class SideMenuContainer extends StatelessWidget {
  final double width;
  final double height;
  SideMenuContainer({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: width,
        height: height,
        duration: Duration(milliseconds: 200),
        child: Material(
          type: MaterialType.transparency,
          child: SideMenu(),
        ));
  }
}
