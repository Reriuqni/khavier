export 'package:admin/routes/admin_routes.dart';
export 'package:admin/routes/auth_routes.dart';
export 'package:admin/routes/routes_type.dart';

import 'package:admin/routes/routes_type.dart';
import 'package:flutter/material.dart';

import 'admin_routes.dart';
import 'auth_routes.dart';

///  Get routes according to role (rights) of user.
///  * [getAuthRoutes], authentification routes | login`s routes.
///  * [getAdminRoutes], administrator routes.
Map<String, WidgetBuilder> getRoutes(
    BuildContext context, Role routesType) {
  switch (routesType) {
    case Role.AUTH:
      return getAuthRoutes(context);
    case Role.ADMIN:
      return getAdminRoutes(context);
    default:
      return throw 'Unsupported routes type: $routesType';
  }
}
