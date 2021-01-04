import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_duration_picker.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_text_datepicker_v1.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_textinput_v1.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Add_Change_Task_Popup extends StatefulWidget {
  BuildContext n_context;
  Map<String, dynamic> task_change;
  Add_Change_Task_Popup({this.n_context, this.task_change});
  @override
  _Add_Change_Task_PopupState createState() => _Add_Change_Task_PopupState();
}

class _Add_Change_Task_PopupState extends State<Add_Change_Task_Popup> {
  Map<String, dynamic> _task_old = {};
  Map<String, dynamic> _task = {};
  bool _change = false;

  bool _check_input() {
    if (_task["title"] == "") {
      Scaffold.of(widget.n_context).showSnackBar(SnackBar(
        content: Text(
          "Bitte geben Sie einen Titel ein",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    if (widget.task_change == null) {
      _change = false;
      _task["title"] = "";
      Duration _init_duration = Duration(hours: 1, minutes: 0);
      _task["duration"] = _init_duration;
      DateTime _init_datetime = DateTime.now().add(Duration(days: 1));
      _init_datetime = DateTime(_init_datetime.year, _init_datetime.month,
          _init_datetime.day); // remove hours and minutes from new_date_time
      // init the task
      _task["deadline"] = _init_datetime;
      int _prio = 1;
      _task["priority"] = _prio;
      _task["description"] = "";
    } else {
      _change = true;
      _task = widget.task_change;
      _task_old = widget.task_change;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2, color: Colors.black)),
            width: 300,
            height: 500,
            child: Material(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Own_Textinput_V1(
                    label: "Titel",
                    init_text: _task["title"],
                    on_changed: (value) {
                      _task["title"] = value;
                    },
                  ),
                  Own_Duration_Picker(
                    label: "Dauer",
                    duration: _task["duration"],
                    onValueChanged: (new_duration) {
                      _task["duration"] = new_duration;
                    },
                  ),
                  Own_Text_Datepicker_V1(
                    label: "Deadline",
                    first_date: DateTime.now(),
                    date: _task["deadline"],
                    pick_date: true,
                    pick_time: false,
                    onValueChanged: (new_date_time) {
                      // remove hours and minutes from new_date_time
                      new_date_time = DateTime(new_date_time.year,
                          new_date_time.month, new_date_time.day);
                      _task["deadline"] = new_date_time;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Prio "),
                      DropdownButton<int>(
                        value: _task["priority"],
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (int newValue) {
                          setState(() {
                            _task["priority"] = newValue;
                          });
                        },
                        items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Own_Textinput_V1(
                      init_text: _task["description"],
                      max_lines:
                          500, // just a big number to fill rest of screen
                      label: "Beschreibung",
                      on_changed: (value) {
                        _task["description"] = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.greenAccent,
                        onPressed: () {
                          if (_check_input()) {
                            if (_change) {
                              global_user_data.tasks_open[
                                      global_user_data.tasks_open.indexWhere(
                                          (element) => element == _task_old)] =
                                  _task;
                              // TODO: change Task in backend
                            } else {
                              global_user_data.tasks_open.add(_task);
                              // TODO: add Task in backend
                            }
                            Navigator.of(context).pop(_task);
                          }
                        },
                        child: Icon(Icons.check),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.redAccent,
                        onPressed: () {
                          Navigator.of(context).pop(null);
                        },
                        child: Icon(Icons.delete),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
