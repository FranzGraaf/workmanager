import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:Workmanager_Frontend/login_register/login.dart';
import 'package:Workmanager_Frontend/login_register/register.dart';
import 'package:Workmanager_Frontend/main.dart';
import 'package:Workmanager_Frontend/profile/all_tasks.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Main_Profile.route:
      if (global_usertype == Usertype.visitor) {
        return _default_PageRoute(
            RouteSettings(name: Homepage.route, arguments: settings.arguments));
      }
      return _default_PageRoute(settings);
    case All_Tasks.route:
      if (global_usertype == Usertype.visitor) {
        return _default_PageRoute(
            RouteSettings(name: Homepage.route, arguments: settings.arguments));
      }
      return _default_PageRoute(settings);
    default:
      return _default_PageRoute(settings);
  }
}

PageRoute _default_PageRoute(RouteSettings settings) {
  return PageRouteBuilder(
      pageBuilder: (_, a1, a2) {
        global_active_route = settings.name;
        return Main(
          arguments: settings.arguments,
        );
      },
      settings: RouteSettings(name: settings.name));
}
