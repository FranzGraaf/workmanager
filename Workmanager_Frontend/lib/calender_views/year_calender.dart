import 'package:Workmanager_Frontend/calender_views/month_calender.dart';
import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:Workmanager_Frontend/global_stuff/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class Year_Calender extends StatefulWidget {
  static const String route = '/year_calender';
  @override
  _Year_CalenderState createState() => _Year_CalenderState();
}

class _Year_CalenderState extends State<Year_Calender> {
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
                    global_view_date = DateTime(global_view_date.year - 1,
                        global_view_date.month, global_view_date.day);
                  });
                }),
            Text(
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
                    global_view_date = DateTime(global_view_date.year + 1,
                        global_view_date.month, global_view_date.day);
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
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(2),
          child: Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < 12; i++) Year_Calendar_Month_Symbol(i)
            ],
          ),
        )),
        SizedBox(
          height: 70,
        )
      ],
    );
  }
}

class Year_Calender_Painter extends CustomPainter {
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

class Year_Calendar_Month_Symbol extends StatefulWidget {
  int month;
  Year_Calendar_Month_Symbol(this.month);
  @override
  _Year_Calendar_Month_SymbolState createState() =>
      _Year_Calendar_Month_SymbolState();
}

class _Year_Calendar_Month_SymbolState
    extends State<Year_Calendar_Month_Symbol> {
  @override
  Widget build(BuildContext context) {
    final _screen_size = MediaQuery.of(context).size;
    bool _on_mobile = _screen_size.width < global_mobile_treshold;
    double _size = (_screen_size.width < _screen_size.height
            ? _screen_size.width
            : _screen_size.height) /
        4.6;
    return Container(
      margin: EdgeInsets.all(1),
      padding: EdgeInsets.all(5),
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
            width: 3, color: Colors.deepOrangeAccent.withOpacity(0.5)),
      ),
      child: FlatButton(
          onPressed: () {
            global_view_date = DateTime(
                global_view_date.year, widget.month + 1, global_view_date.day);
            Navigator.of(context).pushNamed(Month_Calender.route);
          },
          child: Text(
            get_month_name(widget.month + 1),
            style: TextStyle(fontSize: _size * 0.15),
          )),
    );
  }
}
