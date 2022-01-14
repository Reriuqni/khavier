import 'package:admin/auth/provider_configs.dart';
import 'package:admin/screens/myaccount/my_account_screen.dart';
import 'package:admin/screens/reports/reports_screen.dart';
import 'package:admin/screens/users/users.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

Map<String, WidgetBuilder> getNewUserRoutes(BuildContext context) {
  return {
    '/': (context) => ReportsScreen(),
    '/myaccount': (context) => MyAccountScreen(),
    '/users': (context) => UsersPage(),
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
  };
}
