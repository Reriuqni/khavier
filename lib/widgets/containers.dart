import 'package:admin/screens/main/components/side_menu.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:admin/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/constants/globals.dart' as globals;
import '../constants/colors.dart';
import '../screens/dashboard/components/header.dart';
import '../screens/dashboard/components/headerResponsive.dart';
import 'buttons.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class HeaderAndSideMenu extends StatelessWidget {
  final Widget widget;
  HeaderAndSideMenu({required this.widget});

  @override
  Widget build(BuildContext context) {
    return Stack (
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: Responsive.isDesktop(context) ? 134 : 60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (Responsive.isDesktop(context))
                Container(
                    alignment: Alignment.topCenter,
                    width: 260,
                    child: SideMenu()),
              Container(
                  width: MediaQuery.of(context).size.width-260,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: widget,
                  ))
            ],
          ),
        ),
        StackHeader()
      ],
    );
  }
}

class StackHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (Responsive.isDesktop(context))
          Header(),
        if (!Responsive.isDesktop(context))
          HeaderResponsive()
      ],
    );
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
            setState(() {
              globals.width = 0;
            });
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

class TabsMainContainer extends StatelessWidget {
  final List<Widget> children;
  TabsMainContainer({this.children = const []});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
          ),
        ));
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final String label;
  final dynamic onChanged;
  final dynamic initialValue;
  RowItem(
      {this.text = '',
        this.label = 'Default',
        this.onChanged,
        this.initialValue
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                width: 300,
                child: Text(
                  text,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                width: 300,
                child: OwnTextField(
                  onChanged: onChanged,
                  labelText: label,
                  initialValue: initialValue,
                ),
              ),
            ],
          ),
      // child: Wrap(
      //   alignment: WrapAlignment.start,
      //   crossAxisAlignment: WrapCrossAlignment.end,
      //   children: [
      //     Column(
      //       children: [
      //         Container(
      //           padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
      //           width: 300,
      //           child: Text(
      //             text,
      //             textAlign: TextAlign.end,
      //             style: TextStyle(
      //               fontSize: 16,
      //               fontWeight: FontWeight.w500,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      //           width: 300,
      //           child: OwnTextField(
      //             onChanged: onChanged,
      //             labelText: label,
      //             initialValue: initialValue,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Container(
      //         padding: EdgeInsets.all(5),
      //         child: Container(
      //           width: 175,
      //           child: widget,
      //         ))
      //   ],
      // ),
    );
  }
}

class RadioRow extends StatelessWidget {
  final Color color;
  final String textRadio;
  final String text0;
  final String text1;
  final String text2;
  final String text3;
  final Widget radioWidget;
  RadioRow(
      {this.color = Colors.black,
        this.textRadio = '',
        this.text0 = '',
        this.text1 = '',
        this.text2 = '',
        this.text3 = '',
        required this.radioWidget
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
            child: Row(
              children: [
                radioWidget,
                Text(textRadio, style: TextStyle(color: color, fontWeight: FontWeight.w600),),
              ],
            )
        ),
        Expanded(
          flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(text0, style: TextStyle(color: color, fontWeight: FontWeight.w600),),
                Text(text1, style: TextStyle(color: color, fontWeight: FontWeight.w600),),
                Text(text2, style: TextStyle(color: color, fontWeight: FontWeight.w600),),
                Text(text3, style: TextStyle(color: color, fontWeight: FontWeight.w600),)
              ],
        ))
      ],
    );
  }
}

class ColorPickerItem extends StatelessWidget{
  final Color colorVariable;
  final void Function() onSelect;
  final colorsNameMap;
  final String title;
  ColorPickerItem({required this.colorVariable, required this.onSelect, this.colorsNameMap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 16),),
        subtitle: Text(
          // ignore: lines_longer_than_80_chars
          '${ColorTools.materialNameAndCode(colorVariable, colorSwatchNameMap: colorsNameMap)} '
              'aka ${ColorTools.nameThatColor(colorVariable)}',
            style: TextStyle(fontSize: 14)
        ),
        trailing: ColorIndicator(
          width: 44,
          height: 44,
          borderRadius: 4,
          hasBorder: true,
          borderColor: Color(0xB2000000),
          color: colorVariable,
          onSelectFocus: false,
          onSelect: onSelect
        ),
      ),
    );
  }
}

class UGBrandingImage extends StatelessWidget{
  final String text;
  final String image;
  final void Function()? onPressed;
  UGBrandingImage({required this.onPressed, required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        width: 350,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: TextStyle(fontSize: 18)),
            Image.asset(
              image,
              width: 150,
              height: 100,
            ),
            OwnButton(label: 'Browse', onPressed: onPressed,),
          ],
        )
    );
  }
}





