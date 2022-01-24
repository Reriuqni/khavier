import 'package:admin/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/main/main_screen.dart';

import '../ticket/screen_arguments.dart';

dynamic args;

class OrganizationsEdit extends StatefulWidget {
  const OrganizationsEdit({Key? key}) : super(key: key);
  @override
  _OrganizationsEdit createState() => _OrganizationsEdit();
}

class _OrganizationsEdit extends State<OrganizationsEdit>
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
      length: 7,
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

    List tabs = ['New Org.', 'Primary Contact', 'Address', 'Language', 'Billing', 'Branding', 'Admin Prising'];
    args = ModalRoute.of(context)!.settings.arguments;

    if (args != 'newUser' && args != null) {
      args = args as ScreenArguments?;
      if (args.user != null) {
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
                        Center(child: Text('New Organization'),),
                        Center(child: Text('Primary Contact'),),
                        Center(child: Text('Address'),),
                        Center(child: Text('Language'),),
                        Center(child: Text('Billing'),),
                        Center(child: Text('Branding'),),
                        Center(child: Text('Admin Prising'),),
                      ],
                    ),
                  )),
              StackHeader()
            ],
          )),
    );
  }
}

// class InfoTab extends StatefulWidget {
//   InfoTab();
//
//   @override
//   State<InfoTab> createState() => _InfoTabState();
// }
//
// class _InfoTabState extends State<InfoTab> {
//   @override
//   Widget build(BuildContext context) {
//     return TabsMainContainer(
//       children: [
//         Row(
//           children: [
//             Text('UserPhoto:'),
//             // Image(image: NetworkImage(userImage), width: 50, height: 50,),
//             OwnButtonICon(
//               onPressed: () async {
//                 setState(() {
//                 });
//               },
//               icon: Icons.add,
//             ),
//           ],
//         ),
//         if (args == 'newUser')
//           Wrap(
//             alignment: WrapAlignment.spaceBetween,
//             children: [
//               RowItem(
//                   text: '* Organization:',
//                   onChanged: (body) {
//                   }),
//               RowItem(
//                   text: '*  Account Type:',
//                   onChanged: (body) {
//                   }),
//             ],
//           ),
//         if (args != 'newUser')
//           Wrap(
//             alignment: WrapAlignment.spaceBetween,
//             children: [
//               RowItem(
//                 text: 'Site:',
//               ),
//               RowItem(
//                 text: 'Access Level:',
//               ),
//             ],
//           ),
//         RowItem(
//             text: 'User ID:',
//             onChanged: (body) {
//             }
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 text: '* First Name:',
//                 onChanged: (body) {
//                 }),
//             RowItem(
//                 text: '* Last Name:',
//                 onChanged: (body) {
//                 }),
//           ],
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//               text: '* Password:',
//             ),
//             RowItem(
//                 text: '* Confirm Password:',
//                 widget: OwnButton(onPressed: () {}, label: 'Generate')),
//           ],
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 text: '* Preferred OTP',
//                 onChanged: (body) {
//                 },
//                 widget:
//                 OwnButton(onPressed: () {}, label: 'Setup Google Auth')),
//             if (args == 'newUser')
//               RowItem(
//                   text: 'Language:',
//                   onChanged: (body) {
//                   }),
//           ],
//         ),
//       ],
//     );
//   }
// }
//
// class ContactTab extends StatelessWidget {
//   ContactTab();
//
//   @override
//   Widget build(BuildContext context) {
//     return TabsMainContainer(
//       children: [
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 label: 'Email',
//                 onChanged: (body) {
//                 }),
//             RowItem(
//                 label: 'Mobile',
//                 onChanged: (body) {
//                 }),
//           ],
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 label: 'Street Address 1',
//                 onChanged: (body) {
//                 }),
//             RowItem(
//                 label: 'Street Address 2',
//                 onChanged: (body) {
//                 }),
//           ],
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 label: 'City',
//                 onChanged: (body) {
//                 }),
//             RowItem(
//                 label: 'State',
//                 onChanged: (body) {
//                 }),
//           ],
//         ),
//         Wrap(
//           alignment: WrapAlignment.spaceBetween,
//           children: [
//             RowItem(
//                 label: 'PostCode',
//                 onChanged: (body) {
//                 }),
//             RowItem(
//                 label: 'Country',
//                 onChanged: (body) {
//                 }),
//           ],
//         ),
//         if (args == 'newUser')
//           RowItem(
//               text: 'Time Zone:',
//               onChanged: (body) {
//               }),
//       ],
//     );
//   }
// }
