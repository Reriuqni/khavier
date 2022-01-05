import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import '../../../constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double _widthBurger = 0;
bool _burger = false;

class HeaderResponsive extends StatefulWidget {
  @override
  State<HeaderResponsive> createState() => _HeaderResponsiveState();
}

class _HeaderResponsiveState extends State<HeaderResponsive>
    with SingleTickerProviderStateMixin {
  double _width = 0;
  double _heightIcons = 0;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    // DO YOUR STUFF
  }

  @override
  void dispose() {
    // DO YOUR STUFF
    super.dispose();
  }

  void tapBurger() {
    _burger = false;
    _burger ? controller.forward() : controller.reverse();
    _widthBurger = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: GestureDetector(
            onTap: () {
              setState(() {
                _width = 0;
                _heightIcons = 0;
                tapBurger();
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                onTap: () {
                                  setState(() {
                                    _burger = !_burger;
                                    _burger
                                        ? controller.forward()
                                        : controller.reverse();
                                    _widthBurger = _widthBurger == 0 ? 200 : 0;
                                    _heightIcons = 0;
                                    _width = 0;
                                  });
                                },
                                child: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: controller,
                                    size: 25,
                                    color: primaryColor),
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
                            onTap: () {
                              setState(() {
                                _heightIcons = _heightIcons == 0 ? 100 : 0;
                                _width = 0;
                                tapBurger();
                              });
                            },
                            child: Icon(
                              Icons.more_vert,
                              color: primaryColor,
                              size: 25,
                            ),
                          )
                        ],
                      ),
                    )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flex(
                        direction: Axis.horizontal,
                        textDirection: TextDirection.rtl,
                        children: [
                          Visibility(
                            visible: _burger ? false : true,
                            child: SideMenuContainer(
                              width: _width,
                              height: MediaQuery.of(context).size.height - 70,
                            ),
                          ),
                          BurgerMenuContainer(),
                        ],
                      ),
                      AnimatedContainer(
                          width: 200,
                          height: _heightIcons,
                          decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: _heightIcons == 0
                                        ? Colors.transparent
                                        : primaryColor,
                                    width: 1)),
                            color: headerColor,
                          ),
                          duration: Duration(milliseconds: 200),
                          child: Visibility(
                            visible: _heightIcons == 0 ? false : true,
                            child: HeaderIcons(
                              tapCog: () {
                                setState(() {
                                  _width = _width == 0 ? 200 : 0;
                                  _heightIcons = 0;
                                  tapBurger();
                                });
                              },
                              tapUser: () {},
                              tapSquare: () {},
                            ),
                          )),
                    ]),
              ],
            )));
  }
}

class BurgerMenuContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: _widthBurger,
        height: MediaQuery.of(context).size.height - 70,
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: _widthBurger == 0 ? Colors.transparent : primaryColor,
                  width: 1)),
          color: headerColor,
        ),
        duration: Duration(milliseconds: 200),
        child: Visibility(
          visible: _burger ? true : false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                      width: 140,
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextFormField(
                          style: TextStyle(color: primaryColor),
                          decoration: InputDecoration(
                              labelText: 'Search',
                              labelStyle:
                                  TextStyle(color: primaryColor, fontSize: 15)),
                        ),
                      )),
                  OwnAnimatedButton(
                    onTap: () {},
                    child: FaIcon(
                      FontAwesomeIcons.search,
                      size: 20,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              OwnAnimatedTextButton(
                childText: 'MATTERS',
                fontSize: 15,
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
              )
            ],
          ),
        ));
  }
}
