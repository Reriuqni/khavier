import 'package:admin/constants/texts.dart';
import 'package:admin/routes/index.dart';
import 'package:admin/themes/default.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';

class CreateApp extends StatelessWidget {
  const CreateApp({
    Key? key,
    required this.auth,
    required this.routesType,
  }) : super(key: key);

  final FirebaseAuth auth;
  final Roles routesType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: PROJECT_NAME,
      debugShowCheckedModeBanner: false,
      theme: getDefaultTheme(context),
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
