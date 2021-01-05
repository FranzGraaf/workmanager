import 'package:Workmanager_Frontend/calender_views/day_calender.dart';
import 'package:Workmanager_Frontend/calender_views/month_calender.dart';
import 'package:Workmanager_Frontend/calender_views/week_calender.dart';
import 'package:Workmanager_Frontend/calender_views/year_calender.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/homepage.dart';
import 'package:Workmanager_Frontend/login_register/login.dart';
import 'package:Workmanager_Frontend/main.dart';
import 'package:Workmanager_Frontend/profile/add_change_task_popup.dart';
import 'package:Workmanager_Frontend/profile/all_tasks.dart';
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
    All_Tasks.route,
  ];

  Future<void> _add_task(BuildContext n_context) async {
    return showGeneralDialog<Map<String, dynamic>>(
        pageBuilder: (context, anim1, anim2) {
          return Add_Change_Task_Popup(
            n_context: n_context,
          );
        },
        context: context,
        barrierDismissible: true, // true = user can tab barrier to close
        barrierLabel: "barrierLabel",
        barrierColor: Colors.grey.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 250),
        transitionBuilder: (context, anim1, anim2, child) {
          return Transform.scale(
            scale: anim1.value,
            child: child,
          );
        }).then((value) {
      Scaffold.of(n_context).removeCurrentSnackBar();
      try {
        global_streamController_task_added.add(value);
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            alignment: Alignment.topLeft,
            width: 250,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(60))),
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                ),
                IconButton(
                  icon: Icon(
                    Icons.view_day,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Day_Calender.route);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_view_day,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Week_Calender.route);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Month_Calender.route);
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.calendar_today_sharp,
                    size: 15,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Year_Calender.route);
                  },
                ),
              ],
            ),
          ),
        ),
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
                      _add_task(context);
                    },
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
