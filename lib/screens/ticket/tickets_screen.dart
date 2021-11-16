import 'package:admin/controllers/MenuController.dart';
import 'package:admin/model/model.dart';
import 'package:admin/model/ticket.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../dashboard/components/header.dart';
import 'package:admin/constants.dart';
import '../main/components/side_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketsScreen extends StatefulWidget {
  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  late Model model;

  @override
  void initState() {
    super.initState();
  }

  void myPrint() async {
    model = Provider.of<Model>(context);
    List<Ticket> ts = await model.db.getTickets('dede');
    print(ts);
  }

  @override
  Widget build(BuildContext context) {
    myPrint();

    return Scaffold(
      appBar: AppBar(
        title: Header(),
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(padding: const EdgeInsets.only(top: 30)),
              ElevatedButton(
                // onPressed: () => addTicketShowDialog(),
                onPressed: () async {
                  Ticket tic = Ticket();
                  tic.id = await model.db.getTicketID();

                  tic.subject = 'subject';
                  tic.body = 'body';
                  tic.priority = 'priority';
                  tic.executorId = 'executorId';

                  model.db.addTicket(tic);
                },
                child: Text('Add New Ticket'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 30)),
              ElevatedButton(
                // onPressed: () => editTicketShowDialog(),
                onPressed: () => {
                  // model.db.updateTicket(tic);
                },
                child: Text('Edit Ticket'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                ),
              ),
            ],
          ),
          // Expanded(child: getTicketsCard()),
        ],
      ),
    );
  }

  // StreamBuilder<QuerySnapshot> getTicketsCard() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: ticketsSnapshots,
  //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //       if (snapshot.hasError) {
  //         return Text('snapshot: Something went wrong');
  //       }

  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         // return Text("snapshot: Loading");
  //         // return Center(child: CircularProgressIndicator(),);
  //         return Column(
  //           children: [
  //             Shimmer.fromColors(
  //               child: Text(
  //                 "Tickets Loading",
  //                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
  //               ),
  //               baseColor: Colors.blue,
  //               highlightColor: Colors.grey[300]!,
  //             ),
  //             CircularProgressIndicator()
  //           ],
  //         );
  //       }

  //       return ListView(
  //         // scrollDirection: Axis.horizontal,
  //         // shrinkWrap: true,
  //         children: snapshot.data!.docs.map((DocumentSnapshot document) {
  //           Map<String, dynamic> data =
  //               document.data()! as Map<String, dynamic>;

  //           data.forEach((k, v) => print('$k: $v'));

  //           return Card(
  //             child: InkWell(
  //               splashColor: Colors.blue.withAlpha(30),
  //               onTap: () {
  //                 print('Card tapped.');
  //                 editTicketShowDialog();
  //               },
  //               child: SizedBox(
  //                 width: 300,
  //                 height: 100,
  //                 child: Text(data['name']),
  //               ),
  //             ),
  //           );
  //         }).toList(),
  //       );
  //     },
  //   );
  // }

  // Future<T?> addTicketShowDialog<T>() {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
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

//   Future<T?> editTicketShowDialog<T>() {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Редактировать'),
//             content: TextField(onChanged: (String value) {
//               ticketName = value;
//             }),
//             actions: [
//               ElevatedButton(
//                 onPressed: () =>
//                     editName(tickets: tickets, ticketName: ticketName),
//                 child: Text('Редактировать'),
//               )
//             ],
//           );
//         });
//   }
}

// void addName({
Future<String> addName({
  required CollectionReference tickets,
  required String ticketName,
}) async {
  final doc = tickets.doc();
  final docId = doc.id;

  await doc
      .set({
        'name': ticketName,
      })
      .then((value) => print("Name is send to firebase"))
      .catchError((error) => print("Failed send name to firebase: $error"));

  return docId;
}

void editName(
    {required CollectionReference tickets, required String ticketName}) async {
  await tickets
      .doc('qmtLQpFLneoVpBq9FzMG')
      .set({
        'name': ticketName,
      })
      .then((value) => print("Name is send to firebase"))
      .catchError((error) => print("Failed send name to firebase: $error"));
}
