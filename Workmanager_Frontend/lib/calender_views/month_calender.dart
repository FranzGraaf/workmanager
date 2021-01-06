import 'package:Workmanager_Frontend/calender_views/day_calender.dart';
import 'package:Workmanager_Frontend/calender_views/week_calender.dart';
import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:week_of_year/week_of_year.dart';

class Month_Calender extends StatefulWidget {
  static const String route = '/month_calender';
  @override
  _Month_CalenderState createState() => _Month_CalenderState();
}

class _Month_CalenderState extends State<Month_Calender> {
  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;
    return Column(
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
                    global_view_date = DateTime(global_view_date.year,
                        global_view_date.month - 1, global_view_date.day);
                  });
                }),
            Text(
              get_month_name(global_view_date.month) +
                  " " +
                  global_view_date.year.toString(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            IconButton(
                icon: Icon(
                  Icons.arrow_right,
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    global_view_date = DateTime(global_view_date.year,
                        global_view_date.month + 1, global_view_date.day);
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
        /*SizedBox(
          height: 2400,
          child: Stack(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Positioned.fill(
                  child: CustomPaint(painter: Month_Calender_Painter())),
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
          ),
        ),*/
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(2),
          child: Month_Calendar_Month_View(global_view_date),
        )),
        SizedBox(
          height: 70,
        )
      ],
    );
  }
}

class Month_Calender_Painter extends CustomPainter {
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

class Month_Calendar_Month_View extends StatefulWidget {
  DateTime date;
  Month_Calendar_Month_View(this.date);
  @override
  _Month_Calendar_Month_ViewState createState() =>
      _Month_Calendar_Month_ViewState();
}

class _Month_Calendar_Month_ViewState extends State<Month_Calendar_Month_View> {
  int _number_of_weeks = 6;
  int _first_week = 0;
  int _temp_first_week = 0;
  int _last_week = 0;
  List<DateTime> _dates_list = [];

  void _get_number_of_weeks() {
    _first_week = DateTime(widget.date.year, widget.date.month, 1).weekOfYear;
    _last_week = DateTime(widget.date.year, widget.date.month + 1, 1)
        .subtract(Duration(days: 1))
        .weekOfYear;
    _temp_first_week = _first_week;
    if (_first_week > _last_week) {
      // if first week of the year is still counted as last week of last year
      _temp_first_week = 0;
    }
    _number_of_weeks = _last_week - _temp_first_week + 1;
  }

