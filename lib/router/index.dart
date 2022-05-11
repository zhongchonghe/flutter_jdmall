
import 'package:flutter/material.dart';

import '../pages/Error.dart';
import '../pages/Tabs.dart';
import '../pages/product/productList.dart';

// 配置路由
final Map<String, Function> routes = {
  '/': (context) => Tabs(),
  '/productList':(context, {arguments})=> ProductListPage(arguments:arguments)
  
  };

// ignore: prefer_function_declarations_over_variables
final RouteFactory onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageBuilder = routes[name];
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      return MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments));
    } else {
      return MaterialPageRoute(builder: (context) => pageBuilder(context));
    }
  }
  return null;
};
// ignore: prefer_function_declarations_over_variables
final RouteFactory onUnknownRoute = (RouteSettings settings) {
  return MaterialPageRoute(builder: ((context) => const ErrorPage()));
};
