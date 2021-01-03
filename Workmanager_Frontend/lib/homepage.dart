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
        //TODO: counter up
        Backend_Com().up();
      },
      child: Container(
        child: Center(
          child: Text("homepage"),
        ),
      ),
    );
  }
}
