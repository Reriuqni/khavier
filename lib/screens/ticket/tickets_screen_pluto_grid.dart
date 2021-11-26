import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/responsive.dart';
import 'package:admin/utils.dart';
// import 'package:data_table_2/data_table_2.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dashboard/components/header.dart';
import '../main/components/side_menu.dart';

class TicketsScreenPlutoGrid extends StatefulWidget {
  @override
  State<TicketsScreenPlutoGrid> createState() => _TicketsScreenPlutoGrid();
}

class _TicketsScreenPlutoGrid extends State<TicketsScreenPlutoGrid> {
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
                    Navigator.pushNamed(
                      context,
                      '/addticket',
                      arguments: ScreenArguments(),
                    );
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
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
    List<PlutoColumn> columns = [
      /// Text Column definition
      PlutoColumn(
        title: 'ID',
        field: 'text_field_id',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Name',
        field: 'text_field_name',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Body',
        field: 'text_field_body',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Status',
        field: 'text_field_status',
        type: PlutoColumnType.text(),
      ),

      /// Number Column definition
      PlutoColumn(
        title: 'number column',
        field: 'number_field',
        type: PlutoColumnType.number(),
      ),

      /// Select Column definition
      PlutoColumn(
        title: 'select column',
        field: 'select_field',
        type: PlutoColumnType.select(['item1', 'item2', 'item3']),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: 'Date',
        field: 'date_field',
        type: PlutoColumnType.date(),
      ),

      /// Time Column definition
      PlutoColumn(
        title: 'time column',
        field: 'time_field',
        type: PlutoColumnType.time(),
      ),
      // PlutoColumn(
      //   title: 'Opt column',
      //   field: 'time_opt',
      //   type: PlutoColumnType.time(),
      // ),
    ];

    return provider.tickets.isEmpty // tickets.isEmpty
        ? Center(child: Text('No Tickets', style: TextStyle(fontSize: 20)))
        : Container(
            padding: const EdgeInsets.all(30),
            child: PlutoGrid(
                columns: columns,
                // rows: rows,
                rows: List.generate(
                  provider.tickets.length,
                  (index) {
                    return PlutoRow(
                      cells: {
                        'text_field_id':
                            PlutoCell(value: provider.tickets[index].id),
                        'text_field_name':
                            PlutoCell(value: provider.tickets[index].name),
                        'text_field_body':
                            PlutoCell(value: provider.tickets[index].body),
                        'text_field_status':
                            PlutoCell(value: provider.tickets[index].status),
                        'number_field': PlutoCell(value: 2020),
                        'select_field': PlutoCell(value: 'item1'),
                        'date_field': PlutoCell(
                            value: provider.tickets[index]
                                .date), // 'date_field': PlutoCell(value: '2020-08-06'),
                        'time_field': PlutoCell(
                            value: provider.tickets[index]
                                .date), // 'time_field': PlutoCell(value: '12:30'),
                        // 'time_opt': PlutoCell(
                        //     value: Row(
                        //   children: [
                        //     IconButton(
                        //         onPressed: () {
                        //           Navigator.pushNamed(context, '/editticket',
                        //               arguments: ScreenArguments(
                        //                   ticket: provider.tickets[index]));
                        //           // arguments: ScreenArguments(ticketId: data.id));
                        //         },
                        //         icon: Icon(Icons.edit, color: Colors.blue),
                        //         hoverColor: Colors.blue[50]),
                        //     Padding(
                        //       padding: const EdgeInsets.only(right: 16),
                        //     ),
                        //     IconButton(
                        //       onPressed: () async {
                        //         final provider = Provider.of<TicketsProvider>(
                        //             context,
                        //             listen: false);
                        //         provider.removeTicket(provider.tickets[index]);
                        //       },
                        //       icon: Icon(Icons.delete, color: Colors.blue),
                        //       hoverColor: Colors.blue[50],
                        //     ),
                        //   ],
                        // )),
                      },
                    );
                  },
                ),
                onRowDoubleTap: (event) => {print(event)},
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);
                },
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  print(event);
                }),
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
                      // arguments: ScreenArguments(ticketId: data.id));
                      arguments: ScreenArguments(ticket: data));
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
