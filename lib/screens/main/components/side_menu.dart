import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/globals.dart' as globals;
import 'package:admin/constants/branding.dart' as branding;

class SideMenu extends StatefulWidget {
  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {


  void closeSideMenu() {
    setState(() {
      globals.width = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: branding.sideToolbarBackground,
        height: MediaQuery.of(context).size.height - 134,
        child:
        ListView(
          shrinkWrap: true,
          children: [
            DrawerListTile(
                title: 'Platform settings',
            ),
            DrawerListSubTile(
                title: 'Details',
                press: (){}),
            DrawerListSubTile(
                title: 'Billing',
                press: (){}),
            DrawerListSubTile(
                title: 'Pricing',
                press: (){}),
            DrawerListSubTile(
                title: 'Branding',
                press: (){}),
            DrawerListSubTile(
                title: 'Notices',
                press: (){}),
            SizedBox(height: 10),

            DrawerListTile(
                title: 'Access',
            ),
            DrawerListSubTile(
                title: 'User Groups',
                press: (){
                  Navigator.pushNamed(context, '/userGroups');
                  closeSideMenu();
                }),
            DrawerListSubTile(
                title: 'Users',
                press: (){
                  Navigator.pushNamed(context, '/users');
                  closeSideMenu();
                }),
            DrawerListSubTile(
                title: 'Tags',
                press: (){}),
            SizedBox(height: 10),

            DrawerListTile(
                title: 'Management',
            ),
            DrawerListSubTile(
                title: 'Access Rights',
                press: (){}),
          ],
        ),
      )
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    // @required this.svgSrc,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      mouseCursor: MouseCursor.defer,
      shape: Border(top: BorderSide(color: branding.sideToolbarSeparationBar, width: 5)),
      horizontalTitleGap: 0.0,
      // leading: SvgPicture.asset(
      //   svgSrc,
      //   color: Colors.black54,
      //   height: 16,
      // ),
      title: Text(
        title,
        style: TextStyle(color: branding.sideToolbarInformation, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.8),
      ),
    );
  }
}

class DrawerListSubTile extends StatelessWidget {
  const DrawerListSubTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String? title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
        overlayColor: MaterialStateProperty.all(iconColor),
          hoverColor: branding.sideToolbarHover,
          onTap: press,
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: TextStyle(color: branding.sideToolbarHeading, fontSize: 14, fontWeight: FontWeight.w500, )),
            ],
          )
      ),
    );
  }
}
