import 'package:admin/controllers/MenuController.dart';
import 'package:admin/create_app.dart';
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

class AuthenticationGate extends StatelessWidget {
  const AuthenticationGate({Key? key}) : super(key: key);

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

        Roles userRole = Roles.ADMIN;
        if (auth.currentUser?.email == 'manager@mysolve.com') {
          userRole = Roles.MANAGER;
        }

        // getRole(id: '115885384621082789849');

        // show app’s home page after login
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
            ChangeNotifierProvider(create: (context) => TicketsProvider()),
          ],
          child: CreateApp(auth: auth, userRole: userRole),
        );
      },
    );
  }

  /// {@id description:Firebase authentication user 'id'.}
  // Future getRole({required String id}) async {
  //   final docUser = FirebaseFirestore.instance.collection('users').doc(id);
  // }
}
