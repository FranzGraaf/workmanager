import 'package:flutter/material.dart';
import 'dart:math';

class Own_Rot_Button extends StatefulWidget {
  int duration;
  double start_angle;
  double stop_angle;
  IconData icon;
  bool initopen;
  GestureTapCallback onPressed;

  Own_Rot_Button(
      {this.duration = 100,
      this.start_angle = 0,
      this.stop_angle = -pi / 2,
      this.icon = Icons.arrow_back,
      this.initopen = false,
      this.onPressed});
  @override
  _Own_Rot_ButtonState createState() => _Own_Rot_ButtonState();
}

class _Own_Rot_ButtonState extends State<Own_Rot_Button> {
  double _begin_rot = 0;
  double _end_rot = 0;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initopen;
    if (widget.initopen) {
      _begin_rot = widget.stop_angle;
      _end_rot = widget.stop_angle;
    } else {
      _begin_rot = widget.start_angle;
      _end_rot = widget.start_angle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: widget.duration),
      tween: Tween<double>(begin: _begin_rot, end: _end_rot),
      builder: (context, value, child) {
        return Transform.rotate(
          angle: value,
          child: IconButton(
            icon: Icon(widget.icon),
            onPressed: () {
              widget.onPressed();
              setState(() {
                if (_open) {
                  _open = false;
                  _begin_rot = widget.stop_angle;
                  _end_rot = widget.start_angle;
                } else {
                  _open = true;
                  _begin_rot = widget.start_angle;
                  _end_rot = widget.stop_angle;
                }
              });
            },
          ),
        );
      },
    );
  }
}
