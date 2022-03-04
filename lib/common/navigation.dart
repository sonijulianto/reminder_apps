import 'package:flutter/material.dart';
import 'package:local_db/pages/task_list_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation{
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();

  static home() => navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => TaskListPage()));
}