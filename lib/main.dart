import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
// import 'package:admin/model/db.dart';
// import 'package:admin/model/model.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/provider/UserProvider.dart';
import 'package:admin/screens/chat/chat_screen.dart';
import 'package:admin/screens/login/login_screen.dart';
import 'package:admin/screens/login/phone_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/matters/matters_screen.dart';
import 'package:admin/screens/myaccount/my_account_screen.dart';
import 'package:admin/screens/notification/notification_screen.dart';
import 'package:admin/screens/reports/reports_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/spiner/spinner_screen.dart';
import 'package:admin/screens/ticket/add_ticket.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/screens/ticket/tickets_screen_pluto_grid.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';



import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutterfire_ui/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Model model;
  bool _modelLoading = false;
  UserProvider userProvider;

  @override
  void initState() {
    // model = Model();
    super.initState();
  }

  //   @override
  // Widget build(BuildContext context) => StreamBuilder<User?>(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (context, snapshot) {
  //         // User is not signed in - show a sign-in screen
  //         if (!snapshot.hasData) {
  //           return SignInScreen(
  //             providerConfigs: [
  //               EmailProviderConfiguration(),
  //               GoogleProviderConfiguration(
  //                 clientId: 'xxxx-xxxx.apps.googleusercontent.com',
  //               ),
  //             ],
  //           );
  //         }

  //         return MainScreen(); // show your app’s home page after login
  //       },
  //     );

  @override
  Widget build(BuildContext context) {
    // userProvider = Provider.of<UserProvider>(context, listen: false);

    return _modelLoading
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Spinner(),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuController(),
              ),
              // ChangeNotifierProvider<Model>.value(value: model), // для авторизації
              ChangeNotifierProvider<UserProvider>.value(
                  value: userProvider), // для авторизації
              // ChangeNotifierProvider(create: (context) => Model()),
              // ChangeNotifierProvider(create: (context) => DataBase()),
              ChangeNotifierProvider(create: (context) => TicketsProvider()),
              ChangeNotifierProvider(create: (context) => UserProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'My Solve',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: primaryColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                canvasColor: primaryColor,
              ),
              routes: {
                '/main': (context) => MainScreen(),
                '/reports': (context) => ReportsScreen(),
                '/tickets': (context) => TicketsScreen(),
                '/tickets_pluto_grid': (context) => TicketsScreenPlutoGrid(),
                '/matters': (context) => MattersScreen(),
                '/chat': (context) => ChatScreen(),
                '/notification': (context) => NotificationScreen(),
                '/settings': (context) => SettingsScreen(),
                '/myaccount': (context) => MyAccountScreen(),
                '/login': (context) =>
                    userProvider.isSigned ? MainScreen() : LoginScreen(),
                // '/login': (context) => LoginScreen(),
                '/singin': (context) => PhoneScreen(),
                '/addticket': (context) => AddTicket(),
                '/editticket': (context) => AddTicket(),
              },
              // home: MainScreen(),
              home: LoginScreen(),
            ),
          );
  }
}
