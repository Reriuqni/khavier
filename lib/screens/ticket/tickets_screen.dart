import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants.dart';
import '../main/components/side_menu.dart';

class TicketsScreen extends StatelessWidget {
  final String _pageName = 'Ticket system';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        // child: Row(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Expanded(
        //       // It takes 5/6 part of the screen
        //       flex: 6,
        //
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Text(
        //             'You pressed menu: ',
        //           ),
        //           Text(
        //             '$_pageName',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 40,
        //               // decorationStyle: TextDecorationStyle.wavy,
        //               foreground: Paint()
        //                 ..style = PaintingStyle.stroke
        //                 ..color = Colors.blue[100]!,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        child: Column(
          children: [
            ElevatedButton(onPressed: ()=> {

            }, child: Text('add new'),

                style: ButtonStyle(
                  // padding: EdgeInsets.only(top: 10.0);
                ),
                    ),
            Padding(padding: EdgeInsets.all(20),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    print('Card tapped.');
                  },
                  child: const SizedBox(
                    width: 300,
                    height: 100,
                    child: Text('A card that can be tapped'),
                  ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
