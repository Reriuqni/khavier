import 'package:admin/screens/chat/chat_screen.dart';
import 'package:admin/screens/login/my_profile.dart';
import 'package:admin/screens/users/users.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/users/add_user.dart';
import 'package:admin/screens/matters/matters_screen.dart';
import 'package:admin/screens/myaccount/my_account_screen.dart';
import 'package:admin/screens/notification/notification_screen.dart';
import 'package:admin/screens/reports/reports_screen.dart';
import 'package:admin/screens/settings/settings_screen.dart';
import 'package:admin/screens/ticket/add_ticket.dart';
import 'package:admin/screens/ticket/tickets_screen.dart';
import 'package:admin/screens/ticket/tickets_screen_pluto_grid.dart';
import 'package:flutter/material.dart';

import '../../screens/userGroups/manageUserGroups.dart';
import '../../screens/userGroups/userGroups.dart';

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
    '/addticket': (context) => AddTicket(),
    '/editticket': (context) => AddTicket(),
    '/profile': (context) => ProfilePage(),
    '/users': (context) => UsersPage(),
    '/addUser': (context) => NewUserPage(),
    '/userGroups': (context) => UserGroupsPage(),
    '/editUserGroups' : (context) => UserGroupsEdit(),
  };
}
