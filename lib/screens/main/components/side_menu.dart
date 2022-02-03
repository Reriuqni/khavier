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
                subTitle: 'Contact Info, SSL, Time Zone',
                press: (){}),
            DrawerListSubTile(
                title: 'Billing',
                subTitle: 'Gateway, Accounting, Currency, Taxes',
                press: (){}),
            DrawerListSubTile(
                title: 'Pricing',
                subTitle: 'Set & Select Pricing Models',
                press: (){}),
            DrawerListSubTile(
                title: 'Branding',
                subTitle: 'Login, Home Page, Language, Custom Fields',
                press: (){}),
            DrawerListSubTile(
                title: 'Notices',
                subTitle: 'System Messages, Reports, Logs',
                press: (){}),
            SizedBox(height: 10),

            DrawerListTile(
                title: 'Access',
            ),
            DrawerListSubTile(
                title: 'User Groups',
                subTitle: 'Manage your business entities',
                press: (){
                  Navigator.pushNamed(context, '/userGroups');
                  closeSideMenu();
                }),
            DrawerListSubTile(
                title: 'Users',
                subTitle: 'Manage your users',
                press: (){
                  Navigator.pushNamed(context, '/users');
                  closeSideMenu();
                }),
            DrawerListSubTile(
                title: 'Tags',
                subTitle: 'Manage tags for system customization',
                press: (){}),
            SizedBox(height: 10),

            DrawerListTile(
                title: 'Management',
            ),
            DrawerListSubTile(
                title: 'Access Rights',
                subTitle: 'Manage your system access rights',
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
    this.subTitle,
    required this.press,
  }) : super(key: key);

  final String? title, subTitle;
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
              Text(subTitle!, style: TextStyle(color: branding.sideToolbarSubHeading, fontSize: 10))
            ],
          )
      ),
    );
  }
}
