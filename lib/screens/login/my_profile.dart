import 'package:admin/api/firebase_api.dart';
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
User? _user =
    User(id: 'mock id', lastSignInTime: DateTime.now(), lastAccessToFirebase: DateTime.now());

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
                  colorFilter: ColorFilter.mode(Colors.black45, BlendMode.dstATop),
                  alignment: Responsive.isDesktop(context) ? Alignment.topCenter : Alignment.center,
                  fit: Responsive.isDesktop(context) ? BoxFit.cover : BoxFit.fitHeight,
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
                                    FirebaseApi.updateUser(user: _user!);
                                    Navigator.pushNamed(context, '/users');
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
                        OtherTab(),
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

class OtherTab extends StatelessWidget {
  const OtherTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabsMainContainer(
      children: [
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            if (args == 'newUser')
              RowItem(
                text: 'Tags:',
                onChanged: (_) => _user!.tags = _,
              ),
            RowItem(
              label: 'Liquidator #',
              initialValue: _user!.liquidatorId,
              onChanged: (_) => _user!.liquidatorId = _,
            ),
          ],
        )
      ],
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
                initialValue: _user!.organization,
                onChanged: (_) => _user!.organization = _,
              ),
              RowItem(
                text: '*  Account Type:',
                initialValue: _user!.accountType,
                onChanged: (_) => _user!.accountType = _,
              ),
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
          onChanged: (_) => _user!.id = _,
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
              text: '* First Name:',
              initialValue: _user!.firstName,
              onChanged: (_) => _user!.firstName = _,
            ),
            RowItem(
              text: '* Last Name:',
              initialValue: _user!.lastName,
              onChanged: (_) => _user!.lastName = _,
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
              // 2do: we have firebase auth. Do we need password field?
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
              // 2do: what is that? What is OTP? We have Firabes auth.
              text: '* Preferred OTP',
              initialValue: _user!.preferredOTP,
              onChanged: (_) => _user!.preferredOTP = _,
              widget: OwnButton(onPressed: () {}, label: 'Setup Google Auth'),
            ),
            if (args == 'newUser')
              // 2do: Can we change language only for new user?
              RowItem(
                text: 'Language:',
                initialValue: _user!.language,
                onChanged: (_) => _user!.language = _,
              ),
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
              initialValue: _user!.email,
              onChanged: (_) => _user!.email = _,
            ),
            RowItem(
              label: 'Mobile',
              initialValue: _user!.mobile,
              onChanged: (_) => _user!.mobile = _,
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
              label: 'Street Address 1',
              initialValue: _user!.streetAddress1,
              onChanged: (_) => _user!.streetAddress1 = _,
            ),
            RowItem(
              label: 'Street Address 2',
              initialValue: _user!.streetAddress2,
              onChanged: (_) => _user!.streetAddress2 = _,
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(label: 'City', initialValue: _user!.city, onChanged: (_) => _user!.city = _),
            RowItem(label: 'State', initialValue: _user!.state, onChanged: (_) => _user!.state = _),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: [
            RowItem(
              label: 'PostCode',
              initialValue: _user!.postCode,
              onChanged: (_) => _user!.postCode = _,
            ),
            RowItem(
              label: 'Country',
              initialValue: _user!.country,
              onChanged: (_) => _user!.country = _,
            ),
          ],
        ),
        if (args == 'newUser')
          RowItem(
            text: 'Time Zone:',
            initialValue: _user!.timeZone,
            onChanged: (_) => _user!.timeZone = _,
          ),
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
