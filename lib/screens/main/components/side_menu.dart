import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/globals.dart' as globals;

class SideMenu extends StatefulWidget {
  final Color color;
  const SideMenu({this.color = const Color(0xB2000000)});

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
        color: widget.color,
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
                title: 'Organization',
                subTitle: 'Manage your business entities',
                press: (){
                  Navigator.pushNamed(context, '/organizations');
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
                title: 'Matter Templates',
                subTitle: 'Manage your matter processes',
                press: (){}),
            DrawerListSubTile(
                title: 'Matter Management',
                subTitle: 'Who can manage matters',
                press: (){}),
            DrawerListSubTile(
                title: 'User Group Management',
                subTitle: 'Who can manage your user group(s)',
                press: (){}),
            DrawerListSubTile(
                title: 'User Management',
                subTitle: 'Who can manage your user',
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
      shape: Border(top: BorderSide(color: primaryColor, width: 5)),
      horizontalTitleGap: 0.0,
      // leading: SvgPicture.asset(
      //   svgSrc,
      //   color: Colors.black54,
      //   height: 16,
      // ),
      title: Text(
        title,
        style: TextStyle(color: Colors.cyan.shade700, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.8),
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
          hoverColor: headerColor,
          onTap: press,
          child: Container(
            padding: EdgeInsets.fromLTRB(25, 5, 0, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title!, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500, )),
              Text(subTitle!, style: TextStyle(color: Colors.cyan.shade700, fontSize: 10))
            ],
          )
      ),
    );
  }
}
