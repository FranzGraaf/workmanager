import 'package:flutter/material.dart';

class Year_Calender extends StatefulWidget {
  static const String route = '/year_calender';
  @override
  _Year_CalenderState createState() => _Year_CalenderState();
}

class _Year_CalenderState extends State<Year_Calender> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("year_calender"),
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
