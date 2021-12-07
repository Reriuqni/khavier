// import 'package:admin/controllers/MenuController.dart';
import 'dart:html';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:admin/responsive.dart';
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
  final void Function() onPressed;
  Header({
    this.onPressed
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool searchField = false;
  Color _color = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
              color: Color(0xff100c0c),
              child: Container(
                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AnimatedButton(
                      onTap: () {},
                      child: SvgPicture.asset('assets/icons/exclamation-square.svg', width: 15, height: 15, color: primaryColor),
                    ),
                    AnimatedButton(
                      onTap: widget.onPressed,
                      child: SvgPicture.asset('assets/icons/cog.svg', width: 15, height: 15, color: primaryColor),
                    ),
                    AnimatedButton(
                      onTap: () {},
                      child: SvgPicture.asset('assets/icons/user.svg', width: 15, height: 15, color: primaryColor),
                    ),
                    AnimatedButton(
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: SvgPicture.asset('assets/icons/sign-out.svg', width: 15, height: 15, color: primaryColor),
                    ),
                  ],
                ),
              )
            ),
            Container(
            margin: EdgeInsets.all(0),
                padding: EdgeInsets.fromLTRB(100, 10, 100, 10),
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
                    SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (searchField == false)
                      Row(
                        children: [
                              Image.asset('assets/images/logo2.png'),
                              RichText(
                                text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                  text: 'MATTERS',
                                  style: TextStyle(fontSize: 25, color: Colors.white),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushNamed(context, '/main')),
                                  ],
                                ),
                              ),
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
                                    labelStyle: TextStyle(color: primaryColor)
                        ),
                      ),
                            )
                          ),
                        AnimatedButton(
                          onTap: () {
                        setState(() {
                            searchField = !searchField;
                        });
                      },
                          child: SvgPicture.asset('assets/icons/search.svg', width: 20, height: 20, color: primaryColor),
                        )
                      ],
                    ),
                  ],
                )
                ),
              ],
          )

    );
  }
}
