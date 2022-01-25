import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/constants/globals.dart' as globals;
import '../../../constants/colors.dart';
import '../../../widgets/containers.dart';


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
        // Іконки в правій частині хедера
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
                        globals.width = globals.width == 0 ? 260 : 0;
                      });
                    },
                    tapSquare: () {},
                    tapUser: () {},
                  )
                ],
              ),
            )),
        // Іконки в правій частині хедера

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
                          ElevatedButton(
                            style: ButtonStyle(
                              shadowColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/');
                            },
                            child: Image.asset(
                              'assets/images/header_logo_white.png',
                              width: 280,
                              height: 54,
                            ),
                          ),
                          OwnAnimatedTextButton(
                            fontSize: 20,
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17, horizontal: 10),
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
                          color: primaryColor,
                        ))
                  ],
                ),
              ],
            )),
        SideMenuContainer(
          width: globals.width,
          height: MediaQuery.of(context).size.height - 134,
        )
      ],
    ));
  }
}

