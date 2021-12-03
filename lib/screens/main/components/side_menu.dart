import 'package:admin/constants.dart';
import 'package:flutter/cupertino.dart'; //2do: is need?
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 77.0,
            color: secondaryColor,
            child: DrawerHeader(
              margin: EdgeInsets.all(15.0),
              padding: EdgeInsets.all(0.0),
              child: Image.asset("assets/images/logo.png"),
            ),
          ),

          // DrawerListTile(
          //   title: "Admin panel",
          //   svgSrc: "assets/icons/menu_dashbord.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/');
          //   },
          // ),
          // DrawerListTile(
          //   title: "Alerts & Reports",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/reports');
          //   },
          // ),
          DrawerListTile(
            title: "Ticket system",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamed(context, '/tickets');
            },
          ),
          DrawerListTile(
            title: "Ticket system PG",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamed(context, '/tickets_pluto_grid');
            },
          ),
          // DrawerListTile(
          //   title: "Matters",
          //   svgSrc: "assets/icons/menu_doc.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/matters');
          //   },
          // ),
          // DrawerListTile(
          //   title: "Chat",
          //   svgSrc: "assets/icons/menu_store.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/chat');
          //   },
          // ),
          // DrawerListTile(
          //   title: "Notification",
          //   svgSrc: "assets/icons/menu_notification.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/notification');
          //   },
          // ),
          // DrawerListTile(
          //   title: "System Settings",
          //   svgSrc: "assets/icons/menu_setting.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/settings');
          //   },
          // ),
          // DrawerListTile(
          //   title: "My Account",
          //   svgSrc: "assets/icons/menu_profile.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/myaccount');
          //   },
          // ),
          DrawerListTile(
              title: 'Platform settings',
              press: () {
                Navigator.pushNamed(context, '/login');
              }),
          DrawerListSubTile(title: 'Details', subTitle: 'Contact Info, SSL, Time Zone', press: () {}),
          DrawerListSubTile(title: 'Billing', subTitle: 'Gateway, Accounting, Currency, Taxes', press: () {}),
          DrawerListSubTile(title: 'Pricing', subTitle: 'Set & Select Pricing Models', press: () {}),
          DrawerListSubTile(title: 'Branding', subTitle: 'Login, Home Page, Language, Custom Fields', press: () {}),
          DrawerListSubTile(title: 'Notices', subTitle: 'System Messages, Reports, Logs', press: () {}),
          SizedBox(height: 10),

          DrawerListTile(title: 'Access', press: () {}),
          DrawerListSubTile(title: 'User Groups', subTitle: 'Manage your business entities', press: () {}),
          DrawerListSubTile(title: 'Users', subTitle: 'Manage your users', press: () {}),
          DrawerListSubTile(title: 'Tags', subTitle: 'Manage tags for system customization', press: () {}),
          SizedBox(height: 10),

          DrawerListTile(title: 'Management', press: () {}),
          DrawerListSubTile(title: 'Matter Templates', subTitle: 'Manage your matter processes', press: () {}),
          DrawerListSubTile(title: 'Matter Management', subTitle: 'Who can manage matters', press: () {}),
          DrawerListSubTile(
              title: 'User Group Management', subTitle: 'Who can manage your user group(s)', press: () {}),
          DrawerListSubTile(title: 'User Management', subTitle: 'Who can manage your user', press: () {}),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    // @required this.svgSrc,
    this.svgSrc,
    @required this.press,
  }) : super(key: key);

  final String title;
  final String svgSrc;
  final VoidCallback press;

  getW() {
    return svgSrc == null 
    ? SizedBox(height: 0) 
    :SvgPicture.asset(
        svgSrc,
        color: Colors.black54,
        height: 16,
      );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: Border(top: BorderSide(color: secondaryColor)),
      hoverColor: secondaryColor,
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: getW(),
      // leading:/ SvgPicture.asset(
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
    Key key,
    // For selecting those three line once press "Command+D"
    @required this.title,
    this.subTitle,
    @required this.press,
  }) : super(key: key);

  final String title, subTitle;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
      child: InkWell(
          hoverColor: secondaryColor,
          onTap: press,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )),
              Text(subTitle, style: TextStyle(color: Colors.cyan.shade700, fontSize: 10))
            ],
          )),
    );
  }
}
