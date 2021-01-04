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
        Backend_Com().increment_counter();
      },
      child: Container(
        child: Center(
          child: Text("homepage"),
        ),
      ),
    );
  }
}
