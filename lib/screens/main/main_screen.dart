import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/side_menu.dart';
import 'package:admin/constants.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

// class _MainScreen extends StatelessWidget {
class _MainScreen extends State<MainScreen> with SingleTickerProviderStateMixin{

  double _width = 0;
  double _widthBurger = 0;
  double _heightIcons = 0;
  bool _burger = false;

  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  void tapBurger() {
    _burger = false;
    _burger ? controller.forward() : controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                  alignment: Responsive.isDesktop(context) ? Alignment.topCenter : Alignment.center,
                fit: BoxFit.cover,
                  image: NetworkImage("assets/assets/images/home.jpg")
              )
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
                tapCog: () {
                setState(() {
                  _width = _width == 0 ? 260 : 0;
                    tapBurger();
                  });
                },
                tapMore: () {
                  setState(() {
                    _heightIcons = _heightIcons == 0 ? 100 : 0;
                    _width = 0;
                    tapBurger();
                });
              },
                tapBurger: () => setState(() {
                      _burger = !_burger;
                      _burger ? controller.forward() : controller.reverse();
                      _widthBurger = _widthBurger == 0 ? 200 : 0;
                      _width = 0;
                }),
                controller: controller,
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_burger == true)
                    AnimatedContainer(
                        width: _widthBurger,
                        height: MediaQuery.of(context).size.height - 118,
                        duration: Duration(milliseconds: 200),
                        child: Material(
                          type: MaterialType.transparency,
                          child: Container(
                            color: headerColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 5,),
                                    SizedBox(
                                        width: 140,
                                        child: Material(
                                          type: MaterialType.transparency,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                                labelText: 'Search',
                                                labelStyle: TextStyle(color: primaryColor, fontSize: 12)
                                            ),
                                          ),
                                        )
                                    ),
                                    OwnAnimatedButton(
                                      onTap: () {
                                      },
                                      child: SvgPicture.asset('assets/icons/Search.svg', width: 20, height: 20, color: primaryColor,),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10,),
                                OwnAnimatedTextButton(
                                  childText: 'MATTERS',
                                  fontSize: 15,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/main');
                                  },
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                  if (_burger == false)
            AnimatedContainer(
                width: _width,
                height: MediaQuery.of(context).size.height - 118,
                duration: Duration(milliseconds: 200),
                child: Material(
                  type: MaterialType.transparency,
                  child: SideMenu(),
                        )
                    ),
                  AnimatedContainer(
                      width: 200,
                      height: _heightIcons,
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _heightIcons == 0 ? Colors.transparent : primaryColor,
                                width: 1)
                        ),
                        color: headerColor,
                      ),
                      duration: Duration(milliseconds: 200),
                      child: Material(
                        type: MaterialType.transparency,
                        child: HeaderIcons(
                          tapCog: () {
                            setState(() {
                              _width = _width == 0 ? 200 : 0;
                              _heightIcons = 0;
                            });
                          },
                          tapUser: (){},
                          tapSquare: (){},
                        ),
                      )
                  ),
                ],
              )
          ],
        ),
      ),
      )
    );
  }
}
