export 'package:admin/routes/admin_routes.dart';
export 'package:admin/routes/auth_routes.dart';
export 'package:admin/routes/roles.dart';

import 'package:admin/routes/roles.dart';
import 'package:flutter/material.dart';

import 'admin_routes.dart';
import 'auth_routes.dart';

///  Get routes according to role (rights) of user.
///  * [getAuthRoutes], authentification routes | login`s routes.
///  * [getAdminRoutes], administrator routes.
Map<String, WidgetBuilder> getRoutes(
    BuildContext context, Roles routesType) {
  switch (routesType) {
    case Roles.AUTH:
      return getAuthRoutes(context);
    case Roles.ADMIN:
      return getAdminRoutes(context);
    default:
      return throw 'Unsupported routes type: $routesType';
  }
}
