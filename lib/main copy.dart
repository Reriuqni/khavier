import 'package:admin/controllers/MenuController.dart';
import 'package:admin/apps/create_app.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/routes/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  bool isLoadedUser = false;

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

        // User is not signed in - show a sign-in screen
        if (!snapshot.hasData) {
          return CreateApp(auth: auth, userRole: Roles.AUTH);
        }
/*
        Roles userRole = Roles.ADMIN;
        if (auth.currentUser?.email == 'manager@mysolve.com') {
          userRole = Roles.MANAGER;
        }

        // getRole(id: '115885384621082789849');

        late Future<MySolveUser> mySolveUser;
        late MySolveUser aa;

        if (!isLoadedUser) {
          mySolveUser = readUser(id: '9tMYuHMJZzSkbA3z8sDk');

          // print(mySolveUser);
          aa = mySolveUser as MySolveUser;
          print(aa.role);
        }
*/
        if (isLoadedUser) {
          // show app’s home page after login
          return FutureBuilder(
            future: readUser(id: '9tMYuHMJZzSkbA3z8sDk'),
            builder: (BuildContext context,
                AsyncSnapshot<MySolveUser> userSnapshot) {

                  print('FutureBuilder');

              if (userSnapshot.hasData) {
                // MySolveUser? mySolveUser = userSnapshot.data;
                final mySolveUser = userSnapshot.data;

                print(mySolveUser);

                if (mySolveUser == null) {
                  return Center(child: Text('No User'));
                } else {
                  print('-----mySolveUser.role');
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
                 print('22');
                return Column(
                  children: [
                    Center(child: CircularProgressIndicator()),
                    Text('???  22'),
                  ],
                );
              }
            },
          );

          // return MultiProvider(
          //   providers: [
          //     ChangeNotifierProvider(
          //       create: (context) => MenuController(),
          //     ),
          //     ChangeNotifierProvider(create: (context) => TicketsProvider()),
          //   ],
          //   child: CreateApp(auth: auth, userRole: userRole),
          // );
        } else {
          print('111');
          return Text('??? 11');
                return Column(
                  children: [
                    // Center(child: CircularProgressIndicator()),
                    Text('??? 11'),
                  ],
                );
        }
      },
    );
  }

  // FutureBuilder<MySolveUser> readUser2({required String id}) {
  //   return FutureBuilder<MySolveUser>(
  //     future: readUser(id: id),
  //     builder: (context, fbSnapshot) {
  //       if (fbSnapshot.hasData) {
  //         return fbSnapshot.data;
  //       } else  {
  //         return MySolveUser();
  //       }
  //     },
  //   );
  // }

  /// {@id description:Firebase authentication user 'id'.}
  Future<MySolveUser> readUser({required String id}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(id);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      setState(() {
        isLoadedUser = true;
      });
      return MySolveUser.fromJson(snapshot.data()!);
    }

    return MySolveUser(id: 'User is not exist', role: Roles.USER);
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
