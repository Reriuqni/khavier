import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/routers/admin_routes.dart';
import 'package:admin/routers/auth_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:google_fonts/google_fonts.dart';
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
          return CreateMaterialApp(auth: auth, routesType: RoutesType.AUTH);
        }

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
            ChangeNotifierProvider(create: (context) => TicketsProvider()),
          ],
          child: CreateMaterialApp(auth: auth, routesType: RoutesType.ADMIN),
        ); // show your app’s home page after login
      },
    );
  }
}

class CreateMaterialApp extends StatelessWidget {
  const CreateMaterialApp({
    Key? key,
    required this.auth,
    required this.routesType,
  }) : super(key: key);

  final FirebaseAuth auth;
  final RoutesType routesType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Solve',
      debugShowCheckedModeBanner: false,
      theme: getThemeData(context),
      // initialRoute: auth.currentUser == null ? '/' : '/profile',
      initialRoute: '/',
      routes: getRoutes(context, routesType),
      locale: const Locale('au'),
      localizationsDelegates: [
        FlutterFireUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterFireUILocalizations.delegate,
      ],
    );
  }
}

// Overrides a label for en locale
// To add localization for a custom language follow the guide here:
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

ThemeData getThemeData(BuildContext context) {
  return ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.standard,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
        .apply(bodyColor: Colors.black),
    canvasColor: primaryColor,
  );
}

enum RoutesType {
  AUTH,
  ADMIN,
}

Map<String, WidgetBuilder> getRoutes(
    BuildContext context, RoutesType routesType) {
  switch (routesType) {
    case RoutesType.AUTH:
      return getAuthRoutes(context);
    case RoutesType.ADMIN:
      return getAdminRoutes(context);
    default:
      return throw 'Unsupported routes type: $routesType';
  }
}
