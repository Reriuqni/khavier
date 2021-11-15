import 'package:admin/controllers/MenuController.dart';
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
  // final String _pageName = 'Ticket system';
  bool _initialized = false;
  bool _error = false;
  String ticketName = '';
  late CollectionReference tickets = FirebaseFirestore.instance.collection('tickets');
  final Stream<QuerySnapshot> ticketsSnapshots = FirebaseFirestore.instance
      .collection('tickets')
      .orderBy('name', descending: true)
      .snapshots();

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print('Main build: Something Went Wrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('Main build: Loading');
    }

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
                onPressed: () => addTicketShowDialog(),
                child: Text('Add New Ticket'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                ),
              ),
              Padding(padding: const EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () => editTicketShowDialog(),
                child: Text('Edit Ticket'),
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                ),
              ),
            ],
          ),
          Expanded(child: getTicketsCard()),
        ],
      ),
    );
  }

/* 
  Widget getBody0() {
    return SafeArea(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () => addTicketShowDialog(),
            child: Text('Add New Ticket'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            ),
          ),
          Padding(padding: const EdgeInsets.only(top: 30)),
          ElevatedButton(
            onPressed: () => editTicketShowDialog(),
            child: Text('Edit Ticket'),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                  editTicketShowDialog();
                },
                child: const SizedBox(
                  width: 300,
                  height: 100,
                  child: Text('A card that can be tapped'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
 */

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

        return ListView(
          // scrollDirection: Axis.horizontal,
          // shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            data.forEach((k, v) => print('$k: $v'));

            return Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                  editTicketShowDialog();
                },
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Text(data['name']),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Future<T?> addTicketShowDialog<T>() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Добавить'),
            content: TextField(onChanged: (String value) {
              ticketName = value;
            }),
            actions: [
              ElevatedButton(
                onPressed: () {
                  late final id =
                      addName(tickets: tickets, ticketName: ticketName);
                  print('New Id: $id');
                },
                child: Text('Добавить'),
              )
            ],
          );
        });
  }

  Future<T?> editTicketShowDialog<T>() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Редактировать'),
            content: TextField(onChanged: (String value) {
              ticketName = value;
            }),
            actions: [
              ElevatedButton(
                onPressed: () =>
                    editName(tickets: tickets, ticketName: ticketName),
                child: Text('Редактировать'),
              )
            ],
          );
        });
  }
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
