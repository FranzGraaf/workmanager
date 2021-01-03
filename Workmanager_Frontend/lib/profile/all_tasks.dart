import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:flutter/material.dart';

class All_Tasks extends StatefulWidget {
  static const String route = '/all_tasks';
  @override
  _All_TasksState createState() => _All_TasksState();
}

class _All_TasksState extends State<All_Tasks> {
  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: FloatingActionButton(
              heroTag: "",
              backgroundColor: Colors.greenAccent,
              child: Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).pushNamed(Main_Profile.route);
              },
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: 70,
            ),
            All_Tasks_List(
              type: All_Tasks_List_Type.open,
            ),
            All_Tasks_List(
              type: All_Tasks_List_Type.done,
            ),
          ],
        )
      ],
    );
  }
}

enum All_Tasks_List_Type { open, done }

class All_Tasks_List extends StatefulWidget {
  All_Tasks_List_Type type;
  All_Tasks_List({this.type});
  @override
  _All_Tasks_ListState createState() => _All_Tasks_ListState();
}

class _All_Tasks_ListState extends State<All_Tasks_List> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class All_Tasks_List_Element extends StatefulWidget {
  @override
  _All_Tasks_List_ElementState createState() => _All_Tasks_List_ElementState();
}

class _All_Tasks_List_ElementState extends State<All_Tasks_List_Element> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
