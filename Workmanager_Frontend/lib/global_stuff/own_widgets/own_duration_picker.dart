import 'package:Workmanager_Frontend/global_stuff/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class Own_Duration_Picker extends StatefulWidget {
  TextEditingController controller;
  bool enabled;
  EdgeInsets padding;
  Duration duration;
  String label;
  double width;
  Function(Duration new_date_time) onValueChanged;
  TextStyle text_style;
  Own_Duration_Picker({
    this.duration,
    this.enabled = true,
    this.label,
    this.width,
    this.onValueChanged,
    this.padding = const EdgeInsets.only(top: 20, bottom: 20),
    this.controller,
    this.text_style,
  });
  @override
  _Own_Duration_PickerState createState() => _Own_Duration_PickerState();
}

class _Own_Duration_PickerState extends State<Own_Duration_Picker> {
  TextEditingController _duration_controller = TextEditingController();

  void _format_text() {
    _duration_controller.text = printDuration(widget.duration);
  }

  @override
  void initState() {
    if (widget.controller != null) {
      _duration_controller = widget.controller;
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
          Picker(
            adapter: NumberPickerAdapter(data: <NumberPickerColumn>[
              const NumberPickerColumn(
                begin: 0,
                end: 999,
                suffix: Text(' h'),
              ),
              const NumberPickerColumn(
                begin: 0,
                end: 60,
                suffix: Text(' min'),
                jump: 15,
              ),
            ]),
            delimiter: <PickerDelimiter>[
              PickerDelimiter(
                child: Container(
                  width: 30.0,
                  alignment: Alignment.center,
                  child: Icon(Icons.more_vert),
                ),
              )
            ],
            hideHeader: true,
            cancelText: 'Abbrechen',
            confirmText: 'OK',
            //confirmTextStyle: TextStyle(inherit: false, color: Colors.red, fontSize: 22),
            title: const Text('Aufgabendauer'),
            selectedTextStyle: TextStyle(color: Colors.blue),
            onConfirm: (Picker picker, List<int> value) {
              // You get your duration here
              Duration _duration = Duration(
                  hours: picker.getSelectedValues()[0],
                  minutes: picker.getSelectedValues()[1]);
              widget.duration = _duration;
              _format_text();
              widget.onValueChanged(_duration);
            },
          ).showDialog(context);
        },
        child: TextFormField(
          style: widget.text_style,
          enabled: false, //widget.enabled,
          controller: _duration_controller,
          //keyboardType: TextInputType.datetime,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.timer)),
            labelText: widget.label,
          ),
          onFieldSubmitted: (newValue) {},
        ),
      ),
    );
  }
}
