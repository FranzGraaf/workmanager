import 'package:Workmanager_Frontend/global_stuff/backend_com.dart';
import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_rot_button.dart';
import 'package:Workmanager_Frontend/profile/add_change_task_popup.dart';
import 'package:Workmanager_Frontend/profile/main_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class All_Tasks extends StatefulWidget {
  static const String route = '/all_tasks';
  @override
  _All_TasksState createState() => _All_TasksState();
}

class _All_TasksState extends State<All_Tasks> {
  @override
  void initState() {
    super.initState();
    global_streamController_task_added.stream.listen((event) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
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
  bool _open;
  List<Map<String, dynamic>> _task_list;
  double _header_height = 50;
  double _element_height = 40;

  @override
  void initState() {
    super.initState();
    _open = widget.type == All_Tasks_List_Type.open ? true : false;
    _task_list = widget.type == All_Tasks_List_Type.open
        ? global_user_data.tasks_open
        : global_user_data.tasks_done;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 750),
      curve: Curves.elasticOut,
      height: _open
          ? _header_height + _task_list.length * _element_height
          : _header_height,
      color: widget.type == All_Tasks_List_Type.open
          ? Colors.orangeAccent
          : Colors.greenAccent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: _header_height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.type == All_Tasks_List_Type.open
                      ? "offene Aufgaben"
                      : "abgeschlossene Aufgaben",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Own_Rot_Button(
                  initopen: _open,
                  icon: Icons.format_list_bulleted,
                  onPressed: () {
                    setState(() {
                      _open = !_open;
                    });
                  },
                )
              ],
            ),
          ),
          for (int i = 0; i < _task_list.length; i++)
            _open
                ? All_Tasks_List_Element(
                    index: i,
                    task_list: _task_list,
                    height: _element_height,
                    type: widget.type,
                  )
                : Container()
        ],
      ),
    );
  }
}

class All_Tasks_List_Element extends StatefulWidget {
  All_Tasks_List_Type type;
  List<Map<String, dynamic>> task_list;
  int index;
  double height;
  All_Tasks_List_Element({this.task_list, this.index, this.height, this.type});
  @override
  _All_Tasks_List_ElementState createState() => _All_Tasks_List_ElementState();
}

class _All_Tasks_List_ElementState extends State<All_Tasks_List_Element> {
  Future<void> _change_task(BuildContext n_context) async {
    return showGeneralDialog<Map<String, dynamic>>(
        pageBuilder: (context, anim1, anim2) {
          return Add_Change_Task_Popup(
            task_change: widget.task_list[widget.index],
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
    Duration _duration = widget.task_list[widget.index]["duration"];

    return GestureDetector(
      onTap: () {
        if (widget.type == All_Tasks_List_Type.open) {
          _change_task(context);
        }
      },
      child: Container(
          height: widget.height,
          padding: EdgeInsets.all(2),
          child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  //border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Checkbox(
                      value: widget.type == All_Tasks_List_Type.done,
                      onChanged: (value) {
                        if (widget.type == All_Tasks_List_Type.done) {
                          Backend_Com()
                              .task_to_open(widget.task_list[widget.index]);
                          Backend_Com()
                              .delete_done_task(widget.task_list[widget.index]);
                          global_user_data.tasks_open
                              .add(widget.task_list[widget.index]);
                          widget.task_list.removeAt(widget.index);
                        } else {
                          Backend_Com()
                              .task_to_done(widget.task_list[widget.index]);
                          Backend_Com()
                              .delete_open_task(widget.task_list[widget.index]);
                          global_user_data.tasks_done
                              .add(widget.task_list[widget.index]);
                          widget.task_list.removeAt(widget.index);
                        }
                        global_streamController_task_added.add(null);
                      }),
                  Text(widget.task_list[widget.index]["title"]),
                  Text(DateFormat('dd.MM.yyyy')
                      .format(widget.task_list[widget.index]["deadline"])),
                  Text(printDuration(
                      widget.task_list[widget.index]["duration"])),
                  Text("Prio: " +
                      widget.task_list[widget.index]["priority"].toString()),
                ],
              ))),
    );
  }
}
