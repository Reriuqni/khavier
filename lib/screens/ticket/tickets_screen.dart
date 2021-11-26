import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/db.dart';
import 'package:admin/model/model.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/provider/TicketsProvider.dart';
// import 'package:admin/model/ticket.dart';
import 'package:admin/responsive.dart';
import 'package:admin/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';
// import '../dashboard/components/recent_files.dart';
import '../main/components/side_menu.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  // Model model;
  // Model model;
  // var model ;
  // late Model model = Model();
  // late DataBase model = DataBase();
  // bool ticketsLoad = true;
  var provider;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //  model = context.watch<Model>();
    // model = Provider.of<Model>(context);
    // if (ticketsLoad) {
    //   model.db.getTickets();
    //   ticketsLoad = false;
    // }

    provider = Provider.of<TicketsProvider>(context);

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
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    // await model.db.getTicketID();

                    Navigator.pushNamed(
                      context,
                      '/addticket',
                      arguments: ScreenArguments(),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
                //
                //
                //
                // SizedBox(height: 20),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () async {
                    provider = Provider.of<TicketsProvider>(context, listen: false);
                    
                    print(provider.tickets.length);
                    
                    setState(() {});
                  },
                  icon: Icon(Icons.refresh),
                  label: Text("Refresh"),
                ),
              ],
            ),
            // Expanded(child: RecentFiles()),
            Expanded(
              // child: getTicketsView(),
              child: getConsumerTicketView(),
            ),
          ],
        ),
      ),
    ]));
  }

  Widget getConsumerTicketView() {
    print('Inside getConsumerTicketView()');
    return StreamBuilder<List<Ticket>>(
      stream: FirebaseApi.readTickets(),
      builder: (context, snapshot) {
        print('Inside builder:');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: 
              print('ConnectionState.waitin');            
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              print('Something Went Wrong Try later');
              print(snapshot.hasError);
              print(snapshot);
              return buildText('Something Went Wrong Try later');
            } else {
              print('tickets = snapshot.data;');
              
              final tickets = snapshot.data;

              print('snapshot.data: ' + snapshot.data.length.toString());

              provider = Provider.of<TicketsProvider>(context);
              provider.setTickets(tickets);
              print('provider.tickets (getConsumerTicketView): ' + provider.tickets.length.toString());

              // return tabs[selectedIndex];
              return getTicketsView();
            }
        }
      },
    );
  }

  Widget getConsumerTicketView0() {
    return Consumer<DataBase>(
      // return Consumer<Model>(
      builder: (context, cart, child) {
        // print(cart.db.ticketsFB.doc().collection('tickets').get().);
        // print(cart.db.tickets.length);
        // print(cart.db.tickets.length);
        // print(cart.db.tickets.length);
        // model = cart;
        return getTicketsView();
      },
    );
  }

  Widget getTicketsView() {
    provider = Provider.of<TicketsProvider>(context);
    final tickets = provider.tickets;
    print('getTicketsView: length = ' + provider.tickets.length.toString());

    // print('provider.tickets (getTicketsView): ' + provider.tickets.length.toString());

    return tickets.isEmpty
        ? Center(child: Text('No Tickets', style: TextStyle(fontSize: 20)))
        : DataTable2(
            // showCheckboxColumn: true,R
            // dataRowColor: MaterialStateProperty.all(Colors.green[100]),
            columnSpacing: defaultPadding,
            minWidth: 600,
            columns: [
              DataColumn(
                label: Text("ID"),
              ),
              DataColumn(
                label: Text("Name"),
              ),
              DataColumn(
                label: Text("Status"),
              ),
              DataColumn(
                label: Text("Type"),
              ),
              DataColumn(
                label: Text("Date"),
              ),
              DataColumn(
                label: Text("Options"),
              ),
            ],
            rows: List.generate(
              provider.tickets.length,
              (index) {
                print(index);
                print(provider.tickets[index]);
                return recentTicketDataRow(provider.tickets[index]);
              },
            ),
          );
  }

  DataRow recentTicketDataRow(data) {
    return DataRow(
        cells: [
          DataCell(Text(data.id)),
          DataCell(Text(data.name)),
          DataCell(Text(data.status)),
          DataCell(Text(data.type)),
          // DataCell(Text(data.date)),
          DataCell(Text(Utils.fromDateTimeToJson(data.date).toString())),
          DataCell(Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editticket',
                        arguments: ScreenArguments(ticketId: data.id));
                    setState(() {});
                  },
                  icon: Icon(Icons.edit, color: Colors.blue),
                  hoverColor: Colors.blue[50]),
              Padding(
                padding: const EdgeInsets.only(right: 16),
              ),
              IconButton(
                onPressed: () async {
                  print('before delete');                  
                  provider.removeTicketById(data.id);
                  print('after delete');
                  // await model.db
                  //     // await model
                  //     .deleteTicket(data.id)
                  //     .whenComplete(() => setState(() {
                  //           model.db.getTickets();
                  //           // model.getTickets();
                  //           print('inside setState');
                  //         }));
                  // print('after await delete');
                },
                icon: Icon(Icons.delete, color: Colors.blue),
                hoverColor: Colors.blue[50],
              ),
            ],
          )),
        ],
        onSelectChanged: (isSelected) {
          // if (isSelected!) {
          //   Navigator.pushNamed(context, '/editticket',
          //       arguments: ScreenArguments(ticketId: data.id));
          //   setState(() {});
          // }
        });
  }
}

DateFormat(String s) {
}

class ScreenArguments {
  final String ticketId;
  final Ticket ticket;

  ScreenArguments({this.ticketId, this.ticket});
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.blue),
      ),
    );
