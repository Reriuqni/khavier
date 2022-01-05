import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants/measurements.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:admin/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/widgets/buttons.dart';
import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
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
                OwnButtonWithICon(
                  onPressed: () async {
                    Navigator.pushNamed(
                      context,
                      '/addticket',
                      arguments: ScreenArguments(),
                    );
                  },
                  icon: Icons.add,
                  label: "Add New",
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
    return StreamBuilder<List<Ticket>>(
      stream: FirebaseApi.readTickets(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            print('ConnectionState.waiting');
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final tickets = snapshot.data;

              final provider = Provider.of<TicketsProvider>(context);
              provider.setTickets(tickets);

              return getTicketsView(provider);
            }
        }
      },
    );
  }

  Widget getTicketsView(provider) {
    return provider.tickets.isEmpty // tickets.isEmpty
        ? Center(child: Text('No Tickets', style: TextStyle(fontSize: 20)))
        : DataTable2(
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
                label: Text("Body"),
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
                return recentTicketDataRow(provider.tickets[index]);
              },
            ),
          );
  }

  DataRow recentTicketDataRow(data) {
    return DataRow(
      cells: [
        DataCell(Text(data.id)),
        DataCell(Text(data.name ?? '')),
        DataCell(Text(data.body ?? '')),
        DataCell(Text(data.status ?? '')),
        DataCell(Text(data.type ?? '')),
        // DataCell(Text(data.date)),
        DataCell(Text(Utils.fromDateTimeToJson(data.date).toString())),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/editticket',
                      arguments: ScreenArguments(ticket: data));
                  // arguments: ScreenArguments(ticketId: data.id));
                },
                icon: Icon(Icons.edit, color: Colors.blue),
                hoverColor: Colors.blue[50]),
            Padding(
              padding: const EdgeInsets.only(right: 16),
            ),
            IconButton(
              onPressed: () async {
                final provider =
                    Provider.of<TicketsProvider>(context, listen: false);
                provider.removeTicket(data);
              },
              icon: Icon(Icons.delete, color: Colors.blue),
              hoverColor: Colors.blue[50],
            ),
          ],
        )),
      ],
      // onSelectChanged: (isSelected) {
      //   if (isSelected) {
      //     Navigator.pushNamed(context, '/editticket',
      //         arguments: ScreenArguments(ticketId: data.id));
      //     setState(() {});
      //   }
      // }
    );
  }
}

// class ScreenArguments {
//   final String ticketId;
//   final Ticket ticket;

//   ScreenArguments({this.ticketId, this.ticket});
// }

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.blue),
      ),
    );
