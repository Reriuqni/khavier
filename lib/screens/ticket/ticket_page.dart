import 'package:flutter/material.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants/colors.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);
  @override
  _TicketPage createState() => _TicketPage();
}

class _TicketPage extends State<TicketPage>
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

    final tabs = [
      'Options', 'Documents', 'Comment'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: primaryColor),
        bottom: TabBar(
          indicatorColor: primaryColor,
          labelColor: Colors.black54,
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          controller: _tabController,
          isScrollable: false,
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Container(
            margin: EdgeInsets.all(20.0),
            child: Row (
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                          'TicketName',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              height: 1),
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'Owner: Owner',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                      child: Text(
                        'Status:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        'Description:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ])],
            )
            ),
          ),
          Center(
            child: Text('Documents'),
          ),
          Center(
            child: Text('Comment'),
          ),

          // for (final tab in tabs)
          //   Center(
          //     child: Text(tab),
          //   ),
        ],
      ),
    );
  }
}

