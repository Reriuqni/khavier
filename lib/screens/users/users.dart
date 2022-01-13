import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/model/ticket_static.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:admin/utils.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textField.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/screens/main/main_screen.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> with RestorationMixin {
  RestorableBoolN inviteCheckBox = RestorableBoolN(false);
  RestorableBoolN archivedCheckBox = RestorableBoolN(false);

  @override
  String get restorationId => 'checkbox_demo';

  @override
  void restoreState(restorationBucket, bool initialRestore){
  registerForRestoration(inviteCheckBox, 'checkbox_a');
  registerForRestoration(archivedCheckBox, 'checkbox_b');
  }

  @override
  void dispose() {
    inviteCheckBox.dispose();
    archivedCheckBox.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.88,
              height: MediaQuery.of(context).size.height * 0.81,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Users', style: TextStyle(color: iconColor, fontSize: 20, fontWeight: FontWeight.w600),),
                      Row(
                        children: [
                          Checkbox(
                              activeColor: secondaryColor,
                              value: inviteCheckBox.value,
                              onChanged: (value){
                                setState(() {
                                  inviteCheckBox.value = value;
                                });
                              }
                          ),
                          SizedBox(width: 5,),
                          Text('Show Invites', style: TextStyle(color: iconColor, fontSize: 16,)),
                          Container(
                            padding: EdgeInsets.fromLTRB(30, 0, 15, 0),
                            child: OwnButton(
                               onPressed: () {},
                               label: 'Invite',
                             ),
                          ),
                          OwnButtonICon(
                            onPressed: () async {
                              Navigator.pushNamed(
                                context,
                                '/profile',
                                arguments: 'newUser',
                              );
                            },
                            icon: Icons.add,
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: DropdownButtonFormField(
                          hint: Text('Organization'),
                          onChanged: (String? newValue) {
                            setState(() {
                              // _type = newValue;
                            });
                          },
                          //тимчасові айтеми
                          items: <String>[
                            '',
                            'Need',
                            'Maybe',
                            'Whatelse',
                            'Forgoted'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                      ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: OwnTextFieldWithIcons(
                          labelText: 'Jim',
                          prefixIcon: FontAwesomeIcons.search,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: archivedCheckBox.value,
                                onChanged: (value) {
                                  setState(() {
                                    archivedCheckBox.value = value;
                                  });
                                }),
                            SizedBox(width: 5,),
                            Text('Show Archived', style: TextStyle(color: iconColor, fontSize: 16,)),
                          ],
                        ),
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
            StackHeader()
          ],
        ),
      )
    ) ;
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
      child: Material(
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
      )
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
            Material(
              type: MaterialType.transparency,
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/editticket',
                        // arguments: ScreenArguments(ticketId: data.id));
                        arguments: ScreenArguments(ticket: data));
                  },
                  icon: Icon(Icons.edit, color: Colors.blue),
                  hoverColor: Colors.blue[50]),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16),
            ),
            Material(
              type: MaterialType.transparency,
              child: IconButton(
                onPressed: () async {
                  final provider =
                  Provider.of<TicketsProvider>(context, listen: false);
                  provider.removeTicket(data);
                },
                icon: Icon(Icons.delete, color: Colors.blue),
                hoverColor: Colors.blue[50],
              ),
            )
            ,
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
