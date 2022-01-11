import 'package:admin/auth/provider_configs.dart';
import 'package:admin/constants/texts.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/create_app.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/routes/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';

import 'auth/init.dart'
    if (dart.library.html) 'auth/web_init.dart'
    if (dart.library.io) 'auth/io_init.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(AuthenticationGate());
}

class AuthenticationGate extends StatefulWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

  @override
  State<AuthenticationGate> createState() => _AuthenticationGateState();
}

class _AuthenticationGateState extends State<AuthenticationGate> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    return StreamBuilder<User?>(
      // stream: FirebaseAuth.instance.authStateChanges(),
      stream: auth.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // show app’s home page after login
        return FutureBuilder(
          future: readUser(id: '9tMYuHMJZzSkbA3z8sDk'),
          builder:
              (BuildContext context, AsyncSnapshot<MySolveUser> userSnapshot) {
            if (userSnapshot.hasData) {
              // MySolveUser? mySolveUser = userSnapshot.data;
              final mySolveUser = userSnapshot.data;

              print(mySolveUser);

              if (mySolveUser == null) {
                return Center(child: Text('No User'));
              } else {
                print(mySolveUser.role);

                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                    ChangeNotifierProvider(
                        create: (context) => TicketsProvider()),
                  ],
                  child: CreateApp(auth: auth, userRole: mySolveUser.role),
                );
              }
            } else {
              print('Loading User Data...');

              return MaterialApp(
                title: PROJECT_NAME,
                debugShowCheckedModeBanner: false,
                home: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(top: 25),
                  child: Center(
                    child: Column(
                      children: [
                        Text("Loading User Data...",
                            style:
                                TextStyle(fontSize: 22, color: Colors.black87),
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );

              return Center(
                  child: Column(
                children: [
                  // CircularProgressIndicator(),
                  // Text('Loading User Data...'),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusColor: Colors.teal,
                      label: Text('User ID / Email',
                          style: TextStyle(color: Colors.teal)),
                    ),
                  ),
                ],
              ));
            }
          },
        );
      },
    );
  }

  /// {@id description:Firebase authentication user 'id'.}
  Future<MySolveUser> readUser({required String id}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(id);
    final snapshot = await docUser.get();

    MySolveUser result = MySolveUser(id: 'User is not exist', role: Roles.USER);

    if (snapshot.exists) {
      result = MySolveUser.fromJson(snapshot.data()!);
    }

    return result;
  }
}

class MySolveUser {
  String body;
  String date;
  String executorId;
  String id;
  String name;
  String owner;
  String priority;
  String status;
  String subject;
  String tag;
  String type;
  Roles role;

  MySolveUser({
    this.body = '',
    this.date = '',
    this.executorId = '',
    required this.id,
    this.name = '',
    this.owner = '',
    this.priority = '',
    this.status = '',
    this.subject = '',
    this.tag = '',
    this.type = '',
    this.role = Roles.USER,
  });

  Map<String, dynamic> tyJson() => {
        'body': body,
        'date': date,
        'executorId': executorId,
        'id': id,
        'name': name,
        'owner': owner,
        'priority': priority,
        'status': status,
        'subject': subject,
        'tag': tag,
        'type': type,
        'role': role.name,
      };

  static MySolveUser fromJson(Map<String, dynamic> json) => MySolveUser(
        body: json['body'],
        date: json['date'],
        executorId: json['executorId'],
        id: json['id'],
        name: json['name'],
        owner: json['owner'],
        priority: json['priority'],
        status: json['status'],
        subject: json['subject'],
        tag: json['tag'],
        type: json['type'],
        // role: Roles[json['role']],
        role: Roles.values.firstWhere((e) => e.name == json['role']),
      );
}
