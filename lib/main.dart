import 'package:admin/api/firebase_api.dart';
import 'package:admin/apps/preloader_app.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/apps/create_app.dart';
import 'package:admin/model/user.dart' as SolveUser;
import 'package:admin/provider/NewVersionUserProvider.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/routes/roles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nested/nested.dart';
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
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        // User is not signed in - show a sign-in screen
        if (!snapshot.hasData) {
          return CreateApp(userRole: Roles.AUTH);
        }

        // show app’s home page after login
        return FutureBuilder(
          future: FirebaseApi.readOrCreateUser(authUser: snapshot),
          builder: (BuildContext context,
              AsyncSnapshot<SolveUser.User?> userSnapshot) {
            if (userSnapshot.hasData) {
              final solveUser = userSnapshot.data;

              if (solveUser == null) {
                return CreateApp(userRole: Roles.AUTH);
              } else {
                return MultiProvider(
                  providers: listProviders,
                  child: CreateApp(userRole: solveUser.accountType),
                );
              }
            } else
              return Preloader();
          },
        );
      },
    );
  }

  List<SingleChildWidget> get listProviders {
    return [
      ChangeNotifierProvider(
        create: (context) => MenuController(),
      ),
      ChangeNotifierProvider(create: (context) => TicketsProvider()),
      ChangeNotifierProvider(create: (context) => NewVersionUserProvider()),
    ];
  }
}
