import 'package:admin/auth/provider_configs.dart';
import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/headerResponsive.dart';

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

  @override
  void dispose() {
    _tabController!.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = ['Info', 'Contact', 'Other', 'Firebase'];

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
                  image: NetworkImage("assets/assets/images/home.jpg"))),
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
                          Text('My Profile'),
                          Row(
                            children: [
                              OwnButton(onPressed: () {}, label: 'Save')
                            ],
                          )
                        ],
                      ),
                      bottom: TabBar(
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
                        Column(children: [
                          RowItem(
                            label: 'Liquidator #',
                          )
                        ]),
                        FirebaseTab(),
                      ],
                    ),
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isDesktop(context)) Header(),
                  if (!Responsive.isDesktop(context)) HeaderResponsive(),
                ],
              ),
            ],
          )),
    );
  }
}

class RowItem extends StatelessWidget {
  final String text;
  final String label;
  final Widget widget;
  RowItem(
      {this.text = '', this.label = 'Default', this.widget = const Text('')});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            width: 300,
            child: Text(
              text,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            width: 300,
            child: OwnTextField(
              labelText: label,
            ),
          ),
          Container(
              padding: EdgeInsets.all(5),
              width: 175,
              child: Container(
                child: widget,
              ))
        ],
      ),
    );
  }
}

class InfoTab extends StatelessWidget {
  InfoTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          RowItem(text: 'Site:'),
          RowItem(text: 'Access Level:'),
          RowItem(text: 'User ID:'),
          RowItem(text: '* First Name:'),
          RowItem(text: '* Last Name:'),
          RowItem(
            text: '* Password:',
          ),
          RowItem(
              text: '* Confirm Password:',
              widget: OwnButton(onPressed: () {}, label: 'Generate')),
          RowItem(
              text: '* Preferred OTP',
              widget: OwnButton(onPressed: () {}, label: 'Setup Google Auth')),
        ],
      ),
    ));
  }
}

class ContactTab extends StatelessWidget {
  ContactTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      child: Column(
        children: [
          RowItem(label: 'Email'),
          RowItem(label: 'Mobile'),
          RowItem(label: 'Street Address 1'),
          RowItem(label: 'Street Address 2'),
          RowItem(label: 'City'),
          RowItem(label: 'State'),
          RowItem(label: 'PostCode'),
          RowItem(label: 'Country'),
        ],
      ),
    ));
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
