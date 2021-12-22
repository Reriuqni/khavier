import 'package:admin/constants.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header.dart';
import 'package:admin/screens/dashboard/components/headerResponsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreen createState() => _MainScreen();
}

// class _MainScreen extends StatelessWidget {
class _MainScreen extends State<MainScreen> with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
  // return SingleChildScrollView(
     //   child: SafeArea(
  
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
            // ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                  alignment: Responsive.isDesktop(context) ? Alignment.topCenter : Alignment.center,
                fit: Responsive.isDesktop(context) ? BoxFit.cover : BoxFit.fitHeight,
                  image: NetworkImage("assets/assets/images/home.jpg")
              )
            ),
          child: OverflowBox(
            maxWidth: MediaQuery.of(context).size.width,
            minWidth: MediaQuery.of(context).size.width-200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                if (Responsive.isDesktop(context))
                  Header(),
                if (!Responsive.isDesktop(context))
                  HeaderResponsive()
                                ],
                              ),
            )
      ),
    );
  }
}
