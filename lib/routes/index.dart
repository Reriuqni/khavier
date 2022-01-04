export 'package:admin/routes/admin_routes.dart';
export 'package:admin/routes/auth_routes.dart';
export 'package:admin/routes/routes_type.dart';

import 'package:admin/routes/routes_type.dart';
import 'package:flutter/material.dart';

import 'admin_routes.dart';
import 'auth_routes.dart';

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
