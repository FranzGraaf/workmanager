import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:Workmanager_Frontend/login_register/login.dart';
import 'package:Workmanager_Frontend/main.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:flutter/material.dart';

class Header_Footer extends StatefulWidget {
  @override
  _Header_FooterState createState() => _Header_FooterState();
}

class _Header_FooterState extends State<Header_Footer> {
  final List<String> _show_add_task = [
    Homepage.route,
    Main.route,
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60))),
            child: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        _show_add_task.contains(global_active_route)
            ? Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FloatingActionButton(
                    backgroundColor: Colors.orangeAccent,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      //TODO: Add task
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
