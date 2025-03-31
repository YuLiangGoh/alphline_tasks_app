import 'package:flutter/material.dart';
import 'package:task/app/app_global.dart';
import 'package:task/screen/dashboard/dashboard_page.dart';
import 'package:task/screen/dashboard/view_edit_task_page.dart';

class AppRoute {
  AppRoute._();

  static const String dashboard = '/dashboard';
  static const String viewEditTask = '/viewEditTask';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    MaterialPageRoute<dynamic> materialPageRoute(Widget route) {
      return MaterialPageRoute(builder: (_) => route, settings: settings);
    }

    switch (settings.name) {
      case dashboard:
        return materialPageRoute(const DashboardPage());
      case viewEditTask:
        final args = settings.arguments as ViewEditTaskPage?;
        return materialPageRoute(ViewEditTaskPage(task: args?.task));
      default:
        return materialPageRoute(const DashboardPage());
    }
  }

  static pushPage(String routeName, [dynamic arguments]) =>
      Navigator.of(globalContext).pushNamed(routeName, arguments: arguments);

  static pushReplacementPage(String routeName) =>
      Navigator.of(globalContext).pushReplacementNamed(routeName);

  static pushAndRemoveUntilPage(String routeName) => Navigator.of(
    globalContext,
  ).pushNamedAndRemoveUntil(routeName, (route) => false);

  static popPage() => Navigator.of(globalContext).pop();
}
