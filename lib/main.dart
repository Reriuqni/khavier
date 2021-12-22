import 'dart:html';
import 'dart:js';

import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
// import 'package:admin/model/db.dart';
// import 'package:admin/model/model.dart';
import 'package:admin/provider/TicketsProvider.dart';
// import 'package:admin/provider/UserProvider.dart';
import 'package:admin/screens/chat/chat_screen.dart';
import 'package:admin/screens/login/login_screen.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'init.dart'
    if (dart.library.html) 'web_init.dart'
    if (dart.library.io) 'io_init.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/i10n.dart';

import 'init.dart'
    if (dart.library.html) 'web_init.dart'
    if (dart.library.io) 'io_init.dart';

import 'config.dart';
import 'decorations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  // runApp(MyApp());
  runApp(AuthenticationGate());
}

// Overrides a label for en locale
// To add localization for a custom language follow the guide here:
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

final emailLinkProviderConfig = EmailLinkProviderConfiguration(
  actionCodeSettings: ActionCodeSettings(
    url: 'https://reactnativefirebase.page.link',
    handleCodeInApp: true,
    androidMinimumVersion: '12',
    androidPackageName:
        'io.flutter.plugins.flutterfire_ui.flutterfire_ui_example',
    iOSBundleId: 'io.flutter.plugins.flutterfireui.flutterfireUIExample',
  ),
);

final providerConfigs = [
  const EmailProviderConfiguration(),
  emailLinkProviderConfig,
  const PhoneProviderConfiguration(),
  const GoogleProviderConfiguration(clientId: GOOGLE_CLIENT_ID),
  const AppleProviderConfiguration(),
  // const FacebookProviderConfiguration(clientId: FACEBOOK_CLIENT_ID),
  // const TwitterProviderConfiguration(
  //   apiKey: TWITTER_API_KEY,
  //   apiSecretKey: TWITTER_API_SECRET_KEY,
  //   redirectUri: TWITTER_REDIRECT_URI,
  // ),
];

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
          // return LoginScreen();
          // return FlutterFireUIWidget(auth: auth);
          return FlutterFireUIWidget(auth: auth);
        }

        return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => MenuController(),
              ),
              ChangeNotifierProvider(create: (context) => TicketsProvider()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MainScreen(),
              theme: ThemeData(
                scaffoldBackgroundColor: primaryColor,
                textTheme:
                    GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
                        .apply(bodyColor: Colors.black),
                canvasColor: primaryColor,
              ),
              routes: {
                // '/main': (context) => MainScreen(),
                '/reports': (context) => ReportsScreen(),
                '/tickets': (context) => TicketsScreen(),
                '/tickets_pluto_grid': (context) => TicketsScreenPlutoGrid(),
                '/matters': (context) => MattersScreen(),
                '/chat': (context) => ChatScreen(),
                '/notification': (context) => NotificationScreen(),
                '/settings': (context) => SettingsScreen(),
                '/myaccount': (context) => MyAccountScreen(),
                // '/login': (context) =>
                //     userProvider!.isSigned ? MainScreen() : LoginScreen(),
                // '/login': (context) => LoginScreen(),
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
              },
            )); // show your app’s home page after login
      },
    );
  }
}

class FlutterFireUIWidget extends StatelessWidget {
  const FlutterFireUIWidget({
    Key? key,
    required this.auth,
  }) : super(key: key);

  final FirebaseAuth auth;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        visualDensity: VisualDensity.standard,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: primaryColor,
      ),
      initialRoute: auth.currentUser == null ? '/' : '/profile',
      routes: {
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
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

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
          final arguments = ModalRoute.of(context)?.settings.arguments
              as Map<String, dynamic>?;

          return ForgotPasswordScreen(
            email: arguments?['email'],
            headerMaxExtent: 200,
            headerBuilder: headerIcon(Icons.lock),
            sideBuilder: sideIcon(Icons.lock),
          );
        },
        '/email-link-sign-in': (context) {
          return EmailLinkSignInScreen(
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/profile');
              }),
            ],
            config: emailLinkProviderConfig,
            headerMaxExtent: 200,
            headerBuilder: headerIcon(Icons.link),
            sideBuilder: sideIcon(Icons.link),
          );
        },
      },
      title: 'My Solve',
      debugShowCheckedModeBanner: false,
      locale: const Locale('en'),
      localizationsDelegates: [
        FlutterFireUILocalizations.withDefaultOverrides(const LabelOverrides()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterFireUILocalizations.delegate,
      ],
    );
  }
}




/* class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Model model;
  bool _modelLoading = false;
  UserProvider? userProvider;

  @override
  void initState() {
    // model = Model();
    super.initState();
  }

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
              ChangeNotifierProvider<UserProvider?>.value(
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
                    GoogleFonts.montserratTextTheme(Theme.of(context).textTheme)
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
                    userProvider!.isSigned ? MainScreen() : LoginScreen(),
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
 */
