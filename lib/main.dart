import 'package:admin/apps/shimmer_app_loading.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/apps/create_app.dart';
import 'package:admin/model/solve_user.dart';
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

        String _uid = snapshot.data?.uid ?? 'No user id';

        // show app’s home page after login
        return FutureBuilder(
          // future: readUser(id: (snapshot.data?.uid ?? 'no uid')),
          future: readUser(uid: _uid),
          builder:
              (BuildContext context, AsyncSnapshot<SolveUser?> userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return ShimmerLoading(
                  text: 'Loading User Data...', subText: _uid);
            }

            if (userSnapshot.hasData) {
              final solveUser = userSnapshot.data;

              if (solveUser == null) {
                // return Center(child: Text('No User'));
                return CreateApp(auth: auth, userRole: Roles.AUTH);
              } else {
                return MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) => MenuController(),
                    ),
                    ChangeNotifierProvider(
                        create: (context) => TicketsProvider()),
                  ],
                  child: CreateApp(auth: auth, userRole: solveUser.role),
                );
              }
            } else {
              return ShimmerLoading(
                  text: 'Unfortunately No Such User. Please, first create User in DB', subText: _uid, isShimEnabled: false);
            }
          },
        );
      },
    );
  }

  /// Get User from firebase collection
  /// {@id description:Firebase authentication user 'id'.}
  Future<SolveUser?> readUser({required String uid}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      print('User exist. uid $uid');
      print(SolveUser.fromJson(snapshot.data()!));
      return SolveUser.fromJson(snapshot.data()!);
    } else {
      print('User is not exist. uid $uid');
    }
  }
}
