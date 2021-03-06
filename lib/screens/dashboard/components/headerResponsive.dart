import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/buttons.dart';
import '../../../constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/constants/branding.dart' as branding;
import '../../../widgets/containers.dart';

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
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            color: branding.topToolbarBackground,
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
                            _widthBurger = _widthBurger == 0 ? 220 : 0;
                            _heightIcons = 0;
                            _width = 0;
                          });
                        },
                        child: AnimatedIcon(
                            icon: AnimatedIcons.menu_close,
                            progress: controller,
                            size: 25,
                            color: branding.topToolbarIcon),
                      ),
                      SizedBox(
                        width: 10,
                      ),
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
                          width: 210,
                          height: 50,
                        ),
                        /* 
                          // working analog is:
                          child: Image.asset(
                            'assets/images/header_logo_white.png',
                            width: 210,
                            height: 50,
                          ), 
                        */
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
                      color: branding.topToolbarIcon,
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
                  width: 160,
                  height: _heightIcons,
                  decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _heightIcons == 0
                                ? Colors.transparent
                                : primaryColor,
                            width: 1)),
                    color: branding.topToolbarBackground,
                  ),
                  duration: Duration(milliseconds: 200),
                  child: Visibility(
                    visible: _heightIcons == 0 ? false : true,
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [HeaderIcons(
                      tapUser: () {},
                      tapSquare: () {},
                      ),],
                    )
                  )
                    ),
            ]),
      ],
    ));
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
          color: branding.topToolbarBackground,
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
                  Container(
                      padding: EdgeInsets.only(top: 5),
                      width: 165,
                      child: Material(
                        type: MaterialType.transparency,
                        child: TextFormField(
                          style: TextStyle(color: branding.topToolbarSearchText),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                              labelText: 'Search',
                            labelStyle: TextStyle(color: branding.topToolbarSearchText, fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  color: branding.topToolbarSearchTextBorder,
                                  width: 2.0),
                            ),
                          ),

                        ),
                      )),
                  OwnAnimatedButton(
                    onTap: () {},
                    child: FaIcon(
                      FontAwesomeIcons.search,
                      size: 15,
                      color: branding.topToolbarIcon,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: OwnAnimatedTextButton(
                childText: 'MATTERS',
                fontSize: 15,
                onPressed: () {
                  Navigator.pushNamed(context, '/main');
                },
                ),
              ),
              SideMenuContainer(width: _widthBurger, height: 470)
            ],
          ),
        ));
  }
}
