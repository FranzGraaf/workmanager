import 'package:Workmanager_Frontend/calender_views/day_calender.dart';
import 'package:Workmanager_Frontend/global_stuff/backend_com.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  static const String route = '/homepage';
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Backend_Com().sort_open_tasks();
      },
      child: Container(
        child: Center(
          child: Day_Calender(), //Text("homepage"),
        ),
      ),
    );
  }
}
