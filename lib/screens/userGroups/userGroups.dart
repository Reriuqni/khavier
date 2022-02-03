import 'package:admin/screens/userGroups/components/row_of_user_group.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/containers.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:flutter/material.dart';

class UserGroupsPage extends StatefulWidget {
  @override
  _UserGroupsPage createState() => _UserGroupsPage();
}

class _UserGroupsPage extends State<UserGroupsPage> with RestorationMixin {
  RestorableBoolN archivedCheckBox = RestorableBoolN(false);

  @override
  String get restorationId => 'checkbox_demo';

  @override
  void restoreState(restorationBucket, bool initialRestore) {
    registerForRestoration(archivedCheckBox, 'checkbox_b');
  }

  @override
  void dispose() {
    archivedCheckBox.dispose();
    super.dispose();
  }

  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SafeArea(
            child: HeaderAndSideMenu(
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'User Groups',
                style: TextStyle(color: iconColor, fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    width: 300,
                    child: OwnTextFieldWithIcons(
                      labelText: 'Search',
                      prefixIcon: FontAwesomeIcons.search,
                    ),
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
                        OwnButtonICon(
                          onPressed: () async {
                            Navigator.pushNamed(
                              context,
                              '/editUserGroups',
                            );
                          },
                          icon: Icons.add,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Text('Name'),
                  ),
                  RowOfUserGroup(nameOfGroup: 'Administration'),
                  RowOfUserGroup(nameOfGroup: 'Branding'),
                  RowOfUserGroup(nameOfGroup: 'Demo'),
                ],
              )
            ],
          ),
        )));
  }
}
