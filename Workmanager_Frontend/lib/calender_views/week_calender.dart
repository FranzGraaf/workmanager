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
            height: 700,
            child: Stack(
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
            ),
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
