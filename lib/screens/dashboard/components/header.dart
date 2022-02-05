import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/constants/globals.dart' as globals;
import 'package:admin/constants/branding.dart' as branding;
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
            color: branding.topToolbarBackground,
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
            color: branding.topToolbarBackground,
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
                              branding.topToolbarLogo,
                              width: 280,
                              height: 54,
                            ),
                          ),
                          OwnAnimatedTextButton(
                            fontSize: 20,
                            childText: 'SETTINGS',
                            onPressed: () {
                              setState(() {
                                globals.width = globals.width == 0 ? 200 : 0;
                              });
                            },
                          ),
                          SizedBox(width: 80,),
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
                                  labelStyle: TextStyle(color: branding.topToolbarSearchText),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: branding.topToolbarSearchTextBorder,
                                        width: 2.0),
                                  ),
                              ),
                              style: TextStyle(color: branding.topToolbarSearchText),
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
        Container(
          padding: EdgeInsets.only(left: 400),
          child: SideMenuContainer(
            height: 470,
          width: globals.width,
          ),
        )
      ],
    ));
  }
}

