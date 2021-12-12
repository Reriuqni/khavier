import 'package:admin/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/buttons.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  final void Function() tapCog;
  final void Function() tapSquare;
  final void Function() tapUser;
  final void Function() tapMore;
  final void Function() tapBurger;
  final Animation controller;
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
        if (Responsive.isDesktop(context))
          Container(
              color: headerColor,
              child: Container(
                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    HeaderIcons(
                      tapCog: widget.tapCog,
                      tapSquare: widget.tapSquare,
                      tapUser: widget.tapUser,
                    )
                  ],
                ),
              )),
        if (!Responsive.isDesktop(context))
          Container(
              color: headerColor,
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        OwnAnimatedButton(
                          width: 35,
                          // onTap: () => setState(() {
                          //   _burger = !_burger;
                          //   _burger ? controller.forward() : controller.reverse();
                          //
                          // }),
                          onTap: widget.tapBurger,
                          child: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: widget.controller,
                              size: 25),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/images/logo2.png',
                          width: 250,
                          height: 50,
                        ),
                      ],
                    ),
                    OwnAnimatedButton(
                      width: 35,
                      onTap: widget.tapMore,
                      child: Icon(
                        Icons.more_vert,
                        color: primaryColor,
                        size: 25,
                      ),
                    )
                  ],
                ),
              )),
        if (Responsive.isDesktop(context))
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
                          children: [
                            Image.asset('assets/images/logo2.png'),
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
                              ),
                            )),
                      OwnAnimatedButton(
                        onTap: () {
                          setState(() {
                            searchField = !searchField;
                          });
                        },
                        child: SvgPicture.asset(
                          'assets/icons/Search.svg',
                          width: 20,
                          height: 20,
                          color: primaryColor,
                        ),
                      )
                    ],
                  ),
                ],
              )),
      ],
    ));
  }
}

class HeaderIcons extends StatefulWidget {
  final void Function() tapCog;
  final void Function() tapSquare;
  final void Function() tapUser;

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
          onTap: widget.tapSquare,
          child: SvgPicture.asset('assets/icons/exclamation-square.svg',
              width: 15, height: 15, color: primaryColor),
        ),
        OwnAnimatedButton(
          onTap: widget.tapCog,
          child: SvgPicture.asset('assets/icons/cog.svg',
              width: 15, height: 15, color: primaryColor),
        ),
        OwnAnimatedButton(
          onTap: widget.tapUser,
          child: SvgPicture.asset('assets/icons/user.svg',
              width: 15, height: 15, color: primaryColor),
        ),
        OwnAnimatedButton(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: SvgPicture.asset('assets/icons/sign-out.svg',
              width: 15, height: 15, color: primaryColor),
        ),
      ],
    );
  }
}
