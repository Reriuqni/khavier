import 'package:admin/api/firebase_api.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/model/user.dart';
import 'package:admin/provider/NewVersionUserProvider.dart';
import 'package:admin/routes/roles.dart';
import 'package:admin/screens/users/table/row/context_menu.dart';
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
            widget:
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                      Text(
                      'Users',
                        style: TextStyle(
                            color: iconColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                  ),
                      SizedBox(width: 50,),
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
                              onPressed: () {
                              },
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
                  SizedBox(height: 10,),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                          child: OwnDropDown(
                            hint: 'User Groups',
                            onChanged: (value) {},
                      items: <String>[
                        '',
                        'Need',
                        'Maybe',
                        'Whatelse',
                        'Forgoted'
                            ],
                          )
                  ),
                    SizedBox(width: 20, height: 20,),
                  Container(
                    width: 300,
                    child: OwnTextFieldWithIcons(
                      labelText: 'Jim',
                      prefixIcon: FontAwesomeIcons.search,
                    ),
                  ),
                        SizedBox(width: 30,),
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
                                SizedBox(width: 5,),
                                Text(
                                  'Show Archived',
                            style: TextStyle(
                              color: iconColor,
                              fontSize: 16,
                                  )
                                ),
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
      )),
    );
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

              return Scaffold(body: getTicketsView(provider, context));
            }
        }
      },
    );
  }

  Widget getTicketsView(provider, context) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'ID',
        field: 'text_field_id',
        type: PlutoColumnType.text(),
        readOnly: true,
        renderer: (rendererContext) {
          return Row(
            children: [
              // rendererContext.column.field equal to 'text_field_id'
              TableUsersContextMenu(
                  //  rendererContext.column.field == 'text_field_id']
                  uid: rendererContext.row.cells[rendererContext.column.field]!.value
                      .toString()), 
              Expanded(
                child: Text(
                  // rendererContext.row.cells[rendererContext.column.field]!.value.toString() equal to data in cell. In this case value of uid field.
                  rendererContext.row.cells[rendererContext.column.field]!.value.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
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

      PlutoColumn(
        title: 'Account Type',
        field: 'select_field_account_type',
        width: 150,
        type: PlutoColumnType.select(RolesExtension.getHumanListNames()),
      ),

      PlutoColumn(
        title: 'Last Refresh',
        field: 'time_field_lastAccessToFirebase',
        type: PlutoColumnType.text(),
      ),

      PlutoColumn(
        title: 'Auth SignIn',
        field: 'date_field_lastSignInTime',
        type: PlutoColumnType.date(),
        width: 130,
      ),

      /// Time Column definition
      // PlutoColumn(
      //   title: 'Time SignIn',
      //   field: 'time_field_lastSignInTime',
      //   type: PlutoColumnType.time(),
      // ),

      // PlutoColumn(
      //   title: 'Last Refresh',
      //   field: 'time_field_lastAccessToFirebase_format_by_intl',
      //   type: PlutoColumnType.text(),
      // ),
    ];

    return provider.tickets.isEmpty // tickets.isEmpty
        ? Center(child: Text('No Tickets', style: TextStyle(fontSize: 20)))
        : Container(
            padding: EdgeInsets.only(top: 30),
            child: Material(
              child: PlutoGrid(
                columns: columns,
                rows: List.generate(
                  provider.tickets.length,
                  (index) {
                    DateTime d;
                    d = provider.tickets[index].lastSignInTime;
                    DateTime lastSignInTime =
                        DateTime.utc(d.year, d.month, d.day, d.hour, d.minute, d.second);

                    // d = provider.tickets[index].lastAccessToFirebase;
                    // DateTime lastAccessToFirebase =
                    //     DateTime.utc(d.year, d.month, d.day, d.hour, d.minute, d.second);

                    return PlutoRow(
                      cells: {
                        'text_field_id': PlutoCell(value: provider.tickets[index].id),
                        'text_field_firstName': PlutoCell(value: provider.tickets[index].firstName),
                        'text_field_email': PlutoCell(value: provider.tickets[index].email),
                        'text_field_mobile': PlutoCell(value: provider.tickets[index].mobile),
                        'select_field_account_type': PlutoCell(
                            value: RolesExtension.getNameOfRole(
                                role: provider.tickets[index].accountType)),


                        'time_field_lastAccessToFirebase': PlutoCell(
                            value:
                                "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}:${d.second.toString().padLeft(2, '0')}"),

                        'date_field_lastSignInTime': PlutoCell(value: lastSignInTime),

                        // 'time_field_lastAccessToFirebase': PlutoCell(value: lastAccessToFirebase),
                        // 'time_field_lastAccessToFirebase_format_by_intl': PlutoCell(
                        //     value: DateFormat('yyyy-MM-dd KK:mm:ss')
                        //         .format(lastAccessToFirebase)),
                      },
                    );
                  },
                ),
                onRowDoubleTap: (event) async {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Yay! A SnackBar!'),
                  ));
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
                  // print('onRowSecondaryTap');
                  // PlutoCell? cell = event.row!.cells['text_field_id'];
                  // String _uid = cell!.value;
                  // User? user = await FirebaseApi.readUser(uid: _uid);
                  // editUser(user: user);

                  final snackBar = SnackBar(
                    content: const Text('Yes! This is a SnackBar!'),
                    action: SnackBarAction(
                      label: 'Undo',
                      onPressed: () {
                        // Some code to undo the change.
                },
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                onLoaded: (PlutoGridOnLoadedEvent event) {
                  event.stateManager.setShowColumnFilter(true);
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

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          color: Colors.blue,
        ),
      ),
    );
