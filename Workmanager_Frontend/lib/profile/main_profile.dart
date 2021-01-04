import 'package:Workmanager_Frontend/global_stuff/DB_User.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_text_datepicker_v1.dart';
import 'package:Workmanager_Frontend/global_stuff/own_widgets/own_textinput_v1.dart';
import 'package:Workmanager_Frontend/profile/all_tasks.dart';
import 'package:flutter/material.dart';

enum Profile_Change_Data { email, password }
Map<String, dynamic> click_change_weekday_data;

class Main_Profile extends StatefulWidget {
  static const String route = '/main_profile';
  @override
  _Main_ProfileState createState() => _Main_ProfileState();
}

class _Main_ProfileState extends State<Main_Profile> {
  Future<void> _change_data(
      Profile_Change_Data pcd, BuildContext n_context) async {
    Widget _content() {
      switch (pcd) {
        case Profile_Change_Data.email:
          return Main_Profile_Change_Email(
            context: n_context,
          );
        case Profile_Change_Data.password:
          return Main_Profile_Change_Password(
            context: n_context,
          );
        default:
          return Container();
      }
    }

    return showGeneralDialog<void>(
        pageBuilder: (context, anim1, anim2) {
          return Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: Colors.black)),
                  width: 300,
                  height: 300,
                  child: _content(),
                ),
              )
            ],
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
      setState(() {});
    });
  }

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
              child: Icon(Icons.list_alt),
              onPressed: () {
                Navigator.of(context).pushNamed(All_Tasks.route);
              },
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: _on_mobile ? 70 : 10,
            ),
            SizedBox(
              width: _screen_size.width,
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 250,
                          child: Own_Textinput_V1(
                            init_text: auth_firebase.currentUser.email,
                            label: "E-Mail",
                            enabled: false,
                          )),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _change_data(Profile_Change_Data.email, context);
                          })
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 250,
                          child: Own_Textinput_V1(
                            init_text: "xxxxxxxxx",
                            label: "Passwort",
                            enabled: false,
                            obscure: true,
                          )),
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _change_data(Profile_Change_Data.password, context);
                          })
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: _on_mobile ? 10 : 30,
            ),
            Expanded(child: Main_Profile_Schedule_Setup()),
          ],
        ),
      ],
    );
  }
}

class Main_Profile_Change_Email extends StatefulWidget {
  BuildContext context;
  Main_Profile_Change_Email({this.context});
  @override
  _Main_Profile_Change_EmailState createState() =>
      _Main_Profile_Change_EmailState();
}

