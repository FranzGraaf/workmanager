import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Day_Calender extends StatefulWidget {
  static const String route = '/day_calender';
  @override
  _Day_CalenderState createState() => _Day_CalenderState();
}

class _Day_CalenderState extends State<Day_Calender> {
  List<Map<String, dynamic>> _today_tasks;
  Weekday _weekday;
  final List<Weekday> _weekdays = [
    Weekday.mo,
    Weekday.tu,
    Weekday.we,
    Weekday.th,
    Weekday.fr,
    Weekday.sa,
    Weekday.so
  ];

  @override
  void initState() {
    super.initState();
    if (global_view_date == null) {
      global_view_date = DateTime.now();
    }
    _weekday = _weekdays[global_view_date.weekday - 1];
    _today_tasks = [];
    if (global_user_data != null) {
      //TODO: take processed start and end times for tasks
      global_user_data.tasks_open.forEach((element) {
        _today_tasks = [];
        _today_tasks.add({
          "start": DateTime(0, 0, 0, 10, 30),
          "duration": Duration(hours: 0, minutes: 45),
          "task": element
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 70,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                icon: Icon(
                  Icons.arrow_left,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    global_view_date =
                        global_view_date.subtract(Duration(days: 1));
                    _weekday = _weekdays[global_view_date.weekday - 1];
                  });
                }),
            Text(
              get_weekday_name(_weekday),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_right,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    global_view_date = global_view_date.add(Duration(days: 1));
                    _weekday = _weekdays[global_view_date.weekday - 1];
                  });
                }),
          ],
        ),
        Center(
          child: Text(intl.DateFormat('dd.MM.yyyy').format(global_view_date)),
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 2400,
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Positioned.fill(
                  child: CustomPaint(painter: Day_Calender_Painter(_weekday))),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                    width: _screen_size.width - 40,
                    child: Stack(
                      children: [
                        for (var i in _today_tasks)
                          Positioned(
                              top: i["start"].hour * 100 +
                                  i["start"].minute * 100 / 60,
                              child: Day_Calender_Task_Element(
                                width: _screen_size.width - 40,
                                task: i,
                              ))
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
        )
      ],
    ));
  }
}

class Day_Calender_Painter extends CustomPainter {
  Weekday _weekday;
  Day_Calender_Painter(this._weekday);
  List<Map<String, dynamic>> _schedule_day_list;

  void _get_schedule_day() {
    if (global_user_data != null) {
      switch (_weekday) {
        case Weekday.mo:
          _schedule_day_list = global_user_data.monday_time;
          break;
        case Weekday.tu:
          _schedule_day_list = global_user_data.tuesday_time;
          break;
        case Weekday.we:
          _schedule_day_list = global_user_data.wednesday_time;
          break;
        case Weekday.th:
          _schedule_day_list = global_user_data.thursday_time;
          break;
        case Weekday.fr:
          _schedule_day_list = global_user_data.friday_time;
          break;
        case Weekday.sa:
          _schedule_day_list = global_user_data.saturday_time;
          break;
        case Weekday.so:
          _schedule_day_list = global_user_data.sunday_time;
          break;
        default:
          _schedule_day_list = [];
          break;
      }
    } else {
      _schedule_day_list = [];
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    _get_schedule_day();
    var _schedule_time_brush = Paint()
      ..color = Colors.orangeAccent.withOpacity(0.2)
      ..strokeWidth = 1;
    var _hour_brush = Paint()
      ..color = Colors.deepOrangeAccent
      ..strokeWidth = 3;
    var _half_hour_brush = Paint()
      ..color = Colors.black.withOpacity(0.7)
      ..strokeWidth = 2;
    var _quarter_hour_brush = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..strokeWidth = 1;

    _schedule_day_list.forEach((element) {
      // draw available schedule times
      canvas.drawRect(
          Rect.fromLTRB(
              size.width - 1,
              element["start"].hour * 100 + element["start"].minute * 100 / 60,
              40,
              element["end"].hour * 100 + element["end"].minute * 100 / 60),
          _schedule_time_brush);
    });

    for (int i = 0; i < 25; i++) {
      // draw hour lines
      double _height = i * (size.height / 24);
      canvas.drawLine(
          Offset(size.width, _height), Offset(25, _height), _hour_brush);
      // draw hour text
      TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          text: i.toString() /*+ ":00"*/);
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(5, _height - 8));
    }
    for (int i = 0; i < 24; i++) {
      // draw half hour lines
      double _height = i * (size.height / 24) + (size.height / 48);
      canvas.drawLine(
          Offset(size.width, _height), Offset(30, _height), _half_hour_brush);
    }
    for (int i = 0; i < 48; i++) {
      // draw quarter hour lines
      double _height = i * (size.height / 48) + (size.height / 96);
      canvas.drawLine(Offset(size.width, _height), Offset(35, _height),
          _quarter_hour_brush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    return super.hitTest(position);
  }
}

class Day_Calender_Task_Element extends StatefulWidget {
  Map<String, dynamic> task;
  double width;
  Day_Calender_Task_Element({this.task, this.width});
  @override
  _Day_Calender_Task_ElementState createState() =>
      _Day_Calender_Task_ElementState();
}

class _Day_Calender_Task_ElementState extends State<Day_Calender_Task_Element> {
  double _height;

  @override
  void initState() {
    super.initState();
    _height = widget.task["duration"].inMinutes * 100 / 60;
  }

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    return Dismissible(
      key: ValueKey(widget.task),
      background: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        color: Colors.greenAccent,
        child: Icon(
          Icons.done,
        ),
      ),
      secondaryBackground: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        color: Colors.orangeAccent,
        child: Icon(Icons.schedule),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          //TODO: mark task for as done
        }
        if (direction == DismissDirection.endToStart) {
          //TODO: delete task for today
        }
      },
      child: SizedBox(
        width: widget.width,
        height: _height,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              runAlignment: WrapAlignment.spaceBetween,
              children: [
                _height < 75
                    ? Text(widget.task["task"]["title"],
                        style: TextStyle(fontWeight: FontWeight.bold))
                    : Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task["task"]["title"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(intl.DateFormat('dd.MM.yyyy')
                                .format(widget.task["task"]["deadline"])),
                            SizedBox(
                              height: 5,
                            ),
                            Text(printDuration(widget.task["task"]["duration"]))
                          ],
                        ),
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.schedule,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.done,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
