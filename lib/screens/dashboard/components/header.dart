// import 'package:admin/controllers/MenuController.dart';

// import 'package:provider/provider.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class Header extends StatefulWidget {
  final void Function() onPressed;

  Header({this.onPressed});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool searchField = false;
  int _currentHoverIndex = -1;

  callback(bool isHover, int index) {
    setState(() {
      _currentHoverIndex = isHover ? index : -1;
    });
  }

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
                    callback: callback,
                    index: 0,
                    onTap: () {},
                    child: SvgPicture.asset(
                        'assets/icons/exclamation-square.svg',
                        width: 15,
                        height: 15,
                        color: (0 == _currentHoverIndex)
                            ? colorIconHover
                            : primaryColor),
                  ),
                  AnimatedButton(
                    callback: callback,
                    index: 1,
                    onTap: widget.onPressed,
                    child: SvgPicture.asset('assets/icons/cog.svg',
                        width: 15,
                        height: 15,
                        color: (1 == _currentHoverIndex)
                            ? colorIconHover
                            : primaryColor),
                  ),
                  AnimatedButton(
                    callback: callback,
                    index: 2,
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/user.svg',
                        width: 15,
                        height: 15,
                        color: (2 == _currentHoverIndex)
                            ? colorIconHover
                            : primaryColor),
                  ),
                  AnimatedButton(
                    callback: callback,
                    index: 3,
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: SvgPicture.asset('assets/icons/sign-out.svg',
                        width: 15,
                        height: 15,
                        color: (3 == _currentHoverIndex)
                            ? colorIconHover
                            : primaryColor),
                  ),
                ],
              ),
            )),
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
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'MATTERS',
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.white),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.pushNamed(
                                          context, '/main')),
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
                                  labelStyle: TextStyle(color: primaryColor)),
                            ),
                          )),
                    AnimatedButton(
                      callback: callback,
                      index: -1,
                      onTap: () {
                        setState(() {
                          searchField = !searchField;
                        });
                      },
                      child: SvgPicture.asset('assets/icons/search.svg',
                          width: 20, height: 20, color: primaryColor),
                    )
                  ],
                ),
              ],
            )),
      ],
    ));
  }
}