class _Main_Profile_Change_EmailState extends State<Main_Profile_Change_Email> {
  String _new_email = auth_firebase.currentUser.email;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                init_text: auth_firebase.currentUser.email,
                label: "neue E-Mail",
                enabled: true,
                on_changed: (value) {
                  _new_email = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  try {
                    await auth_firebase.currentUser.updateEmail(_new_email);
                    Navigator.of(context).pop();
                  } catch (e) {
                    Scaffold.of(widget.context).showSnackBar(SnackBar(
                      content: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }
                },
                child: Text("Ändern"),
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Abbrechen"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Main_Profile_Change_Password extends StatefulWidget {
  BuildContext context;
  Main_Profile_Change_Password({this.context});
  @override
  _Main_Profile_Change_PasswordState createState() =>
      _Main_Profile_Change_PasswordState();
}

class _Main_Profile_Change_PasswordState
    extends State<Main_Profile_Change_Password> {
  String _passwort_0 = "";
  String _passwort_1 = "";

  bool _check_input() {
    Scaffold.of(widget.context).removeCurrentSnackBar();
    if (_passwort_0.length < 6) {
      Scaffold.of(widget.context).showSnackBar(SnackBar(
        content: Text(
          "Das Passwort ist zu kurz.",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      return false;
    }
    if (_passwort_0 != _passwort_1) {
      Scaffold.of(widget.context).showSnackBar(SnackBar(
        content: Text(
          "Die Passwörter sind nicht identisch.",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                obscure: true,
                label: "neues Passwort",
                enabled: true,
                on_changed: (value) {
                  _passwort_0 = value;
                },
              )),
          SizedBox(
              width: 250,
              child: Own_Textinput_V1(
                obscure: true,
                label: "Passwort bestätigen",
                enabled: true,
                on_changed: (value) {
                  _passwort_1 = value;
                },
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                color: Colors.greenAccent,
                onPressed: () async {
                  try {
                    if (_check_input()) {
                      await auth_firebase.currentUser
                          .updatePassword(_passwort_0);
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    Scaffold.of(widget.context).removeCurrentSnackBar();
                    Scaffold.of(widget.context).showSnackBar(SnackBar(
                      content: Text(
                        e.toString(),
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(milliseconds: 1500),
                    ));
                  }
                },
                child: Text("Ändern"),
              ),
              RaisedButton(
                color: Colors.orangeAccent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Abbrechen"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class Main_Profile_Schedule_Setup extends StatefulWidget {
  @override
  _Main_Profile_Schedule_SetupState createState() =>
      _Main_Profile_Schedule_SetupState();
}

class _Main_Profile_Schedule_SetupState
    extends State<Main_Profile_Schedule_Setup> {
  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Container(
      //color: Colors.yellowAccent,
      child: Column(
        children: [
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.mo,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.tu,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.we,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.th,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.fr,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.sa,
            refresh: () {
              setState(() {});
            },
          ),
          Main_Profile_Schedule_Element(
            weekday: Schedule_Element_Weekday.so,
            refresh: () {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

enum Schedule_Element_Weekday { mo, tu, we, th, fr, sa, so }

class Main_Profile_Schedule_Element extends StatefulWidget {
  Schedule_Element_Weekday weekday;
  Function() refresh;
  Main_Profile_Schedule_Element({this.weekday, this.refresh});
  @override
  _Main_Profile_Schedule_ElementState createState() =>
      _Main_Profile_Schedule_ElementState();
}

class _Main_Profile_Schedule_ElementState
    extends State<Main_Profile_Schedule_Element> {
  String _get_weekday_name() {
    switch (widget.weekday) {
      case Schedule_Element_Weekday.mo:
        return "Mo";
      case Schedule_Element_Weekday.tu:
        return "Di";
      case Schedule_Element_Weekday.we:
        return "Mi";
      case Schedule_Element_Weekday.th:
        return "Do";
      case Schedule_Element_Weekday.fr:
        return "Fr";
      case Schedule_Element_Weekday.sa:
        return "Sa";
      case Schedule_Element_Weekday.so:
        return "So";
      default:
        return "Error";
    }
  }

  List<Map<String, dynamic>> _get_weekday_data() {
    switch (widget.weekday) {
      case Schedule_Element_Weekday.mo:
        return global_user_data.monday_time;
      case Schedule_Element_Weekday.tu:
        return global_user_data.tuesday_time;
      case Schedule_Element_Weekday.we:
        return global_user_data.wednesday_time;
      case Schedule_Element_Weekday.th:
        return global_user_data.thursday_time;
      case Schedule_Element_Weekday.fr:
        return global_user_data.friday_time;
      case Schedule_Element_Weekday.sa:
        return global_user_data.saturday_time;
      case Schedule_Element_Weekday.so:
        return global_user_data.sunday_time;
      default:
        return null;
    }
  }

  Future<void> _add_change_time_period(
      BuildContext n_context, Map<String, dynamic> period_change) async {
    return showGeneralDialog<void>(
        pageBuilder: (context, anim1, anim2) {
          return Main_Profile_Add_Change_Time_Period(
            weekday: widget.weekday,
            n_context: n_context,
            period_change: period_change,
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
      widget.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Expanded(
      child: Container(
        /*decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.black)),*/
        child: Row(
          children: [
            Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  //color: Colors.blueAccent,
                  ),
              width: _on_mobile ? 65 : 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    _get_weekday_name(),
                    style: TextStyle(fontSize: _on_mobile ? 14 : 30),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.add_alarm,
                        size: _on_mobile ? 20 : 30,
                      ),
                      onPressed: () {
                        _add_change_time_period(context, null);
                      })
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (click_change_weekday_data != null) {
                    _add_change_time_period(context, click_change_weekday_data);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    padding: const EdgeInsets.all(4.0),
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.orangeAccent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: CustomPaint(
                      painter:
                          Main_Profile_Schedule_Painter(_get_weekday_data()),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Main_Profile_Schedule_Painter extends CustomPainter {
  List<Map<String, dynamic>> weekday_data;
  Main_Profile_Schedule_Painter(this.weekday_data);
  Size n_size = Size(0, 0);
  @override
  void paint(Canvas canvas, Size size) {
    n_size = size;
    /*weekday_data = [
      {"start": DateTime(0, 0, 0, 5, 0), "end": DateTime(0, 0, 0, 6, 0)},
      {"start": DateTime(0, 0, 0, 12, 50), "end": DateTime(0, 0, 0, 13, 10)},
      {"start": DateTime(0, 0, 0, 20, 15), "end": DateTime(0, 0, 0, 23, 30)}
    ];*/
    var fill_brush = Paint()..color = Colors.orangeAccent;

    weekday_data.forEach((element) {
      double _minute_length = size.width / (24 * 60);
      double _start = (element["start"].hour * 60 + element["start"].minute) *
          _minute_length;
      double _end =
          (element["end"].hour * 60 + element["end"].minute) * _minute_length;
      canvas.drawRRect(
          RRect.fromLTRBR(_end, 0, _start, size.height, Radius.circular(0)),
          fill_brush);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    click_change_weekday_data = null;
    weekday_data.forEach((element) {
      double _minute_length = n_size.width / (24 * 60);
      double _start = (element["start"].hour * 60 + element["start"].minute) *
          _minute_length;
      double _end =
          (element["end"].hour * 60 + element["end"].minute) * _minute_length;
      if (position.dx >= _start && position.dx <= _end) {
        click_change_weekday_data = element;
        return super.hitTest(position);
      }
    });
    return super.hitTest(position);
  }
}

class Main_Profile_Add_Change_Time_Period extends StatefulWidget {
  BuildContext n_context;
  Schedule_Element_Weekday weekday;
  Map<String, dynamic> period_change;
  Main_Profile_Add_Change_Time_Period(
      {this.weekday, this.n_context, this.period_change});
  @override
  _Main_Profile_Add_Change_Time_PeriodState createState() =>
      _Main_Profile_Add_Change_Time_PeriodState();
}

class _Main_Profile_Add_Change_Time_PeriodState
    extends State<Main_Profile_Add_Change_Time_Period> {
  bool _change = false;
  Schedule_Element_Weekday _temp_weekday;
  DateTime _von = DateTime(0, 0, 0, 12, 0);
  DateTime _bis = DateTime(0, 0, 0, 13, 0);

  String _get_weekday_name(Schedule_Element_Weekday weekday) {
    switch (weekday) {
      case Schedule_Element_Weekday.mo:
        return "Mo";
      case Schedule_Element_Weekday.tu:
        return "Di";
      case Schedule_Element_Weekday.we:
        return "Mi";
      case Schedule_Element_Weekday.th:
        return "Do";
      case Schedule_Element_Weekday.fr:
        return "Fr";
      case Schedule_Element_Weekday.sa:
        return "Sa";
      case Schedule_Element_Weekday.so:
        return "So";
      default:
        return "Error";
    }
  }

  bool _check_input() {
    if (_change) {
      switch (_temp_weekday) {
        case Schedule_Element_Weekday.mo:
          global_user_data.monday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.tu:
          global_user_data.tuesday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.we:
          global_user_data.wednesday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.th:
          global_user_data.thursday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.fr:
          global_user_data.friday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.sa:
          global_user_data.saturday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        case Schedule_Element_Weekday.so:
          global_user_data.sunday_time
              .removeWhere((element) => element == widget.period_change);
          break;
        default:
          break;
      }
    }
    if (_von.isAfter(_bis)) {
      // sort _von and _bis
      DateTime _temp = _von;
      _von = _bis;
      _bis = _temp;
    }
    List<Map<String, dynamic>> _temp_times;
    switch (widget.weekday) {
      case Schedule_Element_Weekday.mo:
        _temp_times = global_user_data.monday_time;
        break;
      case Schedule_Element_Weekday.tu:
        _temp_times = global_user_data.tuesday_time;
        break;
      case Schedule_Element_Weekday.we:
        _temp_times = global_user_data.wednesday_time;
        break;
      case Schedule_Element_Weekday.th:
        _temp_times = global_user_data.thursday_time;
        break;
      case Schedule_Element_Weekday.fr:
        _temp_times = global_user_data.friday_time;
        break;
      case Schedule_Element_Weekday.sa:
        _temp_times = global_user_data.saturday_time;
        break;
      case Schedule_Element_Weekday.so:
        _temp_times = global_user_data.sunday_time;
        break;
      default:
        _temp_times = [];
    }
    bool _overlaps = false;
    for (Map<String, dynamic> element in _temp_times) {
      if (!((_von.isBefore(element["start"]) &&
              _bis.isBefore(element["start"])) ||
          (_von.isAfter(element["end"]) && _bis.isAfter(element["end"])))) {
        _overlaps = true;
        break;
      }
    }
    if (_overlaps) {
      Scaffold.of(widget.n_context).showSnackBar(SnackBar(
        content: Text(
          "Zeitfenster überlappt mit bereits vorhandenem Zeitfenster.",
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1500),
      ));
      if (_change) {
        switch (_temp_weekday) {
          case Schedule_Element_Weekday.mo:
            global_user_data.monday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.tu:
            global_user_data.tuesday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.we:
            global_user_data.wednesday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.th:
            global_user_data.thursday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.fr:
            global_user_data.friday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.sa:
            global_user_data.saturday_time.add(widget.period_change);
            break;
          case Schedule_Element_Weekday.so:
            global_user_data.sunday_time.add(widget.period_change);
            break;
          default:
            break;
        }
      }
      return false;
    }
    return true;
  }

  void _add_to_user_schedule() {
    switch (widget.weekday) {
      case Schedule_Element_Weekday.mo:
        global_user_data.monday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.tu:
        global_user_data.tuesday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.we:
        global_user_data.wednesday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.th:
        global_user_data.thursday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.fr:
        global_user_data.friday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.sa:
        global_user_data.saturday_time.add({"start": _von, "end": _bis});
        return;
      case Schedule_Element_Weekday.so:
        global_user_data.sunday_time.add({"start": _von, "end": _bis});
        return;
      default:
        return;
    }
    //TODO: add to database via backend
  }

  @override
  void initState() {
    super.initState();
    if (widget.period_change == null) {
      _change = false;
    } else {
      _change = true;
      _temp_weekday = widget.weekday;
      _von = widget.period_change["start"];
      _bis = widget.period_change["end"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Container(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Wochentag "),
                      DropdownButton<Schedule_Element_Weekday>(
                        value: widget.weekday,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (Schedule_Element_Weekday newValue) {
                          setState(() {
                            widget.weekday = newValue;
                          });
                        },
                        items: <Schedule_Element_Weekday>[
                          Schedule_Element_Weekday.mo,
                          Schedule_Element_Weekday.tu,
                          Schedule_Element_Weekday.we,
                          Schedule_Element_Weekday.th,
                          Schedule_Element_Weekday.fr,
                          Schedule_Element_Weekday.sa,
                          Schedule_Element_Weekday.so
                        ].map<DropdownMenuItem<Schedule_Element_Weekday>>(
                            (Schedule_Element_Weekday value) {
                          return DropdownMenuItem<Schedule_Element_Weekday>(
                            value: value,
                            child: Text(_get_weekday_name(value)),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text("von"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Own_Text_Datepicker_V1(
                      first_date:
                          DateTime.now().subtract(Duration(hours: 1000)),
                      pick_date: false,
                      pick_time: true,
                      date: _von,
                      onValueChanged: (new_date_time) {
                        setState(() {
                          _von = new_date_time;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text("bis"),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Own_Text_Datepicker_V1(
                      first_date:
                          DateTime.now().subtract(Duration(hours: 1000)),
                      pick_date: false,
                      pick_time: true,
                      date: _bis,
                      onValueChanged: (new_date_time) {
                        setState(() {
                          _bis = new_date_time;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.greenAccent,
                        onPressed: () {
                          if (_check_input()) {
                            _add_to_user_schedule();
                            Navigator.of(context).pop();
                          }
                        },
                        child: Icon(Icons.check),
                      ),
                      FloatingActionButton(
                        backgroundColor: Colors.redAccent,
                        onPressed: () {
                          Navigator.of(context).pop();
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
