import 'package:flutter/material.dart';

class Month_Calender extends StatefulWidget {
  static const String route = '/month_calender';
  @override
  _Month_CalenderState createState() => _Month_CalenderState();
}

class _Month_CalenderState extends State<Month_Calender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("month_calender"),
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
