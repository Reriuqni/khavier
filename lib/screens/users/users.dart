import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/model/user.dart';
import 'package:admin/provider/NewVersionUserProvider.dart';
import 'package:admin/routes/roles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:admin/utils.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textField.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:data_table_2/data_table_2.dart';

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
  void restoreState(restorationBucket, bool initialRestore) {
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
                        Text(
                          'Users',
                          style: TextStyle(
                              color: iconColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: secondaryColor,
                                value: inviteCheckBox.value,
                                onChanged: (value) {
                                  setState(() {
                                    inviteCheckBox.value = value;
                                  });
                                }),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Show Invites',
                                style: TextStyle(
                                  color: iconColor,
                                  fontSize: 16,
                                )),
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
                              SizedBox(
                                width: 5,
                              ),
                              Text('Show Archived',
                                  style: TextStyle(
                                    color: iconColor,
                                    fontSize: 16,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Expanded(child: RecentFiles()),
                    Expanded(
                      // child: getTicketsView(),
                      child: getConsumerUserView(),
                    ),
                  ],
                ),
              ),
              StackHeader()
            ],
          ),
        ));
  }

  Widget getConsumerUserView() {
    return StreamBuilder<List<User>>(
      stream: FirebaseApi.readUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            print('ConnectionState.waiting');
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return buildText('Something Went Wrong Try later');
            } else {
              final users = snapshot.data;

              final provider = Provider.of<NewVersionUserProvider>(context);
              provider.setUsers(users);

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
        field: 'text_field_firstName',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Email',
        field: 'text_field_email',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Mobile',
        field: 'text_field_mobile',
        type: PlutoColumnType.text(),
      ),
      // PlutoColumn(
      //   title: 'Account Type',
      //   field: 'text_field_accountType',
      //   type: PlutoColumnType.text(),
      // ),

      // /// Number Column definition
      // PlutoColumn(
      //   title: 'number column',
      //   field: 'number_field',
      //   type: PlutoColumnType.number(),
      // ),

      // /// Select Column definition
      PlutoColumn(
        title: 'Account Type',
        field: 'select_field_account_type',
        // type: PlutoColumnType.select(['item1', 'item2', 'item3']),
        // type: PlutoColumnType.select(Roles.values.toList()),
        type: PlutoColumnType.select(Roles.values.map((e) => e.name).toList()),
      ),
      PlutoColumn(
        title: 'Manage',
        field: 'manage_user',
        type: PlutoColumnType.select(['Edit']),
      ),

      /// Datetime Column definition
      // PlutoColumn(
      //   title: 'Date',
      //   field: 'date_field_lastSignInTime',
      //   type: PlutoColumnType.date(),
      // ),

      // /// Time Column definition
      // PlutoColumn(
      //   title: 'time column',
      //   field: 'time_field_lastSignInTime',
      //   type: PlutoColumnType.time(),
      // ),

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
                      // print(provider.tickets[index].lastSignInTime);
                      return PlutoRow(
                        cells: {
                          'text_field_id':
                              PlutoCell(value: provider.tickets[index].id),
                          'text_field_firstName': PlutoCell(
                              value: provider.tickets[index].firstName),
                          'text_field_email':
                              PlutoCell(value: provider.tickets[index].email),
                          'text_field_mobile':
                              PlutoCell(value: provider.tickets[index].mobile),
                          // 'text_field_accountType': PlutoCell(
                          //     value: provider.tickets[index].accountType),
                          // 'number_field': PlutoCell(value: 2020),
                          // 'select_field_ex': PlutoCell(value: 'item1'),

                          // 'select_field_account_type': PlutoCell(
                          //     value:
                          //             (provider.tickets[index].accountType as Roles).name),

                          'select_field_account_type': PlutoCell(
                              value: Roles.values.firstWhere(
                                  (e) =>
                                      e.name ==
                                      (provider.tickets[index].accountType
                                              as Roles)
                                          .name,
                                  orElse: () => Roles.ROLE_NOT_FOUND)),
                          'manage_user': PlutoCell(
                              value: 'editUser'
                          ),


                          // 'date_field_lastSignInTime': PlutoCell(
                          //     value: provider.users[index].lastSignInTime),

                          // 'date_field_lastSignInTime':
                          //     PlutoCell(value: '2020-08-06'),

                          // 'time_field_lastSignInTime': PlutoCell(
                          //     value: provider.users[index]
                          //         .lastSignInTime), // 'time_field': PlutoCell(value: '12:30'),
                        },
                      );
                    },
                  ),
                  onRowDoubleTap: (event) async{
                    print(event);
                    PlutoCell? cell = event.row!.cells['text_field_id'];
                    String _uid = cell!.value;
                    User? user = await FirebaseApi.readOrCreateUser(uid: _uid, user: User(id: 'mock id', lastSignInTime: DateTime.now()));

                    editUser(user: user);

                  },
                  onChanged: (PlutoGridOnChangedEvent event) {
                    print(event);

                    PlutoCell? cell = event.row!.cells['text_field_id'];
                    String _uid = cell!.value;
                    if (event.columnIdx == 4) {
                      FirebaseApi.updateAccountType(
                          uid: _uid, accountType: event.value);
                    }
                  },
                  onLoaded: (PlutoGridOnLoadedEvent event) {
                    print(event);
                  },
                 onRowSecondaryTap: (PlutoGridOnRowSecondaryTapEvent event) async{
                   PlutoCell? cell = event.row!.cells['text_field_id'];
                   String _uid = cell!.value;
                   User? user = await FirebaseApi.readOrCreateUser(uid: _uid, user: User(id: 'mock id', lastSignInTime: DateTime.now()));

                   editUser(user: user);
                  },
            ),
            )
    );
  }

  void editUser({required User? user}) {
    Navigator.pushNamed(context, '/profile',
      //         arguments: ScreenArguments(ticketId: data.id));
        arguments: ScreenArguments(user: user));
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
