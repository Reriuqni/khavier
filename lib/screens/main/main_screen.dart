import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

import 'components/side_menu.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreen createState() => _MainScreen();
// }
//
// // class _MainScreen extends StatelessWidget {
// class _MainScreen extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//
//     if (!Responsive.isDesktop(context))
//       return OwnScaffold(
//         key: GlobalKey<ScaffoldState>(),
//         body: getBody(),
//       );
//
//     //don't show appBar + burger for desktop
//     return Scaffold(
//       key: GlobalKey<ScaffoldState>(),
//       body: getBody(),
//     );
//   }
//
//   Widget getBody(){
//     return SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // We want this side menu only for large screen
//             if (Responsive.isDesktop(context))
//               Expanded(
//                 // default flex = 1
//                 // and it takes 1/6 part of the screen
//                 child: SideMenu(),
//               ),
//             Expanded(
//               // It takes 5/6 part of the screen
//               flex: 5,
//               child: DashboardScreen(),
//             ),
//           ],
//         ),
//     );
//   }
// }

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

// class _MainScreen extends StatelessWidget {
class _MainScreen extends State<MainScreen> {
  double _width = 0;
  bool settingsShow = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                colorFilter:
                    ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                alignment: Responsive.isDesktop(context)
                    ? Alignment.topCenter
                    : Alignment.center,
                fit: BoxFit.cover,
                image: NetworkImage("assets/assets/images/home.jpg"))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(
              onPressed: () {
                setState(() {
                  settingsShow = !settingsShow;
                  _width = _width == 0 ? 260 : 0;
                });
              },
            ),
            AnimatedContainer(
                width: _width,
                height: MediaQuery.of(context).size.height - 118,
                duration: Duration(milliseconds: 200),
                child: Material(
                  type: MaterialType.transparency,
                  child: SideMenu(),
                )),
          ],
        ),
      ),
    ));
  }
}
