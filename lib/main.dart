import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/provider/TicketsProvider.dart';
import 'package:admin/screens/chat/chat_screen.dart';
import 'package:admin/screens/login/phone_screen.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/matters/matters_screen.dart';
import 'package:admin/screens/myaccount/my_account_screen.dart';
import 'package:admin/screens/notification/notification_screen.dart';
import 'package:admin/screens/reports/reports_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/ticket/add_ticket.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/screens/ticket/tickets_screen_pluto_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'auth/config.dart';
import 'auth/decorations.dart';
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

final providerConfigs = [
  const EmailProviderConfiguration(),
  const PhoneProviderConfiguration(),
  const GoogleProviderConfiguration(clientId: GOOGLE_CLIENT_ID),
  const AppleProviderConfiguration(),
];

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

Map<String, WidgetBuilder> getAdminRoutes(BuildContext context) {
  return {
    '/': (context) => MainScreen(),
    '/reports': (context) => ReportsScreen(),
    '/tickets': (context) => TicketsScreen(),
    '/tickets_pluto_grid': (context) => TicketsScreenPlutoGrid(),
    '/matters': (context) => MattersScreen(),
    '/chat': (context) => ChatScreen(),
    '/notification': (context) => NotificationScreen(),
    '/settings': (context) => SettingsScreen(),
    '/myaccount': (context) => MyAccountScreen(),
    '/singin': (context) => PhoneScreen(),
    '/addticket': (context) => AddTicket(),
    '/editticket': (context) => AddTicket(),
    '/profile': (context) {
      return ProfileScreen(
        providerConfigs: providerConfigs,
        actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ],
      );
    },
    // '/login': (context) => LoginScreen(),
  };
}

Map<String, WidgetBuilder> getAuthRoutes(BuildContext context) {
  return {
    '/': (context) {
      return SignInScreen(
        actions: [
          ForgotPasswordAction((context, email) {
            Navigator.pushNamed(
              context,
              '/forgot-password',
              arguments: {'email': email},
            );
          }),
          VerifyPhoneAction((context, _) {
            Navigator.pushNamed(context, '/phone');
          }),
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.pushReplacementNamed(context, '/profile');
          }),
          EmailLinkSignInAction((context) {
            Navigator.pushReplacementNamed(context, '/email-link-sign-in');
          }),
        ],
        headerBuilder: headerImage('assets/images/flutterfire_logo.png'),
        sideBuilder: sideImage('assets/images/flutterfire_logo.png'),
        subtitleBuilder: (context, action) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              action == AuthAction.signIn
                  ? 'Welcome to My Solve! Please sign in to continue.'
                  : 'Welcome to My Solve! Please create an account to continue',
            ),
          );
        },
        footerBuilder: (context, action) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                action == AuthAction.signIn
                    ? 'By signing in, you agree to our terms and conditions.'
                    : 'By registering, you agree to our terms and conditions.',
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
        providerConfigs: providerConfigs,
      );
    },
    '/phone': (context) {
      return PhoneInputScreen(
        actions: [
          SMSCodeRequestedAction((context, action, flowKey, phone) {
            Navigator.of(context).pushReplacementNamed(
              '/sms',
              arguments: {
                'action': action,
                'flowKey': flowKey,
                'phone': phone,
              },
            );
          }),
        ],
        headerBuilder: headerIcon(Icons.phone),
        sideBuilder: sideIcon(Icons.phone),
      );
    },
    '/sms': (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return SMSCodeInputScreen(
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            Navigator.of(context).pushReplacementNamed('/profile');
          })
        ],
        flowKey: arguments?['flowKey'],
        action: arguments?['action'],
        headerBuilder: headerIcon(Icons.sms_outlined),
        sideBuilder: sideIcon(Icons.sms_outlined),
      );
    },
    '/profile': (context) {
      return ProfileScreen(
        providerConfigs: providerConfigs,
        actions: [
          SignedOutAction((context) {
            Navigator.pushReplacementNamed(context, '/');
          }),
        ],
      );
    },
    '/forgot-password': (context) {
      final arguments =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      return ForgotPasswordScreen(
        email: arguments?['email'],
        headerMaxExtent: 200,
        headerBuilder: headerIcon(Icons.lock),
        sideBuilder: sideIcon(Icons.lock),
      );
    },
  };
}
