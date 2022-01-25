import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/containers.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

// class _MainScreen extends StatelessWidget {
class _MainScreen extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: SafeArea(

    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: "Main screen",
      primaryColor: Theme.of(context).primaryColor.value, // This line is required
    ));

    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                  alignment: Responsive.isDesktop(context)
                      ? Alignment.topCenter
                      : Alignment.center,
                  fit: Responsive.isDesktop(context)
                      ? BoxFit.cover
                      : BoxFit.fitHeight,
                  image: AssetImage("assets/images/home.jpg"))),
          child:Stack(
            children: [
              StackHeader()
            ],
          )
      ),
    );
  }
}

