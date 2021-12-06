import 'package:admin/constants.dart';
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
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/screens/ticket/add_ticket.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/ticket/tickets_screen_pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

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
  UserPovider userPovider;

  @override
  void initState() {
    // model = Model();
    userPovider = UserPovider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              // ChangeNotifierProvider(create: (context) => Model()),
              // ChangeNotifierProvider(create: (context) => DataBase()),
              ChangeNotifierProvider(create: (context) => TicketsProvider()),
              ChangeNotifierProvider(create: (context) => UserPovider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MySolve',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: primaryColor,
                textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black),
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
                // '/login': (context) => model.db.isSigned ? MainScreen() : LoginScreen(),
                '/login': (context) => LoginScreen(),
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
