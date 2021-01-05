import 'package:flutter/material.dart';

class Week_Calender extends StatefulWidget {
  static const String route = '/week_calender';
  @override
  _Week_CalenderState createState() => _Week_CalenderState();
}

class _Week_CalenderState extends State<Week_Calender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("week_calender"),
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
