import 'package:admin/constants.dart';
import 'package:admin/model/api_model.dart';
import 'package:admin/model/model.dart';
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
import 'package:admin/controllers/MenuController.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late Model model;
  late ApiModel apiModel;
  bool _modelLoading = false;

  @override
  void initState() {
    model = Model();
    apiModel = ApiModel();
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
              ChangeNotifierProvider<Model>.value(value: model),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'MySolve',
              theme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: bgColor,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                canvasColor: secondaryColor,
              ),
              routes: {
                '/main': (context) => MainScreen(),
                '/reports': (context) => ReportsScreen(),
                '/tickets': (context) => TicketsScreen(),
                '/matters': (context) => MattersScreen(),
                '/chat': (context) => ChatScreen(),
                '/notification': (context) => NotificationScreen(),
                '/settings': (context) => SettingsScreen(),
                '/myaccount': (context) => MyAccountScreen(),
                '/login': (context) => model.db.isSigned ? MainScreen() : LoginScreen(),
                '/singin': (context) => PhoneScreen(),
              },
              home: MainScreen(),
            ),
          );
  }
}
