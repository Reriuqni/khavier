export 'package:admin/routes/routes_by_role/admin_routes.dart';
export 'package:admin/routes/routes_by_role/auth_routes.dart';
export 'package:admin/routes/roles.dart';

import 'package:admin/routes/routes_by_role/manager_routes.dart';
import 'package:admin/routes/roles.dart';
import 'package:flutter/material.dart';

import 'routes_by_role/admin_routes.dart';
import 'routes_by_role/auth_routes.dart';

///  Get routes according to role (rights) of user.
///  * [getAuthRoutes], authentification routes | login`s routes.
///  * [getAdminRoutes], administrator routes.
Map<String, WidgetBuilder> getRoutes(
    BuildContext context, Roles userRole) {
  switch (userRole) {
    case Roles.AUTH:
      return getAuthRoutes(context);
    case Roles.ADMIN:
      return getAdminRoutes(context);
    case Roles.MANAGER:
    case Roles.ROLE_NOT_FOUND:
      return getNewUserRoutes(context);
    default:
      return throw 'Unsupported routes type: $userRole';
  }
}
