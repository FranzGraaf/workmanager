import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:week_of_year/week_of_year.dart';

class Week_Calender extends StatefulWidget {
  static const String route = '/week_calender';
  @override
  _Week_CalenderState createState() => _Week_CalenderState();
}

class _Week_CalenderState extends State<Week_Calender> {
  List<List<Map<String, dynamic>>> _daily_tasks;
  List<DateTime> _day_dates;

  @override
  void initState() {
    super.initState();
    /*_day_dates = [];
    int _day_offset = global_view_date.weekday - 1;
    for (int i = 0; i < 7; i++) {
      _day_dates.add(global_view_date.add(Duration(days: i - _day_offset)));
    }
    _daily_tasks = [[], [], [], [], [], [], []];
    for (int i = 0; i < 7; i++) {
      if (global_user_data != null) {
        //TODO: take processed start and end times for tasks
        global_user_data.tasks_open.forEach((element) {
          _daily_tasks[i].add({
            "start": DateTime(0, 0, 0, 10, 30),
            "duration": Duration(hours: 0, minutes: 45),
            "task": element
          });
        });
      }
    }*/
  }

  @override
  Widget build(BuildContext context) {
    _day_dates = [];
    int _day_offset = global_view_date.weekday - 1;
    for (int i = 0; i < 7; i++) {
      _day_dates.add(global_view_date.add(Duration(days: i - _day_offset)));
    }
    _daily_tasks = [[], [], [], [], [], [], []];
    for (int i = 0; i < 7; i++) {
      if (global_user_data != null) {
        //TODO: take processed start and end times for tasks
        global_user_data.tasks_open.forEach((element) {
          _daily_tasks[i].add({
            "start": DateTime(0, 0, 0, 10, 30),
            "duration": Duration(hours: 11, minutes: 45),
            "task": element
          });
        });
      }
    }

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
                          global_view_date.subtract(Duration(days: 7));
                    });
                  }),
              Text(
                "KW " + global_view_date.weekOfYear.toString(),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 25,
                  ),
                  onPressed: () {
                    setState(() {
                      global_view_date =
                          global_view_date.add(Duration(days: 7));
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
            height: _screen_size.height - 220,
            child: Column(
              children: [
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.mo, _daily_tasks[0], _day_dates[0])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.tu, _daily_tasks[1], _day_dates[1])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.we, _daily_tasks[2], _day_dates[2])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.th, _daily_tasks[3], _day_dates[3])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.fr, _daily_tasks[4], _day_dates[4])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.sa, _daily_tasks[5], _day_dates[5])),
                Expanded(
                    child: Week_Calendar_Element(
                        Weekday.so, _daily_tasks[6], _day_dates[6])),
              ],
            ),
            /*Stack(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Positioned.fill(
                    child: CustomPaint(painter: Week_Calender_Painter())),
                /*Align(
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
              ),*/
              ],
            ),*/
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}

class Week_Calender_Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    // TODO: implement hitTest
    return super.hitTest(position);
  }
}

class Week_Calendar_Element extends StatefulWidget {
  Weekday weekday;
  List<Map<String, dynamic>> task_list;
  DateTime date;
  Week_Calendar_Element(this.weekday, this.task_list, this.date);
  @override
  _Week_Calendar_ElementState createState() => _Week_Calendar_ElementState();
}

class _Week_Calendar_ElementState extends State<Week_Calendar_Element> {
  double _side_width = 80;

  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;

    double _hour_width = (_screen_size.width - _side_width) / 24;
    return Row(
      children: [
        Container(
          width: _side_width,
          //color: Colors.greenAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                get_weekday_name(widget.weekday),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(intl.DateFormat('dd.MM.yyyy').format(widget.date)),
            ],
          ),
        ),
        Expanded(
            child: Container(
          //color: Colors.redAccent,
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                      margin: EdgeInsets.only(top: 1, bottom: 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orangeAccent.withOpacity(0.2)),
                      child: CustomPaint(
                          painter: Week_Calender_Element_Painter()))),
              for (var i in widget.task_list)
                Positioned(
                    left: i["start"].hour * _hour_width +
                        i["start"].minute * _hour_width / 60,
                    child: Week_Calendar_Task_Element(
                      task: i,
                      max_width: _screen_size.width - _side_width,
                      hour_width: _hour_width,
                    ))
            ],
          ),
        ))
      ],
    );
  }
}

class Week_Calender_Element_Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
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

    for (int i = 0; i < 25; i++) {
      // draw hour lines
      double _width = i * (size.width / 24);
      canvas.drawLine(
          Offset(_width, size.height), Offset(_width, 0), _hour_brush);
    }

    for (int i = 0; i < 5; i++) {
      double _time = (i * 4 + 4).toDouble();
      // draw hour text
      TextSpan span = TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 14),
          text: _time.toString());
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, Offset(_time * size.width / 24, size.height / 2 - 7));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  bool hitTest(Offset position) {
    // TODO: implement hitTest
    return super.hitTest(position);
  }
}

class Week_Calendar_Task_Element extends StatefulWidget {
  Map<String, dynamic> task;
  double max_width;
  double hour_width;
  Week_Calendar_Task_Element({this.task, this.max_width, this.hour_width});
  @override
  _Week_Calendar_Task_ElementState createState() =>
      _Week_Calendar_Task_ElementState();
}

class _Week_Calendar_Task_ElementState
    extends State<Week_Calendar_Task_Element> {
  @override
  void initState() {
    super.initState();
    //print(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(widget.task["task"]);
      },
      child: Container(
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Colors.blueAccent.withOpacity(0.5),
        ),
        height: 99999,
        width: widget.task["duration"].inMinutes * widget.hour_width / 60,
        child: Text(widget.task["task"]["title"]),
      ),
    );
  }
}
