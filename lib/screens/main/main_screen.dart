import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:admin/widgets/scaffold.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

// class _MainScreen extends StatelessWidget {
class _MainScreen extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    if (!Responsive.isDesktop(context))
      return OwnScaffold(
        key: GlobalKey<ScaffoldState>(),
        body: getBody(),
      );

    //don't show appBar + burger for desktop
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      body: getBody(),
    );
  }

  Widget getBody(){
    return SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
    );
  }
}
