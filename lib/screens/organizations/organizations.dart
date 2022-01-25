import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants/colors.dart';
import '../../widgets/buttons.dart';
import '../../widgets/containers.dart';
import '../../widgets/textFields.dart';
import 'package:flutter/material.dart';


class OrganizationsPage extends StatefulWidget {
  @override
  _OrganizationsPage createState() => _OrganizationsPage();
}

class _OrganizationsPage extends State<OrganizationsPage> with RestorationMixin {
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
                  Text(
                    'Organizations',
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10,),
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
                                }
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text('Show Archived',
                                style: TextStyle(
                                  color: iconColor,
                                  fontSize: 16,
                                )
                            ),
                            OwnButtonICon(
                              onPressed: () async {
                                Navigator.pushNamed(
                                  context,
                                  '/editOrg',
                                );
                              },
                              icon: Icons.add,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Text('Organizations list'),
                  ),
                ],
              ),
            )
        )
    );
  }
}