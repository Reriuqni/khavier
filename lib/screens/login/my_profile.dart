import 'package:admin/widgets/buttons.dart';
import 'package:admin/widgets/textFields.dart';
import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants.dart';
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
      length: 3,
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
    final tabs = ['Info', 'Contact', 'Other'];

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
                          rowItem(
                            label: 'Liquidator #',
                          )
                        ])
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

class rowItem extends StatelessWidget {
  final String text;
  final String label;
  final Widget widget;
  rowItem(
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
          rowItem(text: 'Site:'),
          rowItem(text: 'Access Level:'),
          rowItem(text: 'User ID:'),
          rowItem(text: '* First Name:'),
          rowItem(text: '* Last Name:'),
          rowItem(
            text: '* Password:',
          ),
          rowItem(
              text: '* Confirm Password:',
              widget: OwnButton(onPressed: () {}, label: 'Generate')),
          rowItem(
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
          rowItem(label: 'Email'),
          rowItem(label: 'Mobile'),
          rowItem(label: 'Street Address 1'),
          rowItem(label: 'Street Address 2'),
          rowItem(label: 'City'),
          rowItem(label: 'State'),
          rowItem(label: 'PostCode'),
          rowItem(label: 'Country'),
        ],
      ),
    ));
  }
}
