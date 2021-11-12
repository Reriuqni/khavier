import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final String _pageName = 'Ticket system';
  bool _initialized = false;
  bool _error = false;
  String ticketName = '';
  late CollectionReference tickets;
  // final Stream<QuerySnapshot> tickets;
  // FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    initializeFlutterFire();
    tickets = FirebaseFirestore.instance.collection('tickets');
    super.initState();
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  void addName({required String ticketName}) {
    tickets
      .doc('qmtLQpFLneoVpBq9FzMG')
      .set({
        'name': ticketName,
      })
      .then((value) => print("Name is send to firebase"))
      .catchError((error) => print("Failed send name to firebase: $error"));
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print('SomethingWentWrong');
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      print('Loading');
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
      body: SafeArea(       
        child: Column(
          children: [
          //   Container(
          //     padding: EdgeInsets.only(top: 30),
          //     child: Text('Plugin'),
          //   ),
            Padding(padding: const EdgeInsets.only(top: 30)),

            ElevatedButton(
              onPressed: () => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Добавить'),
                        content: TextField(onChanged: (String value) {
                          ticketName = value;
                        }),
                        actions: [
                          ElevatedButton(
                            // onPressed: addName(ticketName: ''),
                            onPressed: () {
                              addName(ticketName: ticketName);
                            },
                            child: Text('Добавить'),
                          )
                        ],
                      );
                    })
              },
              child: Text('add new'),
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
      ),
    );
  }
}
