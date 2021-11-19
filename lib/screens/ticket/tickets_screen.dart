import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/model.dart';
import 'package:admin/model/ticket.dart';
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';
import '../dashboard/components/recent_files.dart';
import '../main/components/side_menu.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Model model;
  bool ticketsLoad = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<Model>(context);
    if (ticketsLoad) {
      model.db.getTickets();
      ticketsLoad = false;
    }

    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
              child: Header(),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      Ticket ticket = Ticket();
                      ticket.id = await model.db.getTicketID();

                      Navigator.pushNamed(
                        context,
                        '/addticket',
                        arguments: ScreenArguments(
                          'Extract Arguments Screen',
                          'This message is extracted in the build method.',
                          ticket,
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add New"),
                  ),
                ),
              ],
            ),
            // Expanded(child: RecentFiles()),
            Expanded(
              child: getTicketsView(),
            ),
          ],
        ),
      ),
    ]));
  }

  Widget getTicketsView() {
    ListTile getListTile(data) {
      return ListTile(
        title: Text(data['id']),
        subtitle: Text(data['name']),
      );
    }

    Card getCard(data) {
      return Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: SizedBox(
            width: 300,
            height: 100,
            child: Text(data['name'] + '-------' + data['name']),
          ),
        ),
      );
    }

    return FutureBuilder<QuerySnapshot>(
      future: model.db.ticketsFB.get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              print('document.id ' + document.id);
              // data.forEach((k, v) => print('$k: $v'));

              return getCard(data);
            }).toList(),
          );
        }

        return Text("loading");
      },
    );
  }
}

class ScreenArguments {
  final String title;
  final String message;
  Ticket ticket;

  ScreenArguments(this.title, this.message, this.ticket);
}
