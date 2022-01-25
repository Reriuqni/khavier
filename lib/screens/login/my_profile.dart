import 'package:admin/auth/provider_configs.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/responsive.dart';
import 'package:admin/model/Storage.dart';
import 'package:admin/model/user.dart';
import '../../widgets/containers.dart';
import '../ticket/screen_arguments.dart';

dynamic args;
User? _user = User(id: 'mock id', 
lastSignInTime: DateTime.now(), lastAccessToFirebase: DateTime.now()
);

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage>
    with SingleTickerProviderStateMixin, RestorationMixin {
  TabController? _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController!.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController!.addListener(() {
      // When the tab controller's value is updated, make sure to update the
      // tab index value, which is state restorable.
      setState(() {
        tabIndex.value = _tabController!.index;
      });
    });
  }
  bool isAddUser = true;

  @override
  void dispose() {
    _tabController!.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    List tabs = ['Info', 'Contact', 'Other', 'Firebase'];
    args = ModalRoute.of(context)!.settings.arguments;

    if (args != 'newUser' && args != null) {
      args = args as ScreenArguments?;
      if (args.user != null) {
        _user = args.user;
        isAddUser = false;
      }
    }


    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                  alignment: Responsive.isDesktop(context)
                      ? Alignment.topCenter
                      : Alignment.center,
                  fit: Responsive.isDesktop(context)
                      ? BoxFit.cover
                      : BoxFit.fitHeight,
                  image: AssetImage("assets/images/home.jpg"))),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: headerColor,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (args == 'newUser') Text('New User'),
                          if (args != 'newUser') Text('My Profile'),
                          Row(
                            children: [
                              OwnButton(
                                  onPressed: () {
                                    // 2do: чи маєм право створювати порожнього юзера без прив'язки до uid FirebaseAuth?
                                    // Поки, що коментую рядок
                                    // FirebaseApi.createUser(user: _user!, uid: _user!.id);
                                    Navigator.pushNamed(context, '/');
                                  },
                                  label: 'Save')
                            ],
                          )
                        ],
                      ),
                      bottom: TabBar(
                        isScrollable: true,
                        controller: _tabController,
                        tabs: [
                          for (final tab in tabs) Tab(text: tab),
                        ],
                      ),
                    ),
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        InfoTab(),
                        ContactTab(),
                        TabsMainContainer(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                if (args == 'newUser')
                                  RowItem(
                                      text: 'Tags:',
                                      onChanged: (body) {
                                        _user!.tags = body;
                                      }),
                                RowItem(
                                    label: 'Liquidator #',
                                    onChanged: (body) {
                                      _user!.liquidatorId = body;
                                    }),
                              ],
                            )
                          ],
                        ),
                        if (args != 'newUser') FirebaseTab(),
                      ],
                    ),
                  )),
              StackHeader()
            ],
          )),
    );
  }
}


class InfoTab extends StatefulWidget {
  InfoTab();

  @override
  State<InfoTab> createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Row(
          children: [
            Text('UserPhoto:'),
            // Image(image: NetworkImage(userImage), width: 50, height: 50,),
            OwnButtonICon(
              onPressed: () async {
                setState(() {
                  imagePicker(uid: _user!.id);
                });
              },
              icon: Icons.add,
            ),
          ],
        ),
        if (args == 'newUser')
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              RowItem(
                  text: '* Organization:',
                  onChanged: (body) {
                    _user!.organization = body;
                  }),
              RowItem(
                  text: '*  Account Type:',
                  onChanged: (body) {
                    _user!.accountType = body;
                  }),
            ],
          ),
        if (args != 'newUser')
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              RowItem(
                text: 'Site:',
              ),
              RowItem(
                text: 'Access Level:',
              ),
            ],
          ),
        RowItem(
            text: 'User ID:',
            initialValue: _user!.id,
            onChanged: (body) {
              _user!.id = body;
            }
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                text: '* First Name:',
                onChanged: (body) {
                  _user!.firstName = body;
                }),
            RowItem(
                text: '* Last Name:',
                onChanged: (body) {
                  _user!.lastName = body;
                }),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
              text: '* Password:',
            ),
            RowItem(
                text: '* Confirm Password:',
                widget: OwnButton(onPressed: () {}, label: 'Generate')),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                text: '* Preferred OTP',
                onChanged: (body) {
                  _user!.preferredOTP = body;
                },
                widget:
                    OwnButton(onPressed: () {}, label: 'Setup Google Auth')),
            if (args == 'newUser')
              RowItem(
                  text: 'Language:',
                  onChanged: (body) {
                    _user!.language = body;
                  }),
          ],
        ),
      ],
    );
  }
}

class ContactTab extends StatelessWidget {
  ContactTab();

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                label: 'Email',
                onChanged: (body) {
                  _user!.email = body;
                }),
            RowItem(
                label: 'Mobile',
                onChanged: (body) {
                  _user!.mobile = body;
                }),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                label: 'Street Address 1',
                onChanged: (body) {
                  _user!.streetAddress1 = body;
                }),
            RowItem(
                label: 'Street Address 2',
                onChanged: (body) {
                  _user!.streetAddress2 = body;
                }),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                label: 'City',
                onChanged: (body) {
                  _user!.city = body;
                }),
            RowItem(
                label: 'State',
                onChanged: (body) {
                  _user!.state = body;
                }),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
                label: 'PostCode',
                onChanged: (body) {
                  _user!.postCode = body;
                }),
            RowItem(
                label: 'Country',
                onChanged: (body) {
                  _user!.country = body;
                }),
          ],
        ),
        if (args == 'newUser')
          RowItem(
              text: 'Time Zone:',
              onChanged: (body) {
                _user!.timeZone = body;
              }),
      ],
    );
  }
}

class FirebaseTab extends StatelessWidget {
  FirebaseTab();

  @override
  Widget build(BuildContext context) => ProfileScreen(
        providerConfigs: providerConfigs,
        actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ],
      );
}