  void _get_dates_list() {
    DateTime temp_date = DateTime(widget.date.year, widget.date.month, 1)
        .subtract(Duration(days: 7));
    _dates_list = [];
    for (int i = 0; i < 45; i++) {
      DateTime i_date = temp_date.add(Duration(days: i));
      int i_week = i_date.weekOfYear;
      if (i_week > _last_week && i_week == _first_week) {
        i_week = 0;
      }
      if (i_week >= _temp_first_week && i_week <= _last_week) {
        _dates_list.add(i_date);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _get_number_of_weeks();
    _get_dates_list();
  }

  @override
  Widget build(BuildContext context) {
    _get_number_of_weeks();
    _get_dates_list();
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;
    double _size = (_screen_size.height - 210) / 7;
    return Table(
      children: [
        TableRow(children: [
          SizedBox(),
          Month_Calendar_Month_View_Weekday(Weekday.mo, _size),
          Month_Calendar_Month_View_Weekday(Weekday.tu, _size),
          Month_Calendar_Month_View_Weekday(Weekday.we, _size),
          Month_Calendar_Month_View_Weekday(Weekday.th, _size),
          Month_Calendar_Month_View_Weekday(Weekday.fr, _size),
          Month_Calendar_Month_View_Weekday(Weekday.sa, _size),
          Month_Calendar_Month_View_Weekday(Weekday.so, _size),
        ]),
        TableRow(children: [
          Month_Calendar_Month_View_Calendarweek(_dates_list[0], _size),
          Month_Calendar_Month_View_Day(
            _dates_list[0],
            _size,
            active: widget.date.month == _dates_list[0].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[1],
            _size,
            active: widget.date.month == _dates_list[1].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[2],
            _size,
            active: widget.date.month == _dates_list[2].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[3],
            _size,
            active: widget.date.month == _dates_list[3].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[4],
            _size,
            active: widget.date.month == _dates_list[4].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[5],
            _size,
            active: widget.date.month == _dates_list[5].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[6],
            _size,
            active: widget.date.month == _dates_list[6].month,
          ),
        ]),
        TableRow(children: [
          Month_Calendar_Month_View_Calendarweek(_dates_list[7], _size),
          Month_Calendar_Month_View_Day(
            _dates_list[7],
            _size,
            active: widget.date.month == _dates_list[7].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[8],
            _size,
            active: widget.date.month == _dates_list[8].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[9],
            _size,
            active: widget.date.month == _dates_list[9].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[10],
            _size,
            active: widget.date.month == _dates_list[10].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[11],
            _size,
            active: widget.date.month == _dates_list[11].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[12],
            _size,
            active: widget.date.month == _dates_list[12].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[13],
            _size,
            active: widget.date.month == _dates_list[13].month,
          ),
        ]),
        TableRow(children: [
          Month_Calendar_Month_View_Calendarweek(_dates_list[14], _size),
          Month_Calendar_Month_View_Day(
            _dates_list[14],
            _size,
            active: widget.date.month == _dates_list[14].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[15],
            _size,
            active: widget.date.month == _dates_list[15].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[16],
            _size,
            active: widget.date.month == _dates_list[16].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[17],
            _size,
            active: widget.date.month == _dates_list[17].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[18],
            _size,
            active: widget.date.month == _dates_list[18].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[19],
            _size,
            active: widget.date.month == _dates_list[19].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[20],
            _size,
            active: widget.date.month == _dates_list[20].month,
          ),
        ]),
        TableRow(children: [
          Month_Calendar_Month_View_Calendarweek(_dates_list[21], _size),
          Month_Calendar_Month_View_Day(
            _dates_list[21],
            _size,
            active: widget.date.month == _dates_list[21].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[22],
            _size,
            active: widget.date.month == _dates_list[22].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[23],
            _size,
            active: widget.date.month == _dates_list[23].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[24],
            _size,
            active: widget.date.month == _dates_list[24].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[25],
            _size,
            active: widget.date.month == _dates_list[25].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[26],
            _size,
            active: widget.date.month == _dates_list[26].month,
          ),
          Month_Calendar_Month_View_Day(
            _dates_list[27],
            _size,
            active: widget.date.month == _dates_list[27].month,
          ),
        ]),
        _number_of_weeks >= 5
            ? TableRow(children: [
                Month_Calendar_Month_View_Calendarweek(_dates_list[28], _size),
                Month_Calendar_Month_View_Day(
                  _dates_list[28],
                  _size,
                  active: widget.date.month == _dates_list[28].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[29],
                  _size,
                  active: widget.date.month == _dates_list[29].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[30],
                  _size,
                  active: widget.date.month == _dates_list[30].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[31],
                  _size,
                  active: widget.date.month == _dates_list[31].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[32],
                  _size,
                  active: widget.date.month == _dates_list[32].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[33],
                  _size,
                  active: widget.date.month == _dates_list[33].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[34],
                  _size,
                  active: widget.date.month == _dates_list[34].month,
                ),
              ])
            : TableRow(children: [for (int i = 0; i < 8; i++) SizedBox()]),
        _number_of_weeks >= 6
            ? TableRow(children: [
                Month_Calendar_Month_View_Calendarweek(_dates_list[35], _size),
                Month_Calendar_Month_View_Day(
                  _dates_list[35],
                  _size,
                  active: widget.date.month == _dates_list[35].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[36],
                  _size,
                  active: widget.date.month == _dates_list[36].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[37],
                  _size,
                  active: widget.date.month == _dates_list[37].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[38],
                  _size,
                  active: widget.date.month == _dates_list[38].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[39],
                  _size,
                  active: widget.date.month == _dates_list[39].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[40],
                  _size,
                  active: widget.date.month == _dates_list[40].month,
                ),
                Month_Calendar_Month_View_Day(
                  _dates_list[41],
                  _size,
                  active: widget.date.month == _dates_list[41].month,
                ),
              ])
            : TableRow(children: [for (int i = 0; i < 8; i++) SizedBox()]),
      ],
    );
  }
}

class Month_Calendar_Month_View_Weekday extends StatefulWidget {
  Weekday weekday;
  double size;
  Month_Calendar_Month_View_Weekday(this.weekday, this.size);
  @override
  _Month_Calendar_Month_View_WeekdayState createState() =>
      _Month_Calendar_Month_View_WeekdayState();
}

class _Month_Calendar_Month_View_WeekdayState
    extends State<Month_Calendar_Month_View_Weekday> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      alignment: Alignment.bottomCenter,
      width: widget.size,
      height: widget.size,
      //color: Colors.redAccent,
      child: Text(get_weekday_name(widget.weekday)),
    );
  }
}

class Month_Calendar_Month_View_Calendarweek extends StatefulWidget {
  DateTime date; // one date of the week
  double size;
  Month_Calendar_Month_View_Calendarweek(this.date, this.size);
  @override
  _Month_Calendar_Month_View_CalendarweekState createState() =>
      _Month_Calendar_Month_View_CalendarweekState();
}

class _Month_Calendar_Month_View_CalendarweekState
    extends State<Month_Calendar_Month_View_Calendarweek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(1),
      width: widget.size,
      height: widget.size,
      child: FlatButton(
        color: Colors.orangeAccent,
        onPressed: () {
          global_view_date = widget.date;
          Navigator.of(context).pushNamed(Week_Calender.route);
        },
        child: Text(
          "KW " + widget.date.weekOfYear.toString(),
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

class Month_Calendar_Month_View_Day extends StatefulWidget {
  DateTime date;
  double size;
  bool active;
  Month_Calendar_Month_View_Day(this.date, this.size, {this.active});
  @override
  _Month_Calendar_Month_View_DayState createState() =>
      _Month_Calendar_Month_View_DayState();
}

class _Month_Calendar_Month_View_DayState
    extends State<Month_Calendar_Month_View_Day> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        global_view_date = widget.date;
        Navigator.of(context).pushNamed(Day_Calender.route);
      },
      child: Container(
        margin: EdgeInsets.all(1),
        alignment: Alignment.center,
        width: widget.size,
        height: widget.size,
        color: widget.active
            ? Colors.orangeAccent.withOpacity(0.3)
            : Colors.blueGrey.withOpacity(0.2),
        child: Text(widget.date.day.toString()),
      ),
    );
  }
}
