import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/model.dart';
import 'package:admin/model/ticket.dart';
import 'package:admin/responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../dashboard/components/header.dart';
import '../dashboard/components/recent_files.dart';
import '../main/components/side_menu.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Model model;
  late List<Ticket> tickets;

  // bool _initialized = false;
  // bool _error = false;
  // String ticketName = '';
  // late CollectionReference tickets = FirebaseFirestore.instance.collection('tickets');
  final Stream<QuerySnapshot> ticketsSnapshots = FirebaseFirestore.instance
      .collection('tickets')
      .orderBy('name', descending: true)
      .snapshots();

  @override
  void initState() {
    // initializeFlutterFire();
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  // void initializeFlutterFire() async {
  //   try {
  //     // Wait for Firebase to initialize and set `_initialized` state to true
  //     WidgetsFlutterBinding.ensureInitialized();
  //     await Firebase.initializeApp();
  //     setState(() {
  //       _initialized = true;
  //     });
  //   } catch (e) {
  //     // Set `_error` state to true if Firebase initialization fails
  //     setState(() {
  //       _error = true;
  //     });
  //     print(e);
  //   }
  // }

  Future<List<Ticket>> getTickets() async {
    return await model.db.getTickets();
  }

  @override
  Widget build(BuildContext context) {
    // if (_error) {
    //   print('Main build: Something Went Wrong');
    // }

    // // Show a loader until FlutterFire is initialized
    // if (!_initialized) {
    //   print('Main build: Loading');
    // }

    model = Provider.of<Model>(context);
    tickets = getTickets() as List<Ticket>;

    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // We want this side menu only for large screen
      if (Responsive.isDesktop(context))
        Expanded(
          // default flex = 1
          // and it takes 1/6 part of the screen
          child: SideMenu(),
        ),
      Expanded(
        // It takes 5/6 part of the screen
        flex: 5,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0),
              child: Header(),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding /
                            (Responsive.isMobile(context) ? 2 : 1),
                      ),
                    ),
                    onPressed: () async {
                      Ticket ticket = Ticket();
                      ticket.id = await model.db.getTicketID();

                      Navigator.pushNamed(
                        context,
                        '/addticket',
                        arguments: ScreenArguments(
                          'Extract Arguments Screen',
                          'This message is extracted in the build method.',
                          ticket,
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add New"),
                  ),
                ),
              ],
            ),
            Row(
              children: [],
            ),
            Expanded(child: getTicketsCard()),
          ],
        ),
      ),
    ]));
  }

  StreamBuilder<QuerySnapshot> getTicketsCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: ticketsSnapshots,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('snapshot: Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // return Text("snapshot: Loading");
          // return Center(child: CircularProgressIndicator(),);
          return Column(
            children: [
              Shimmer.fromColors(
                child: Text(
                  "Tickets Loading",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                baseColor: Colors.blue,
                highlightColor: Colors.grey[300]!,
              ),
              CircularProgressIndicator()
            ],
          );
        }

        return SafeArea(
            child: Container(
          margin: EdgeInsets.all(20.0),
          child: RecentFiles(),
        ));

        // return ListView(
        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //     Map<String, dynamic> data =
        //         document.data()! as Map<String, dynamic>;
        //
        //     data.forEach((k, v) => print('$k: $v'));
        //
        //
        //     //create card for ticket
        //     return Card(
        //       child: Ink(
        //         color: secondaryColor,
        //         child: InkWell(
        //           hoverColor: Colors.black12,
        //           onTap: () {
        //             print('Card tapped.');
        //             //editTicketShowDialog();
        //             Navigator.pushNamed(context,
        //                 '/addticket',
        //                 arguments: ScreenArguments(
        //                 'Extract Arguments Screen',
        //                 'This message is extracted in the build method.',
        //             ),
        //             );
        //           },
        //           child:
        //               Container(
        //                 width: 200,
        //                 height: 100,
        //                 margin: EdgeInsets.fromLTRB(15, 10, 25, 10),
        //                 child: Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Expanded(
        //                       flex: 9,
        //                       child: Column(
        //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //                       crossAxisAlignment: CrossAxisAlignment.start,
        //                       children: [
        //                         Container(
        //                           margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
        //                           child: Row (
        //                             children: [
        //                               Text(data['name'], style: TextStyle(
        //                                   fontWeight: FontWeight.bold,
        //                                   fontSize: 20
        //                               ),),
        //                               Container(
        //                                 margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
        //                                 child: Text(data['priority']),
        //                               ),
        //                               Text(data['subject'])
        //                             ],
        //                           ),
        //                         ),
        //
        //                         Container(
        //                           child: Text('Owner: ${data['owner']}'),
        //                         ),
        //
        //                         Container(
        //                           child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        //                             overflow: TextOverflow.ellipsis,
        //                           ),
        //                         ),
        //                       ],
        //                     ),),
        //
        //                     //buttons edit\delete
        //                     Expanded(
        //                       flex: 1,
        //                       child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                       children: [
        //                         Container(
        //                           margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
        //                           child: IconButton(onPressed: () => {
        //
        //                           }, icon: Icon(Icons.edit),
        //                             hoverColor: Colors.amberAccent.withOpacity(0.5),
        //
        //                           ),
        //                         ),
        //                         IconButton(onPressed: () => {
        //
        //                         }, icon: Icon(Icons.delete),
        //                           hoverColor: Colors.redAccent.withOpacity(0.5),),
        //                       ],
        //                     ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //         ),
        //       ),
        //     );
        //   }).toList(),
        // );
      },
    );
  }

  // Future<T?> addTicketShowDialog<T>() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         late String ticketName;

  //         return AlertDialog(
  //           title: Text('Добавить'),
  //           content: TextField(onChanged: (String value) {
  //             ticketName = value;
  //           }),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () {
  //                 late final id =
  //                     addName(tickets: tickets, ticketName: ticketName);
  //                 print('New Id: $id');
  //               },
  //               child: Text('Добавить'),
  //             )
  //           ],
  //         );
  //       });
  // }

  // Future<T?> editTicketShowDialog<T>() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Редактировать'),
  //           content: TextField(onChanged: (String value) {
  //             ticketName = value;
  //           }),
  //           actions: [
  //             ElevatedButton(
  //               onPressed: () =>
  //                   editName(tickets: tickets, ticketName: ticketName),
  //               child: Text('Редактировать'),
  //             )
  //           ],
  //         );
  //       });
  // }
}

// Future<String> addName({
//   required List<Ticket> tickets,
//   required String ticketName,
// }) async {
//   final doc = tickets.doc();
//   final docId = doc.id;

//   await doc
//       .set({
//         'name': ticketName,
//       })
//       .then((value) => print("Name is send to firebase"))
//       .catchError((error) => print("Failed send name to firebase: $error"));

//   return docId;
// }

// void editName(
//     {required CollectionReference tickets, required String ticketName}) async {
//   await tickets
//       .doc('qmtLQpFLneoVpBq9FzMG')
//       .set({
//         'name': ticketName,
//       })
//       .then((value) => print("Name is send to firebase"))
//       .catchError((error) => print("Failed send name to firebase: $error"));
// }

class ScreenArguments {
  final String title;
  final String message;
  Ticket ticket;

  ScreenArguments(this.title, this.message, this.ticket);
}
