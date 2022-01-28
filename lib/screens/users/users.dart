import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/model/user.dart';
import 'package:admin/provider/NewVersionUserProvider.dart';
import 'package:admin/routes/roles.dart';
import 'package:admin/widgets/containers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/screens/ticket/screen_arguments.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            child: HeaderAndSideMenu(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      'Users',
                      style: TextStyle(color: iconColor, fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    width: 301,
                    child: Row(
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
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(15)),
                      hint: Text('Organization'),
                      onChanged: (String? newValue) {
                        setState(() {
                          // _type = newValue;
                        });
                      },
                      //тимчасові айтеми
                      items: <String>['', 'Need', 'Maybe', 'Whatelse', 'Forgoted']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    width: 300,
                    child: OwnTextFieldWithIcons(
                      labelText: 'Jim',
                      prefixIcon: FontAwesomeIcons.search,
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    width: 300,
                    child: Row(
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
              Expanded(
                // child: getTicketsView(),
                child: getConsumerUserView(),
              ),
            ],
          ),
        )));
  }

  Widget getConsumerUserView() {
    return StreamBuilder<List<User>>(
      stream: FirebaseApi.readUsers(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
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
        type: PlutoColumnType.select(Roles.values
            .where((e) => ![Roles.AUTH, Roles.ROLE_NOT_FOUND].contains(e))
            .map((e) => e.name)
            .toList()),
      ),
      PlutoColumn(
        title: 'Manage',
        field: 'manage_user',
        type: PlutoColumnType.select(['Edit']),
      ),

      /// Time Column definition
      // PlutoColumn(
      //   title: 'Last Refresh',
      //   field: 'time_field_lastAccessToFirebase_format_by_intl',
      //   type: PlutoColumnType.text(),
      // ),

      /// Time Column definition
      PlutoColumn(
        title: 'Last Refresh',
        field: 'time_field_lastAccessToFirebase',
        type: PlutoColumnType.text(),
      ),

      /// Datetime Column definition
      PlutoColumn(
        title: 'Auth SignIn',
        field: 'date_field_lastSignInTime',
        type: PlutoColumnType.date(),
      ),

      /// Time Column definition
      // PlutoColumn(
      //   title: 'Time SignIn',
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
            padding: EdgeInsets.only(top: 30),
            child: Material(
              child: PlutoGrid(
                columns: columns,
                // rows: rows,
                rows: List.generate(
                  provider.tickets.length,
                  (index) {
                    DateTime d;
                    d = provider.tickets[index].lastSignInTime;
                    DateTime lastSignInTime =
                        DateTime.utc(d.year, d.month, d.day, d.hour, d.minute, d.second);

                    d = provider.tickets[index].lastAccessToFirebase;
                    DateTime lastAccessToFirebase =
                        DateTime.utc(d.year, d.month, d.day, d.hour, d.minute, d.second);

                    return PlutoRow(
                      cells: {
                        'text_field_id': PlutoCell(value: provider.tickets[index].id),
                        'text_field_firstName': PlutoCell(value: provider.tickets[index].firstName),
                        'text_field_email': PlutoCell(value: provider.tickets[index].email),
                        'text_field_mobile': PlutoCell(value: provider.tickets[index].mobile),
                        'select_field_account_type': PlutoCell(
                            value: Roles.values
                                .firstWhere(
                                    (e) =>
                                        e.name ==
                                        (provider.tickets[index].accountType as Roles).name,
                                    orElse: () => Roles.NEW_USER)
                                .name),
                        'manage_user': PlutoCell(value: 'editUser'),

                        // 'time_field_lastAccessToFirebase_format_by_intl': PlutoCell(
                        //     value: DateFormat('yyyy-MM-dd KK:mm:ss')
                        //         .format(lastAccessToFirebase)),

                        'time_field_lastAccessToFirebase': PlutoCell(
                            value:
                                "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}"),

                        // 'time_field_lastAccessToFirebase':
                        //     PlutoCell(value: lastAccessToFirebase),

                        'date_field_lastSignInTime': PlutoCell(value: lastSignInTime),
                      },
                    );
                  },
                ),
                onRowDoubleTap: (event) async {
                  print(event);
                  PlutoCell? cell = event.row!.cells['text_field_id'];
                  String _uid = cell!.value;
                  User? user = await FirebaseApi.readUser(uid: _uid);

                  editUser(user: user);
                },
                onChanged: (PlutoGridOnChangedEvent event) {
                  print(event);

                  PlutoCell? cell = event.row!.cells['text_field_id'];
                  String _uid = cell!.value;
                  if (event.columnIdx == 4) {
                    FirebaseApi.updateAccountType(uid: _uid, accountType: event.value);
                  }
                },
                onRowSecondaryTap: (PlutoGridOnRowSecondaryTapEvent event) async {
                  print('onRowSecondaryTap');
                  PlutoCell? cell = event.row!.cells['text_field_id'];
                  String _uid = cell!.value;
                  User? user = await FirebaseApi.readUser(uid: _uid);

                  editUser(user: user);
                },
                createFooter: (stateManager) {
                  stateManager.setPageSize(100, notify: false); // default 40
                  return PlutoPagination(stateManager);
                },
              ),
            ));
  }

  void editUser({required User? user}) {
    Navigator.pushNamed(context, '/profile', arguments: ScreenArguments(user: user));
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
        style: TextStyle(
          fontSize: 24,
          color: Colors.blue,
        ),
      ),
    );
