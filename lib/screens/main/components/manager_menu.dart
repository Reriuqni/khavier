import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ManagerMenu extends StatelessWidget {
  const ManagerMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 70.0,
            child: DrawerHeader(
              margin: EdgeInsets.all(0.0),
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'My Solve',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),

          DrawerListTile(
            title: "Admin panel",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          DrawerListTile(
            title: "SignOut",
            svgSrc: "assets/icons/sign-out.svg",
            press: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),


          // DrawerListTile(
          //   title: "Alerts & Reports",
          //   svgSrc: "assets/icons/menu_tran.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/reports');
          //   },
          // ),
          // DrawerListTile(
          //   title: "Ticket system",
          //   svgSrc: "assets/icons/menu_task.svg",
          //   press: () {
          //     Navigator.pushNamed(context, '/tickets');
          //   },
          // ),
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
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.black54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black54),
      ),
    );
  }
}
