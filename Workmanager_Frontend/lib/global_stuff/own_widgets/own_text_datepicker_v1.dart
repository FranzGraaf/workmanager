import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Own_Text_Datepicker_V1 extends StatefulWidget {
  TextEditingController controller;
  bool enabled;
  bool pick_date;
  bool pick_time;
  EdgeInsets padding;
  DateTime date;
  DateTime first_date;
  String label;
  double width;
  Function(DateTime new_date_time) onValueChanged;
  TextStyle text_style;
  Own_Text_Datepicker_V1({
    this.enabled = true,
    this.pick_date = true,
    this.pick_time = true,
    this.date,
    this.first_date,
    this.label,
    this.width,
    this.onValueChanged,
    this.padding = const EdgeInsets.only(top: 20, bottom: 20),
    this.controller,
    this.text_style,
  });

  @override
  _Own_Text_Datepicker_V1State createState() => _Own_Text_Datepicker_V1State();
}

class _Own_Text_Datepicker_V1State extends State<Own_Text_Datepicker_V1> {
  TextEditingController _date_controller = TextEditingController();

  void _format_text() {
    if (widget.date != null) {
      if (widget.pick_date && widget.pick_time) {
        _date_controller.text =
            DateFormat('dd.MM.yyyy HH:mm').format(widget.date);
      } else if (widget.pick_date) {
        _date_controller.text = DateFormat('dd.MM.yyyy').format(widget.date);
      } else if (widget.pick_time) {
        _date_controller.text = DateFormat('HH:mm').format(widget.date);
      }
    }
  }

  @override
  void initState() {
    if (widget.controller != null) {
      _date_controller = widget.controller;
    }
    _format_text();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: widget.padding,
      child: GestureDetector(
        onTap: () {
          if (widget.enabled) {
            if (widget.pick_date) {
              showDatePicker(
                      context: context,
                      initialDate:
                          widget.date == null ? DateTime.now() : widget.date,
                      firstDate: widget.first_date,
                      lastDate: widget.first_date.add(Duration(days: 2000000)))
                  .then((value) {
                setState(() {
                  if (value != null) {
                    widget.date = DateTime(value.year, value.month, value.day,
                        widget.date.hour, widget.date.minute);
                    _format_text();
                  }
                });
                widget.onValueChanged(widget.date);
              });
            }
            if (widget.pick_time) {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                  widget.date == null ? DateTime.now() : widget.date,
                ),
                builder: (context, child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: true),
                    child: child,
                  );
                },
              ).then((value) {
                setState(() {
                  if (value != null) {
                    widget.date = DateTime(widget.date.year, widget.date.month,
                        widget.date.day, value.hour, value.minute);
                    _format_text();
                  }
                });
                widget.onValueChanged(widget.date);
              });
            }
          }
        },
        child: TextFormField(
          style: widget.text_style,
          enabled: false, //widget.enabled,
          controller: _date_controller,
          keyboardType: TextInputType.datetime,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Icons.calendar_today),
            ),
            labelText: widget.label,
          ),
          onFieldSubmitted: (newValue) {
            try {
              if (widget.pick_date && widget.pick_time) {
                widget.date = DateFormat('dd.MM.yyyy HH:mm').parse(newValue);
              } else if (widget.pick_date) {
                widget.date = DateFormat('dd.MM.yyyy').parse(newValue);
              } else if (widget.pick_time) {
                widget.date = DateFormat('HH:mm').parse(newValue);
              }
            } catch (error) {
              Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                'Datum überprüfen',
                textAlign: TextAlign.center,
              )));
            }
            _format_text();
            widget.onValueChanged(widget.date);
          },
        ),
      ),
    );
  }
}
