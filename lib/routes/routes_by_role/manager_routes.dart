import 'package:admin/auth/provider_configs.dart';
import 'package:admin/screens/chat/chat_screen.dart';
// import 'package:admin/screens/login/my_profile.dart';
import 'package:admin/screens/login/phone_screen.dart';
// import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/matters/matters_screen.dart';
import 'package:admin/screens/myaccount/my_account_screen.dart';
import 'package:admin/screens/notification/notification_screen.dart';
import 'package:admin/screens/reports/reports_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/ticket/add_ticket.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/screens/ticket/tickets_screen_pluto_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

Map<String, WidgetBuilder> getManagerRoutes(BuildContext context) {
  return {
    '/': (context) => ReportsScreen(),
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
    // '/profile': (context) => ProfilePage(),
    // '/profile': (context) => MyAccountScreen(),
    '/profile': (context) {
      // FirebaseAuth.instance.signOut();
      // Navigator.pushReplacementNamed(context, '/');

      // return SizedBox.shrink();

      // return AuthExit();

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


// class AuthExit extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // initialRoute: auth.currentUser == null ? '/' : '/profile',
//       home:Navigator.pushReplacementNamed(context, '/');,
//     );
//   }
// }
